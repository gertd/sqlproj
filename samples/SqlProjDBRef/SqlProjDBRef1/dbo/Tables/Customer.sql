CREATE TABLE [dbo].[Customer] (
    [CustomerId] UNIQUEIDENTIFIER NOT NULL,
    [UserId]     UNIQUEIDENTIFIER NOT NULL,
    [UserName]   VARCHAR (256)    NOT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([CustomerId] ASC)
);