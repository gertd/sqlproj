CREATE TABLE [dbo].aspnet_Users (
    ApplicationId    uniqueidentifier    NOT NULL FOREIGN KEY REFERENCES [dbo].aspnet_Applications(ApplicationId),
    UserId           uniqueidentifier    NOT NULL PRIMARY KEY NONCLUSTERED DEFAULT NEWID(),
    UserName         nvarchar(256)       NOT NULL,
    LoweredUserName  nvarchar(256)	     NOT NULL,
    MobileAlias      nvarchar(16)        DEFAULT NULL,
    IsAnonymous      bit                 NOT NULL DEFAULT 0,
    LastActivityDate DATETIME            NOT NULL)


GO
CREATE UNIQUE CLUSTERED INDEX aspnet_Users_Index ON [dbo].aspnet_Users(ApplicationId, LoweredUserName)


GO
CREATE NONCLUSTERED INDEX aspnet_Users_Index2 ON [dbo].aspnet_Users(ApplicationId, LastActivityDate)

