CREATE MASTER KEY ENCRYPTION BY PASSWORD = '!!VerySecretP@ssw0rd!!'
GO

CREATE QUEUE [writer-queue];
GO
CREATE QUEUE [reader-queue];
GO

CREATE SERVICE [writer-svc] ON QUEUE [writer-queue] ([DEFAULT]);
GO
CREATE SERVICE [reader-svc] ON QUEUE [reader-queue] ([DEFAULT]);
GO

CREATE PROC [dbo].[writer-proc]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @conversation_handle uniqueidentifier;
	DECLARE @message_type_name sysname;
	DECLARE @message_body varbinary(max);

	BEGIN TRANSACTION;

	RECEIVE TOP(1)
			@conversation_handle = conversation_handle,
			@message_type_name = message_type_name,
			@message_body = message_body
	FROM	[writer-queue];

	IF (@conversation_handle IS NOT NULL)
	BEGIN

		IF (@message_type_name = N'http://schemas.microsoft.com/SQL/ServiceBroker/DialogTimer')
		BEGIN
			SEND ON CONVERSATION @conversation_handle MESSAGE TYPE [EndOfStream];
		END
		ELSE IF (@message_type_name = N'http://schemas.microsoft.com/SQL/ServiceBroker/EndDialog')
		BEGIN
			END CONVERSATION @conversation_handle;
		END
		ELSE IF (@message_type_name = N'http://schemas.microsoft.com/SQL/ServiceBroker/Error')
		BEGIN
			END CONVERSATION @conversation_handle;
	
			-- Send error message to ERRORLOG and NT Event Log
			DECLARE @error int;
			DECLARE @description nvarchar(4000);
			WITH XMLNAMESPACES ('http://schemas.microsoft.com/SQL/ServiceBroker/Error' AS ssb)
			SELECT	@error = CAST(@message_body AS XML).value('(//ssb:Error/ssb:Code)[1]', 'INT'),
					@description = CAST(@message_body AS XML).value('(//ssb:Error/ssb:Description)[1]', 'NVARCHAR(4000)')
			RAISERROR(N'Received error Code:%i Description:"%s"', 16, 1, @error, @description) WITH LOG;

		END;
	END;
	COMMIT TRANSACTION;
END;
GO

CREATE PROC [dbo].[pClearMessages]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @message_type_name sysname;
	DECLARE @conversation_handle uniqueidentifier;

	DECLARE @msgtable table
	(
		conversation_handle uniqueidentifier,
		message_type_name sysname
	);

	DECLARE msgcur CURSOR FOR SELECT * FROM @msgtable;        

	BEGIN TRANSACTION;

	WHILE (1=1)
	BEGIN
		RECEIVE	conversation_handle,
				message_type_name
		FROM	[reader-queue]
		INTO	@msgtable;

		IF (@@rowcount = 0)
			BREAK;
	END;

	WHILE (1=1)
	BEGIN
		RECEIVE	conversation_handle,
				message_type_name
		FROM	[writer-queue]
		INTO	@msgtable;

		IF (@@rowcount = 0)
			BREAK;
	END;

	OPEN msgcur;
	FETCH NEXT FROM msgcur INTO @conversation_handle, @message_type_name;

	WHILE (@@fetch_status = 0)
	BEGIN
		IF (@message_type_name = N'http://schemas.microsoft.com/SQL/ServiceBroker/EndDialog')
			END CONVERSATION @conversation_handle;

		FETCH NEXT FROM msgcur INTO @conversation_handle, @message_type_name;
	END;

	CLOSE MSGCUR;

	COMMIT TRANSACTION;

	DEALLOCATE MSGCUR;
END;
GO

CREATE PROC [dbo].[pAddMessage]
@message varbinary(max),
@conversation_handle uniqueidentifier output
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRANSACTION;

	BEGIN DIALOG	@conversation_handle
	FROM SERVICE	[writer-svc]
	TO SERVICE		N'reader-svc', 'CURRENT DATABASE'
	WITH ENCRYPTION = OFF;

	SEND ON CONVERSATION @conversation_handle MESSAGE TYPE [DEFAULT] (@message);

	COMMIT TRANSACTION;

	SELECT @conversation_handle AS conversation_handle;
END
GO

CREATE PROC pPeekMessage 
@numMessages int = 1
AS
BEGIN
	SET NOCOUNT ON;

	SELECT	TOP(@numMessages)
			* 
	FROM	[reader-queue]
	WHERE	[service_contract_id] = 6 AND [message_type_id] = 14
	ORDER	BY [queuing_order]

	RETURN @@rowcount;
END;
GO

CREATE PROC pGetMessage
@numMessages int = 1
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @messages table
	(
		[status] tinyint NOT NULL,
		[priority] tinyint NULL,
		[queuing_order] bigint NOT NULL,
		[conversation_group_id] uniqueidentifier NOT NULL,
		[conversation_handle] uniqueidentifier NOT NULL,
		[message_sequence_number] bigint NOT NULL,
		[service_name] sysname NOT NULL,
		[service_id] int NOT NULL,
		[service_contract_name] sysname NOT NULL,
		[service_contract_id] int NOT NULL,
		[message_type_name] sysname NOT NULL,
		[message_type_id] int NOT NULL,
		[validation] nchar(1) NOT NULL,
		[message_body] varbinary(max) NULL,
		[message_enqueue_time] datetime NULL
	);

	BEGIN TRANSACTION;

	RECEIVE TOP(@numMessages) 
			status,
			priority,
			queuing_order,
			conversation_group_id,
			conversation_handle,
			message_sequence_number,
			service_name,
			service_id,
			service_contract_name,
			service_contract_id,
			message_type_name,
			message_type_id,
			validation,
			message_body,
			message_enqueue_time
	FROM	[reader-queue]
	INTO	@messages;

	COMMIT TRANSACTION;

	SELECT	*
	FROM	@messages
	ORDER	BY [queuing_order];

	RETURN @@rowcount;
END;
GO

CREATE PROC pDeleteMessage
@conversation_handle uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;
	END CONVERSATION @conversation_handle;
END;
GO
