/*
Post-Deployment 
*/

-- tests
DECLARE @conversation_handle uniqueidentifier
DECLARE @message_type_name sysname;
DECLARE @cnt int = 0;
DECLARE @message_string nvarchar(max) = N'Hello Service Broker ' + CONVERT(nvarchar(30), GETDATE());
DECLARE @message varbinary(max) = CONVERT(varbinary(max), @message_string); 

EXEC dbo.pAddMessage @message, @conversation_handle output
EXEC dbo.pAddMessage @message, @conversation_handle output
EXEC dbo.pAddMessage @message, @conversation_handle output
EXEC dbo.pAddMessage @message, @conversation_handle output
EXEC dbo.pAddMessage @message, @conversation_handle output

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

INSERT INTO @messages EXEC dbo.pPeekMessage 1;

SELECT @cnt = COUNT(*) FROM @messages;
IF (@cnt > 1) RAISERROR('Count should be <= 1 == %d', 16, 1, @cnt)

INSERT INTO @messages EXEC dbo.pPeekMessage 10;

SELECT @cnt = COUNT(*) FROM @messages;
IF (@cnt > 10) RAISERROR('Count should be <= 10 == %d ', 16, 1, @cnt)

DELETE @messages;

INSERT INTO @messages EXEC dbo.pGetMessage 1;

SELECT @cnt = COUNT(*) FROM @messages;
IF (@cnt > 1) RAISERROR('Count should be <= 1 == %d', 16, 1, @cnt)

INSERT INTO @messages EXEC dbo.pGetMessage 3;

SELECT @cnt = COUNT(*) FROM @messages;
IF (@cnt > 3) RAISERROR('Count should be <= 3 == %d', 16, 1, @cnt)

DECLARE msgcur CURSOR FOR 
SELECT	conversation_handle, 
		message_type_name 
FROM	@messages;

OPEN	msgcur;

FETCH NEXT FROM msgcur INTO @conversation_handle, @message_type_name;
WHILE (@@fetch_status = 0)
BEGIN
	EXEC pDeleteMessage @conversation_handle
	
	FETCH NEXT FROM msgcur INTO @conversation_handle, @message_type_name;
END;

CLOSE msgcur;
DEALLOCATE msgcur;

EXEC pClearMessages
GO
