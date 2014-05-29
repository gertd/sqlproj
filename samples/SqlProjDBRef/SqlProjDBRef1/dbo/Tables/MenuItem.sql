CREATE TABLE [dbo].[MenuItem] (
    [MenuItemId]      UNIQUEIDENTIFIER NOT NULL,
    [MenuId]          UNIQUEIDENTIFIER NOT NULL,
    [Name]            VARCHAR (128)    NULL,
    [Description]     VARCHAR (512)    NULL,
    [ImageLocation]   VARCHAR (MAX)    NULL,
    [Price]           MONEY            NULL,
    [PreparationTime] INT              NULL,
    CONSTRAINT [PK_MenuItem] PRIMARY KEY CLUSTERED ([MenuItemId] ASC)
);
GO
ALTER TABLE [dbo].[MenuItem]
    ADD CONSTRAINT [FK_MenuItem_Menu] FOREIGN KEY ([MenuId]) REFERENCES [dbo].[Menu] ([MenuId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
CREATE NONCLUSTERED INDEX [NCI_MenuItem_MenuId]
    ON [dbo].[MenuItem]([MenuId] ASC);
GO