CREATE TABLE [dbo].[Restaurant] (
    [RestaurantId]           UNIQUEIDENTIFIER NOT NULL,
    [Name]                   VARCHAR (256)    NULL,
    [Description]            VARCHAR (1024)   NULL,
    [RestaurantCategoryId]   UNIQUEIDENTIFIER NOT NULL,
    [LogoImageLocation]      NVARCHAR (MAX)   NULL,
    [SmallLogoImageLocation] NVARCHAR (MAX)   NULL,
    [BannerImageLocation]    NVARCHAR (MAX)   NULL,
    [MainImageLocation]      NVARCHAR (MAX)   NULL,
    [BackgroundLocation]     NVARCHAR (MAX)   NULL,
    [PostalCode]             VARCHAR (128)    NOT NULL,
    [StreetAddress]          VARCHAR (256)    NULL,
    [City]                   VARCHAR (512)    NULL,
    [State]                  VARCHAR (256)    NULL,
    CONSTRAINT [PK_Restaurant] PRIMARY KEY CLUSTERED ([RestaurantId] ASC)
);
GO
ALTER TABLE [dbo].[Restaurant]
    ADD CONSTRAINT [FK_Restaurant_RestaurantCategory] FOREIGN KEY ([RestaurantCategoryId]) REFERENCES [dbo].[RestaurantCategory] ([RestaurantCategoryId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
CREATE NONCLUSTERED INDEX [NCI_Restaurant_RestaurantCategoryId]
    ON [dbo].[Restaurant]([RestaurantCategoryId] ASC);
GO
