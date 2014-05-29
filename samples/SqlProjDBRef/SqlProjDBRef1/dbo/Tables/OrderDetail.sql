CREATE TABLE [dbo].[OrderDetail] (
    [OrderDetailId]     UNIQUEIDENTIFIER NOT NULL,
    [OrderId]           UNIQUEIDENTIFIER NOT NULL,
    [RestaurantId]      UNIQUEIDENTIFIER NOT NULL,
    [MenuItemId]        UNIQUEIDENTIFIER NOT NULL,
    [DeliveryId]        UNIQUEIDENTIFIER NOT NULL,
    [Quantity]          INT              NOT NULL,
    [UnitCost]          MONEY            NOT NULL,
    [Status]            NCHAR (20)       NOT NULL,
    [StatusUpdatedTime] SMALLDATETIME    NOT NULL,
    [WorkflowId]        UNIQUEIDENTIFIER NOT NULL,
    [ETA]               SMALLDATETIME    NULL,
    CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED ([OrderDetailId] ASC)
);
GO
ALTER TABLE [dbo].[OrderDetail]
    ADD CONSTRAINT [FK_OrderDetail_MenuItem] FOREIGN KEY ([MenuItemId]) REFERENCES [dbo].[MenuItem] ([MenuItemId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [dbo].[OrderDetail]
    ADD CONSTRAINT [FK_OrderDetail_Order2] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Order] ([OrderId]) ON DELETE CASCADE ON UPDATE CASCADE;
GO
ALTER TABLE [dbo].[OrderDetail]
    ADD CONSTRAINT [FK_OrderDetail_Restaurant] FOREIGN KEY ([RestaurantId]) REFERENCES [dbo].[Restaurant] ([RestaurantId]) ON DELETE NO ACTION ON UPDATE CASCADE;
GO
CREATE NONCLUSTERED INDEX [NCI_OrderDetail_MenuItemId]
    ON [dbo].[OrderDetail]([MenuItemId] ASC);
GO
CREATE NONCLUSTERED INDEX [NCI_OrderDetail_OrderId]
    ON [dbo].[OrderDetail]([OrderId] ASC);
GO
CREATE NONCLUSTERED INDEX [NCI_OrderDetail_RestaurantId]
    ON [dbo].[OrderDetail]([RestaurantId] ASC);
GO
