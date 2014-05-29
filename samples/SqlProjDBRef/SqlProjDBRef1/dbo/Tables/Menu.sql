CREATE TABLE [dbo].[Menu] (
    [MenuId]       UNIQUEIDENTIFIER NOT NULL,
    [RestaurantId] UNIQUEIDENTIFIER NOT NULL,
    [StartDate]    DATETIME         NOT NULL,
    [EndDate]      DATETIME         NOT NULL,
    [MenuType]     VARCHAR (50)     NULL,
    CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED ([MenuId] ASC)
);
GO
ALTER TABLE [dbo].[Menu]
    ADD CONSTRAINT [FK_Menu_Restaurant] FOREIGN KEY ([RestaurantId]) REFERENCES [dbo].[Restaurant] ([RestaurantId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
CREATE NONCLUSTERED INDEX [NCI_Menu_RestaurantId]
    ON [dbo].[Menu]([RestaurantId] ASC);
GO
