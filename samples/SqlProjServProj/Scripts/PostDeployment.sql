/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
-- Move from permissions.sql
-- SQL70018: Server level permissions are not allowed.
IF EXISTS(SELECT * FROM sys.sql_logins WHERE name = N'login_test')
BEGIN
	GRANT VIEW SERVER STATE TO login_test;
END
GO

