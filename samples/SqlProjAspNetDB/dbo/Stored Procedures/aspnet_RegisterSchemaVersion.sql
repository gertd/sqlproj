CREATE PROCEDURE [dbo].aspnet_RegisterSchemaVersion
    @Feature                   nvarchar(128),
    @CompatibleSchemaVersion   nvarchar(128),
    @IsCurrentVersion          bit,
    @RemoveIncompatibleSchema  bit
AS
BEGIN
    IF( @RemoveIncompatibleSchema = 1 )
    BEGIN
        DELETE FROM dbo.aspnet_SchemaVersions WHERE Feature = LOWER( @Feature )
    END
    ELSE
    BEGIN
        IF( @IsCurrentVersion = 1 )
        BEGIN
            UPDATE dbo.aspnet_SchemaVersions
            SET IsCurrentVersion = 0
            WHERE Feature = LOWER( @Feature )
        END
    END

    INSERT  dbo.aspnet_SchemaVersions( Feature, CompatibleSchemaVersion, IsCurrentVersion )
    VALUES( LOWER( @Feature ), @CompatibleSchemaVersion, @IsCurrentVersion )
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_Membership_BasicAccess]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_Membership_ReportingAccess]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_Profile_BasicAccess]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_Profile_ReportingAccess]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_Roles_BasicAccess]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_Roles_ReportingAccess]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_Personalization_BasicAccess]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_Personalization_ReportingAccess]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_RegisterSchemaVersion] TO [aspnet_WebEvent_FullAccess]
    AS [dbo];

