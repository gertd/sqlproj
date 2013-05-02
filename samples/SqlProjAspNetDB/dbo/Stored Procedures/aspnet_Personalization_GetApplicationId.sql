CREATE PROCEDURE dbo.aspnet_Personalization_GetApplicationId (
    @ApplicationName NVARCHAR(256),
    @ApplicationId UNIQUEIDENTIFIER OUT)
AS
BEGIN
    SELECT @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aspnet_Personalization_GetApplicationId] TO [aspnet_Personalization_BasicAccess]
    AS [dbo];

