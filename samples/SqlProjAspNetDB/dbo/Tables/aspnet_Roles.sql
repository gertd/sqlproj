CREATE TABLE dbo.aspnet_Roles (
        ApplicationId    uniqueidentifier    NOT NULL FOREIGN KEY REFERENCES dbo.aspnet_Applications(ApplicationId),
        RoleId           uniqueidentifier    PRIMARY KEY  NONCLUSTERED DEFAULT NEWID(),
        RoleName         nvarchar(256)       NOT NULL,
        LoweredRoleName  nvarchar(256)       NOT NULL,
        Description      nvarchar(256)       )


GO
CREATE UNIQUE  CLUSTERED  INDEX aspnet_Roles_index1 ON  dbo.aspnet_Roles(ApplicationId, LoweredRoleName)

