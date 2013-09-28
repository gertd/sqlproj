CREATE TABLE [dbo].aspnet_Applications (
    ApplicationName         nvarchar(256)               NOT NULL UNIQUE,
    LoweredApplicationName  nvarchar(256)               NOT NULL UNIQUE,
    ApplicationId           uniqueidentifier            PRIMARY KEY NONCLUSTERED DEFAULT NEWID(),
    Description             nvarchar(256)       )


GO
CREATE CLUSTERED INDEX aspnet_Applications_Index ON [dbo].aspnet_Applications(LoweredApplicationName)

