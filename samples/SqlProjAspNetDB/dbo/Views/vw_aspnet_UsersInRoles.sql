
  CREATE VIEW [dbo].[vw_aspnet_UsersInRoles]
  AS SELECT [dbo].[aspnet_UsersInRoles].[UserId], [dbo].[aspnet_UsersInRoles].[RoleId]
  FROM [dbo].[aspnet_UsersInRoles]
  
GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_UsersInRoles] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];

