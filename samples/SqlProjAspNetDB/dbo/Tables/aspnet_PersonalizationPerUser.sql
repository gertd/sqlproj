CREATE TABLE dbo.aspnet_PersonalizationPerUser (
        Id               UNIQUEIDENTIFIER NOT NULL PRIMARY KEY NONCLUSTERED DEFAULT NEWID(),
        PathId           UNIQUEIDENTIFIER FOREIGN KEY REFERENCES dbo.aspnet_Paths (PathId),
        UserId           UNIQUEIDENTIFIER FOREIGN KEY REFERENCES dbo.aspnet_Users (UserId),
        PageSettings     IMAGE NOT NULL,
        LastUpdatedDate  DATETIME NOT NULL)


GO



GO
CREATE UNIQUE CLUSTERED INDEX aspnet_PersonalizationPerUser_index1 ON [dbo].[aspnet_PersonalizationPerUser](PathId,UserId)


GO
CREATE UNIQUE INDEX aspnet_PersonalizationPerUser_ncindex2 ON [dbo].[aspnet_PersonalizationPerUser](UserId,PathId)

