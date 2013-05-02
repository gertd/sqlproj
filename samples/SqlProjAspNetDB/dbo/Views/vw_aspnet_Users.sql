
  CREATE VIEW [dbo].[vw_aspnet_Users]
  AS SELECT [dbo].[aspnet_Users].[ApplicationId], [dbo].[aspnet_Users].[UserId], [dbo].[aspnet_Users].[UserName], [dbo].[aspnet_Users].[LoweredUserName], [dbo].[aspnet_Users].[MobileAlias], [dbo].[aspnet_Users].[IsAnonymous], [dbo].[aspnet_Users].[LastActivityDate]
  FROM [dbo].[aspnet_Users]
  
GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_Users] TO [aspnet_Membership_ReportingAccess]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_Users] TO [aspnet_Profile_ReportingAccess]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_Users] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_aspnet_Users] TO [aspnet_Personalization_ReportingAccess]
    AS [dbo];

