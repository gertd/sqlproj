CREATE PROCEDURE [dbo].aspnet_CheckSchemaVersion
    @Feature                   nvarchar(128),
    @CompatibleSchemaVersion   nvarchar(128)
AS
BEGIN
    IF (EXISTS( SELECT  *
                FROM    dbo.aspnet_SchemaVersions
                WHERE   Feature = LOWER( @Feature ) AND
                        CompatibleSchemaVersion = @CompatibleSchemaVersion ))
        RETURN 0

    RETURN 1
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_Membership_BasicAccess]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_Membership_ReportingAccess]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_Profile_BasicAccess]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_Profile_ReportingAccess]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_Roles_BasicAccess]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_Personalization_BasicAccess]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_Personalization_ReportingAccess]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_CheckSchemaVersion] TO [aspnet_WebEvent_FullAccess]
    AS [dbo];

