CREATE TABLE dbo.aspnet_Paths (
        ApplicationId    UNIQUEIDENTIFIER    NOT NULL FOREIGN KEY REFERENCES dbo.aspnet_Applications(ApplicationId),
        PathId            UNIQUEIDENTIFIER   PRIMARY KEY NONCLUSTERED DEFAULT NEWID(),
        Path              NVARCHAR(256)      NOT NULL,
        LoweredPath       NVARCHAR(256)      NOT NULL)


GO
CREATE UNIQUE CLUSTERED INDEX aspnet_Paths_index ON dbo.aspnet_Paths(ApplicationId, LoweredPath)

