CREATE TABLE [dbo].[OrderPayment] (
    [PaymentID]        UNIQUEIDENTIFIER NOT NULL,
    [OrderID]          UNIQUEIDENTIFIER NOT NULL,
    [CreditCardNumber] CHAR (4)         NULL,
    [NameOnCard]       VARCHAR (75)     NULL,
    [Address]          VARCHAR (50)     NULL,
    [Country]          VARCHAR (50)     NULL,
    [City]             VARCHAR (50)     NULL,
    [State]            VARCHAR (50)     NULL,
    [PostalCode]       CHAR (10)        NULL,
    [ExpirationDate]   SMALLDATETIME    NULL,
    [CreditCardType]   VARCHAR (50)     NULL,
    CONSTRAINT [PK_OrderPayment] PRIMARY KEY CLUSTERED ([PaymentID] ASC)
);
GO
ALTER TABLE [dbo].[OrderPayment]
    ADD CONSTRAINT [FK_OrderPayment_Order] FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Order] ([OrderId]) ON DELETE CASCADE ON UPDATE CASCADE;
GO
CREATE NONCLUSTERED INDEX [NCI_OrderPayment_OrderID]
    ON [dbo].[OrderPayment]([OrderID] ASC);
GO
