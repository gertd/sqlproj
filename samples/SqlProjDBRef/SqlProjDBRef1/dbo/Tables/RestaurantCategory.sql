CREATE TABLE [dbo].[RestaurantCategory] (
    [RestaurantCategoryId] UNIQUEIDENTIFIER NOT NULL,
    [Description]          VARCHAR (255)    NOT NULL,
    CONSTRAINT [PK_RestaurantCategory] PRIMARY KEY CLUSTERED ([RestaurantCategoryId] ASC)
);