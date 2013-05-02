CREATE TABLE dbo.aspnet_UsersInRoles (
        UserId     uniqueidentifier NOT NULL PRIMARY KEY(UserId, RoleId) FOREIGN KEY REFERENCES dbo.aspnet_Users (UserId),
        RoleId     uniqueidentifier NOT NULL FOREIGN KEY REFERENCES dbo.aspnet_Roles (RoleId))


GO
CREATE INDEX aspnet_UsersInRoles_index ON  dbo.aspnet_UsersInRoles(RoleId)

