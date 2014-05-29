CREATE TABLE [dbo].[Order] (
    [OrderId]          UNIQUEIDENTIFIER NOT NULL,
    [SubmittedDate]    SMALLDATETIME    NOT NULL,
    [CustomerID]       UNIQUEIDENTIFIER NOT NULL,
    [Total]            MONEY            NOT NULL,
    [ContactTelephone] CHAR (20)        NULL,
    [PostalCode]       CHAR (10)        NULL,
    [State]            CHAR (2)         NULL,
    [StreetAddress]    VARCHAR (75)     NULL,
    [City]             VARCHAR (25)     NULL,
	[Status]           INT              NOT NULL CONSTRAINT [DF_Order_Status] DEFAULT 0,
	[StatusString] as dbo.GetEnumStringValue('STATUS', [Status]),
    CONSTRAINT [PK_Order2] PRIMARY KEY CLUSTERED ([OrderId] ASC),
	CONSTRAINT [CK_Order_Status] CHECK (dbo.IsEnumValueInRange('STATUS',[Status]) = 1)
);
GO
ALTER TABLE [dbo].[Order]
    ADD CONSTRAINT [FK_Order2_Customer] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customer] ([CustomerId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
CREATE NONCLUSTERED INDEX [NCI_Order_CustomerID]
    ON [dbo].[Order]([CustomerID] ASC);
GO
