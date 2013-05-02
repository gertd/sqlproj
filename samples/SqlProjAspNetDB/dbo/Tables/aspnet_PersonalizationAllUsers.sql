CREATE TABLE dbo.aspnet_PersonalizationAllUsers (
        PathId            UNIQUEIDENTIFIER PRIMARY KEY FOREIGN KEY REFERENCES dbo.aspnet_Paths (PathId),
        PageSettings     IMAGE NOT NULL,
        LastUpdatedDate  DATETIME NOT NULL)


GO


