
/**********************************************************************/
/* InstallCommon.SQL                                                  */
/*                                                                    */
/* Installs the tables, triggers and stored procedures necessary for  */
/* supporting some features of ASP.Net                                */
/*
** Copyright Microsoft, Inc. 2003
** All Rights Reserved.
*/
/**********************************************************************/

PRINT '---------------------------------------'
GO

PRINT 'Starting execution of InstallCommon.SQL'
GO

PRINT '---------------------------------------'
GO

SET QUOTED_IDENTIFIER OFF
GO

SET ANSI_NULLS ON         -- We don't want (NULL = NULL) == TRUE
GO

SET ANSI_PADDING ON
GO

SET ANSI_NULL_DFLT_ON ON
GO

USE [aspnetdb]
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
-- Create the temporary permission tables and stored procedures
-- TO preserve the permissions of an object.
--
-- We use this method instead of using CREATE (if the object
-- doesn't exist) and ALTER (if the object exists) because the
-- latter one either requires the use of dynamic SQL (which we want to
-- avoid) or writing the body of the object (e.g. an SP or view) twice,
-- once use CREATE and again using ALTER.


IF (OBJECT_ID('tempdb.#aspnet_Permissions') IS NOT NULL)
BEGIN
    DROP TABLE #aspnet_Permissions
END
GO

CREATE TABLE #aspnet_Permissions
(
    Owner     sysname,
    Object    sysname,
    Grantee   sysname,
    Grantor   sysname,
    ProtectType char(10),
    [Action]    varchar(60),
    [Column]    sysname
)
GO

INSERT INTO #aspnet_Permissions
EXEC sp_helprotect
GO

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Setup_RestorePermissions')
               AND (type = 'P')))
DROP PROCEDURE [dbo].aspnet_Setup_RestorePermissions
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Setup_RemoveAllRoleMembers')
               AND (type = 'P')))
DROP PROCEDURE [dbo].aspnet_Setup_RemoveAllRoleMembers
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
-- Create the aspnet_Applications table.

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_Applications')
                  AND (type = 'U')))
BEGIN
  PRINT 'Creating the aspnet_Applications table...'
  --The following statement was imported into the database project as a schema object and named dbo.aspnet_Applications.
--CREATE TABLE [dbo].aspnet_Applications (
--    ApplicationName         nvarchar(256)               NOT NULL UNIQUE,
--    LoweredApplicationName  nvarchar(256)               NOT NULL UNIQUE,
--    ApplicationId           uniqueidentifier            PRIMARY KEY NONCLUSTERED DEFAULT NEWID(),
--    Description             nvarchar(256)       )

  --The following statement was imported into the database project as a schema object and named dbo.aspnet_Applications.aspnet_Applications_Index.
--CREATE CLUSTERED INDEX aspnet_Applications_Index ON [dbo].aspnet_Applications(LoweredApplicationName)

END
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
-- Create the aspnet_Users table
IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_Users')
                  AND (type = 'U')))
BEGIN
  PRINT 'Creating the aspnet_Users table...'
  --The following statement was imported into the database project as a schema object and named dbo.aspnet_Users.
--CREATE TABLE [dbo].aspnet_Users (
--    ApplicationId    uniqueidentifier    NOT NULL FOREIGN KEY REFERENCES [dbo].aspnet_Applications(ApplicationId),
--    UserId           uniqueidentifier    NOT NULL PRIMARY KEY NONCLUSTERED DEFAULT NEWID(),
--    UserName         nvarchar(256)       NOT NULL,
--    LoweredUserName  nvarchar(256)	     NOT NULL,
--    MobileAlias      nvarchar(16)        DEFAULT NULL,
--    IsAnonymous      bit                 NOT NULL DEFAULT 0,
--    LastActivityDate DATETIME            NOT NULL)


   --The following statement was imported into the database project as a schema object and named dbo.aspnet_Users.aspnet_Users_Index.
--CREATE UNIQUE CLUSTERED INDEX aspnet_Users_Index ON [dbo].aspnet_Users(ApplicationId, LoweredUserName)

   --The following statement was imported into the database project as a schema object and named dbo.aspnet_Users.aspnet_Users_Index2.
--CREATE NONCLUSTERED INDEX aspnet_Users_Index2 ON [dbo].aspnet_Users(ApplicationId, LastActivityDate)

END
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
-- Create the aspnet_SchemaVersions table
IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_SchemaVersions')
                  AND (type = 'U')))
BEGIN
  PRINT 'Creating the aspnet_SchemaVersions table...'
  --The following statement was imported into the database project as a schema object and named dbo.aspnet_SchemaVersions.
--CREATE TABLE [dbo].aspnet_SchemaVersions (
--    Feature                  nvarchar(128)  NOT NULL PRIMARY KEY CLUSTERED( Feature, CompatibleSchemaVersion ),
--    CompatibleSchemaVersion  nvarchar(128)	NOT NULL,
--    IsCurrentVersion         bit            NOT NULL )

END
GO

/*************************************************************/
/*************************************************************/
------------- Create Stored Procedures
/*************************************************************/
/*************************************************************/
-- RegisterSchemaVersion SP

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_RegisterSchemaVersion')
               AND (type = 'P')))
DROP PROCEDURE [dbo].aspnet_RegisterSchemaVersion
GO

-- Restore the permissions
EXEC [dbo].aspnet_Setup_RestorePermissions N'aspnet_RegisterSchemaVersion'
GO

-- Create common schema version
EXEC [dbo].aspnet_RegisterSchemaVersion N'Common', N'1', 1, 1
GO

/*************************************************************/
/*************************************************************/
-- CheckSchemaVersion SP

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_CheckSchemaVersion')
               AND (type = 'P')))
DROP PROCEDURE [dbo].aspnet_CheckSchemaVersion
GO

-- Restore the permissions
EXEC [dbo].aspnet_Setup_RestorePermissions N'aspnet_CheckSchemaVersion'
GO

/*************************************************************/
/*************************************************************/
-- CreateApplication SP

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Applications_CreateApplication')
               AND (type = 'P')))
DROP PROCEDURE [dbo].aspnet_Applications_CreateApplication
GO

-- Restore the permissions
EXEC [dbo].aspnet_Setup_RestorePermissions N'aspnet_Applications_CreateApplication'
GO

/*************************************************************/
/*************************************************************/
-- UnRegisterSchemaVersion SP

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_UnRegisterSchemaVersion')
               AND (type = 'P')))
DROP PROCEDURE [dbo].aspnet_UnRegisterSchemaVersion
GO

-- Restore the permissions
EXEC [dbo].aspnet_Setup_RestorePermissions N'aspnet_UnRegisterSchemaVersion'
GO

/*************************************************************/
/*************************************************************/
-- CreateUser SP

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Users_CreateUser')
               AND (type = 'P')))
DROP PROCEDURE [dbo].aspnet_Users_CreateUser
GO

-- Restore the permissions
EXEC [dbo].aspnet_Setup_RestorePermissions N'aspnet_Users_CreateUser'
GO

/*************************************************************/
/*************************************************************/
--- DeleteUser SP

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Users_DeleteUser')
               AND (type = 'P')))
DROP PROCEDURE [dbo].aspnet_Users_DeleteUser
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

-- Restore the permissions
EXEC [dbo].aspnet_Setup_RestorePermissions N'aspnet_Users_DeleteUser'
GO

/*************************************************************/
/*************************************************************/
--- aspnet_AnyDataInTables SP

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_AnyDataInTables')
               AND (type = 'P')))
DROP PROCEDURE [dbo].aspnet_AnyDataInTables
GO

-- Restore the permissions
EXEC [dbo].aspnet_Setup_RestorePermissions N'aspnet_AnyDataInTables'
GO

/*************************************************************/
/*************************************************************/

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'vw_aspnet_Applications')
                  AND (type = 'V')))
BEGIN
  PRINT 'Creating the vw_aspnet_Applications view...'
  EXEC('
  CREATE VIEW [dbo].[vw_aspnet_Applications]
  AS SELECT [dbo].[aspnet_Applications].[ApplicationName], [dbo].[aspnet_Applications].[LoweredApplicationName], [dbo].[aspnet_Applications].[ApplicationId], [dbo].[aspnet_Applications].[Description]
  FROM [dbo].[aspnet_Applications]
  ')
END
GO

-- Restore the permissions
EXEC [dbo].aspnet_Setup_RestorePermissions N'vw_aspnet_Applications'
GO

/*************************************************************/
/*************************************************************/

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'vw_aspnet_Users')
                  AND (type = 'V')))
BEGIN
  PRINT 'Creating the vw_aspnet_Users view...'
  EXEC('
  CREATE VIEW [dbo].[vw_aspnet_Users]
  AS SELECT [dbo].[aspnet_Users].[ApplicationId], [dbo].[aspnet_Users].[UserId], [dbo].[aspnet_Users].[UserName], [dbo].[aspnet_Users].[LoweredUserName], [dbo].[aspnet_Users].[MobileAlias], [dbo].[aspnet_Users].[IsAnonymous], [dbo].[aspnet_Users].[LastActivityDate]
  FROM [dbo].[aspnet_Users]
  ')
END
GO

-- Restore the permissions
EXEC [dbo].aspnet_Setup_RestorePermissions N'vw_aspnet_Users'
GO

DROP TABLE #aspnet_Permissions
GO

PRINT '----------------------------------------'
GO

PRINT 'Completed execution of InstallCommon.SQL'
GO

PRINT '----------------------------------------'
GO

/**********************************************************************/
/* InstallMembership.SQL                                              */
/*                                                                    */
/* Installs the tables, triggers and stored procedures necessary for  */
/* supporting the aspnet feature of ASP.Net                           */
/*                                                                    */
/* InstallCommon.sql must be run before running this file.            */
/*
** Copyright Microsoft, Inc. 2002
** All Rights Reserved.
*/
/**********************************************************************/

PRINT '-------------------------------------------'
GO

PRINT 'Starting execution of InstallMembership.SQL'
GO

PRINT '-------------------------------------------'
GO

SET QUOTED_IDENTIFIER OFF
GO

SET ANSI_NULLS ON         -- We don't want (NULL = NULL) == TRUE
GO

SET ANSI_PADDING ON
GO

SET ANSI_NULL_DFLT_ON ON
GO

USE [aspnetdb]
GO

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_Applications')
                  AND (type = 'U')))
BEGIN
  RAISERROR('The table ''aspnet_Applications'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_Users')
                  AND (type = 'U')))
BEGIN
  RAISERROR('The table ''aspnet_Users'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

IF (NOT EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Applications_CreateApplication')
               AND (type = 'P')))
BEGIN
  RAISERROR('The stored procedure ''aspnet_Applications_CreateApplication'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

IF (NOT EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Users_CreateUser')
               AND (type = 'P')))
BEGIN
  RAISERROR('The stored procedure ''aspnet_Users_CreateUser'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

IF (NOT EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Users_DeleteUser')
               AND (type = 'P')))
BEGIN
  RAISERROR('The stored procedure ''aspnet_Users_DeleteUser'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

/*************************************************************/
/*************************************************************/
IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_Membership')
                  AND (type = 'U')))
BEGIN
  PRINT 'Creating the aspnet_Membership table...'
  --The following statement was imported into the database project as a schema object and named dbo.aspnet_Membership.
--CREATE TABLE dbo.aspnet_Membership (
--        ApplicationId                           uniqueidentifier    NOT NULL FOREIGN KEY REFERENCES dbo.aspnet_Applications(ApplicationId),
--        UserId                                  uniqueidentifier    NOT NULL PRIMARY KEY NONCLUSTERED FOREIGN KEY REFERENCES dbo.aspnet_Users(UserId),
--        Password                                nvarchar(128)       NOT NULL,
--        PasswordFormat                          int                 NOT NULL DEFAULT 0,
--        PasswordSalt                            nvarchar(128)       NOT NULL,
--        MobilePIN                               nvarchar(16),
--        Email                                   nvarchar(256),
--        LoweredEmail                            nvarchar(256),
--        PasswordQuestion                        nvarchar(256),
--        PasswordAnswer                          nvarchar(128),
--        IsApproved                              bit                 NOT NULL,
--        IsLockedOut                             bit                 NOT NULL,
--        CreateDate                              datetime            NOT NULL,
--        LastLoginDate                           datetime            NOT NULL,
--        LastPasswordChangedDate                 datetime            NOT NULL,
--        LastLockoutDate                         datetime            NOT NULL,
--        FailedPasswordAttemptCount              int                 NOT NULL,
--        FailedPasswordAttemptWindowStart        datetime            NOT NULL,
--        FailedPasswordAnswerAttemptCount        int                 NOT NULL,
--        FailedPasswordAnswerAttemptWindowStart  datetime            NOT NULL,
--        Comment                                 ntext )

  --The following statement was imported into the database project as a schema object and named dbo.aspnet_Membership.aspnet_Membership_index.
--CREATE CLUSTERED INDEX aspnet_Membership_index ON aspnet_Membership(ApplicationId, LoweredEmail)

END
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Membership_GetUserByName')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_GetUserByName
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Membership_GetUserByUserId')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_GetUserByUserId
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Membership_GetUserByEmail')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_GetUserByEmail
GO

/*************************************************************/
/*************************************************************/

IF ( EXISTS( SELECT name
             FROM sysobjects
             WHERE ( name = N'aspnet_Membership_GetPasswordWithFormat' )
                   AND ( type = 'P' ) ) )
DROP PROCEDURE dbo.aspnet_Membership_GetPasswordWithFormat
GO

/*************************************************************/
/*************************************************************/

IF ( EXISTS( SELECT name
             FROM sysobjects
             WHERE ( name = N'aspnet_Membership_UpdateUserInfo' )
                   AND ( type = 'P' ) ) )
DROP PROCEDURE dbo.aspnet_Membership_UpdateUserInfo
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Membership_GetPassword')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_GetPassword
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Membership_SetPassword')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_SetPassword
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Membership_ResetPassword')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_ResetPassword
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Membership_UnlockUser')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_UnlockUser
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Membership_UpdateUser')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_UpdateUser
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Membership_ChangePasswordQuestionAndAnswer')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_ChangePasswordQuestionAndAnswer
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Membership_GetAllUsers')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_GetAllUsers
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Membership_GetNumberOfUsersOnline')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_GetNumberOfUsersOnline
GO

/*************************************************************/
/*************************************************************/
IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Membership_FindUsersByName')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_FindUsersByName
GO

/*************************************************************/
/*************************************************************/
IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Membership_FindUsersByEmail')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_FindUsersByEmail
GO

/*************************************************************/
/*************************************************************/

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'vw_aspnet_MembershipUsers')
                  AND (type = 'V')))
BEGIN
  PRINT 'Creating the vw_aspnet_MembershipUsers view...'
  EXEC('
  CREATE VIEW [dbo].[vw_aspnet_MembershipUsers]
  AS SELECT [dbo].[aspnet_Membership].[UserId],
            [dbo].[aspnet_Membership].[PasswordFormat],
            [dbo].[aspnet_Membership].[MobilePIN],
            [dbo].[aspnet_Membership].[Email],
            [dbo].[aspnet_Membership].[LoweredEmail],
            [dbo].[aspnet_Membership].[PasswordQuestion],
            [dbo].[aspnet_Membership].[PasswordAnswer],
            [dbo].[aspnet_Membership].[IsApproved],
            [dbo].[aspnet_Membership].[IsLockedOut],
            [dbo].[aspnet_Membership].[CreateDate],
            [dbo].[aspnet_Membership].[LastLoginDate],
            [dbo].[aspnet_Membership].[LastPasswordChangedDate],
            [dbo].[aspnet_Membership].[LastLockoutDate],
            [dbo].[aspnet_Membership].[FailedPasswordAttemptCount],
            [dbo].[aspnet_Membership].[FailedPasswordAttemptWindowStart],
            [dbo].[aspnet_Membership].[FailedPasswordAnswerAttemptCount],
            [dbo].[aspnet_Membership].[FailedPasswordAnswerAttemptWindowStart],
            [dbo].[aspnet_Membership].[Comment],
            [dbo].[aspnet_Users].[ApplicationId],
            [dbo].[aspnet_Users].[UserName],
            [dbo].[aspnet_Users].[MobileAlias],
            [dbo].[aspnet_Users].[IsAnonymous],
            [dbo].[aspnet_Users].[LastActivityDate]
  FROM [dbo].[aspnet_Membership] INNER JOIN [dbo].[aspnet_Users]
      ON [dbo].[aspnet_Membership].[UserId] = [dbo].[aspnet_Users].[UserId]
  ')
END
GO

EXEC [dbo].aspnet_RegisterSchemaVersion N'Membership', N'1', 1, 1
GO

/*************************************************************/
/*************************************************************/

--
--Create Membership roles
--

IF ( NOT EXISTS ( SELECT name
                  FROM sysusers
                  WHERE issqlrole = 1
                  AND name = N'aspnet_Membership_FullAccess'  ) )
EXEC sp_addrole N'aspnet_Membership_FullAccess'
GO

IF ( NOT EXISTS ( SELECT name
                  FROM sysusers
                  WHERE issqlrole = 1
                  AND name = N'aspnet_Membership_BasicAccess'  ) )
EXEC sp_addrole N'aspnet_Membership_BasicAccess'
GO

IF ( NOT EXISTS ( SELECT name
                  FROM sysusers
                  WHERE issqlrole = 1
                  AND name = N'aspnet_Membership_ReportingAccess'  ) )
EXEC sp_addrole N'aspnet_Membership_ReportingAccess'
GO

PRINT '--------------------------------------------'
GO

PRINT 'Completed execution of InstallMembership.SQL'
GO

PRINT '--------------------------------------------'
GO

/*********************************************************************
  InstallPersistSqlState.SQL                                                
                                                                    
  Installs the tables, and stored procedures necessary for           
  supporting ASP.NET session state.                                  

  Copyright Microsoft, Inc.
  All Rights Reserved.

 *********************************************************************/

SET QUOTED_IDENTIFIER OFF
GO

SET ANSI_NULLS ON
GO

PRINT ''
GO

PRINT '------------------------------------------------'
GO

PRINT 'Starting execution of InstallPersistSqlState.SQL'
GO

PRINT '------------------------------------------------'
GO

PRINT ''
GO

PRINT '--------------------------------------------------'
GO

PRINT 'Note:                                             '
GO

PRINT 'This file is included for backward compatibility  '
GO

PRINT 'only.  You should use aspnet_regsql.exe to install'
GO

PRINT 'and uninstall SQL session state.                  '
GO

PRINT ''
GO

PRINT 'Run ''aspnet_regsql.exe -?'' for details.         '
GO

PRINT '--------------------------------------------------'
GO

/*****************************************************************************/

USE master
GO

/* Create and populate the session state database */

IF DB_ID(N'ASPState') IS NULL BEGIN
    DECLARE @cmd nvarchar(500)
    SET @cmd = N'CREATE DATABASE [ASPState]'
    EXEC(@cmd)
END
GO

IF OBJECT_ID(N'dbo.ASPStateTempSessions','U') IS NOT NULL BEGIN
    DROP TABLE dbo.ASPStateTempSessions
END
GO

IF OBJECT_ID(N'dbo.ASPStateTempApplications','U') IS NOT NULL BEGIN
    DROP TABLE dbo.ASPStateTempApplications
END
GO

USE [ASPState]
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'GetMajorVersion') AND (type = 'P')))
    DROP PROCEDURE [dbo].GetMajorVersion
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'CreateTempTables') AND (type = 'P')))
    DROP PROCEDURE [dbo].CreateTempTables
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetVersion') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetVersion
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'GetHashCode') AND (type = 'P')))
    DROP PROCEDURE [dbo].GetHashCode
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetAppID') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetAppID
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItem') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItem
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItem2') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItem2
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItem3') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItem3
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItemExclusive') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItemExclusive
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItemExclusive2') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItemExclusive2
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItemExclusive3') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItemExclusive3
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempReleaseStateItemExclusive') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempReleaseStateItemExclusive
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempInsertUninitializedItem') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempInsertUninitializedItem
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempInsertStateItemShort') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempInsertStateItemShort
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempInsertStateItemLong') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempInsertStateItemLong
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemShort') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemShort
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemShortNullLong') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemShortNullLong
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemLong') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemLong
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemLongNullShort') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemLongNullShort
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempRemoveStateItem') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempRemoveStateItem
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempResetTimeout') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempResetTimeout
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'DeleteExpiredSessions') AND (type = 'P')))
    DROP PROCEDURE [dbo].DeleteExpiredSessions
GO

IF EXISTS(SELECT name FROM systypes WHERE name ='tSessionId')
    EXECUTE sp_droptype tSessionId
GO

IF EXISTS(SELECT name FROM systypes WHERE name ='tAppName')
    EXECUTE sp_droptype tAppName
GO

IF EXISTS(SELECT name FROM systypes WHERE name ='tSessionItemShort')
    EXECUTE sp_droptype tSessionItemShort
GO

IF EXISTS(SELECT name FROM systypes WHERE name ='tSessionItemLong')
    EXECUTE sp_droptype tSessionItemLong
GO

IF EXISTS(SELECT name FROM systypes WHERE name ='tTextPtr')
    EXECUTE sp_droptype tTextPtr
GO

/*****************************************************************************/

EXECUTE sp_addtype tSessionId, 'nvarchar(88)',  'NOT NULL'
GO

EXECUTE sp_addtype tAppName, 'varchar(280)', 'NOT NULL'
GO

EXECUTE sp_addtype tSessionItemShort, 'varbinary(7000)'
GO

EXECUTE sp_addtype tSessionItemLong, 'image'
GO

EXECUTE sp_addtype tTextPtr, 'varbinary(16)'
GO

/*****************************************************************************/

EXECUTE dbo.CreateTempTables
GO

USE master
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

PRINT ''
GO

PRINT '-------------------------------------------------'
GO

PRINT 'Completed execution of InstallPersistSqlState.SQL'
GO

PRINT '-------------------------------------------------'
GO

/**********************************************************************/
/* InstallPersonalization.SQL                                         */
/*                                                                    */
/* Installs the tables, triggers and stored procedures necessary for  */
/* supporting the personalization feature of ASP.NET                  */
/*                                                                    */
/* InstallCommon.sql must be run before running this file.            */
/*
** Copyright Microsoft, Inc. 2002
** All Rights Reserved.
*/
/**********************************************************************/

PRINT '------------------------------------------------'
GO

PRINT 'Starting execution of InstallPersonalization.SQL'
GO

PRINT '------------------------------------------------'
GO

SET QUOTED_IDENTIFIER OFF
GO

SET ANSI_NULLS ON         -- We don't want (NULL = NULL) == TRUE
GO

SET ANSI_PADDING ON
GO

SET ANSI_NULL_DFLT_ON ON
GO

USE [aspnetdb]
GO

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_Applications')
                  AND (type = 'U')))
BEGIN
  RAISERROR('The table ''aspnet_Applications'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_Users')
                  AND (type = 'U')))
BEGIN
  RAISERROR('The table ''aspnet_Users'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

IF (NOT EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Applications_CreateApplication')
               AND (type = 'P')))
BEGIN
  RAISERROR('The stored procedure ''aspnet_Applications_CreateApplication'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

IF (NOT EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Users_CreateUser')
               AND (type = 'P')))
BEGIN
  RAISERROR('The stored procedure ''aspnet_Users_CreateUser'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

IF (NOT EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Users_DeleteUser')
               AND (type = 'P')))
BEGIN
  RAISERROR('The stored procedure ''aspnet_Users_DeleteUser'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

/***************************************************************************************************************************/
/***************************************************************************************************************************/

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_Paths')
                  AND (type = 'U')))
BEGIN
  PRINT 'Creating the aspnet_Paths table...'
  --The following statement was imported into the database project as a schema object and named dbo.aspnet_Paths.
--CREATE TABLE dbo.aspnet_Paths (
--        ApplicationId    UNIQUEIDENTIFIER    NOT NULL FOREIGN KEY REFERENCES dbo.aspnet_Applications(ApplicationId),
--        PathId            UNIQUEIDENTIFIER   PRIMARY KEY NONCLUSTERED DEFAULT NEWID(),
--        Path              NVARCHAR(256)      NOT NULL,
--        LoweredPath       NVARCHAR(256)      NOT NULL)

  --The following statement was imported into the database project as a schema object and named dbo.aspnet_Paths.aspnet_Paths_index.
--CREATE UNIQUE CLUSTERED INDEX aspnet_Paths_index ON dbo.aspnet_Paths(ApplicationId, LoweredPath)

END
GO

/***************************************************************************************************************************/
/***************************************************************************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Personalization_GetApplicationId')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Personalization_GetApplicationId
GO

/***************************************************************************************************************************/
/***************************************************************************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Paths_CreatePath')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Paths_CreatePath
GO

/***************************************************************************************************************************/

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_PersonalizationAllUsers')
                  AND (type = 'U')))
BEGIN
  PRINT 'Creating the aspnet_PersonalizationAllUsers table...'
  --The following statement was imported into the database project as a schema object and named dbo.aspnet_PersonalizationAllUsers.
--CREATE TABLE dbo.aspnet_PersonalizationAllUsers (
--        PathId            UNIQUEIDENTIFIER PRIMARY KEY FOREIGN KEY REFERENCES dbo.aspnet_Paths (PathId),
--        PageSettings     IMAGE NOT NULL,
--        LastUpdatedDate  DATETIME NOT NULL)

END
GO

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_PersonalizationPerUser')
                  AND (type = 'U')))
BEGIN
  PRINT 'Creating the aspnet_PersonalizationPerUser table...'
  --The following statement was imported into the database project as a schema object and named dbo.aspnet_PersonalizationPerUser.
--CREATE TABLE dbo.aspnet_PersonalizationPerUser (
--        Id               UNIQUEIDENTIFIER NOT NULL PRIMARY KEY NONCLUSTERED DEFAULT NEWID(),
--        PathId           UNIQUEIDENTIFIER FOREIGN KEY REFERENCES dbo.aspnet_Paths (PathId),
--        UserId           UNIQUEIDENTIFIER FOREIGN KEY REFERENCES dbo.aspnet_Users (UserId),
--        PageSettings     IMAGE NOT NULL,
--        LastUpdatedDate  DATETIME NOT NULL)

  --The following statement was imported into the database project as a schema object and named dbo.aspnet_PersonalizationPerUser.aspnet_PersonalizationPerUser_index1.
--CREATE UNIQUE CLUSTERED INDEX aspnet_PersonalizationPerUser_index1 ON [dbo].[aspnet_PersonalizationPerUser](PathId,UserId)

  --The following statement was imported into the database project as a schema object and named dbo.aspnet_PersonalizationPerUser.aspnet_PersonalizationPerUser_ncindex2.
--CREATE UNIQUE INDEX aspnet_PersonalizationPerUser_ncindex2 ON [dbo].[aspnet_PersonalizationPerUser](UserId,PathId)

END
GO

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_PersonalizationAllUsers_GetPageSettings')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_PersonalizationAllUsers_GetPageSettings
GO

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_PersonalizationAllUsers_ResetPageSettings')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_PersonalizationAllUsers_ResetPageSettings
GO

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_PersonalizationAllUsers_SetPageSettings')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_PersonalizationAllUsers_SetPageSettings
GO

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_PersonalizationPerUser_GetPageSettings')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_PersonalizationPerUser_GetPageSettings
GO

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_PersonalizationPerUser_ResetPageSettings')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_PersonalizationPerUser_ResetPageSettings
GO

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_PersonalizationPerUser_SetPageSettings')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_PersonalizationPerUser_SetPageSettings
GO

/*************************************************************/
/* Personalization Administration                            */
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_PersonalizationAdministration_DeleteAllState')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_PersonalizationAdministration_DeleteAllState
GO

/*************************************************************/
IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_PersonalizationAdministration_ResetSharedState')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_PersonalizationAdministration_ResetSharedState
GO

/*************************************************************/
IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_PersonalizationAdministration_ResetUserState')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_PersonalizationAdministration_ResetUserState
GO

/*************************************************************/
IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_PersonalizationAdministration_FindState')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_PersonalizationAdministration_FindState
GO

/*************************************************************/
IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_PersonalizationAdministration_GetCountOfState')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_PersonalizationAdministration_GetCountOfState
GO

/*************************************************************/
/*************************************************************/

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'vw_aspnet_WebPartState_Paths')
                  AND (type = 'V')))
BEGIN
  PRINT 'Creating the vw_aspnet_WebPartState_Paths view...'
  EXEC(N'
  CREATE VIEW [dbo].[vw_aspnet_WebPartState_Paths]
  AS SELECT [dbo].[aspnet_Paths].[ApplicationId], [dbo].[aspnet_Paths].[PathId], [dbo].[aspnet_Paths].[Path], [dbo].[aspnet_Paths].[LoweredPath]
  FROM [dbo].[aspnet_Paths]
  ')
END
GO

/*************************************************************/
/*************************************************************/

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'vw_aspnet_WebPartState_Shared')
                  AND (type = 'V')))
BEGIN
  PRINT 'Creating the vw_aspnet_WebPartState_Shared view...'
  EXEC(N'
  CREATE VIEW [dbo].[vw_aspnet_WebPartState_Shared]
  AS SELECT [dbo].[aspnet_PersonalizationAllUsers].[PathId], [DataSize]=DATALENGTH([dbo].[aspnet_PersonalizationAllUsers].[PageSettings]), [dbo].[aspnet_PersonalizationAllUsers].[LastUpdatedDate]
  FROM [dbo].[aspnet_PersonalizationAllUsers]
  ')
END
GO

/*************************************************************/
/*************************************************************/

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'vw_aspnet_WebPartState_User')
                  AND (type = 'V')))
BEGIN
  PRINT 'Creating the vw_aspnet_WebPartState_User view...'
  EXEC(N'
  CREATE VIEW [dbo].[vw_aspnet_WebPartState_User]
  AS SELECT [dbo].[aspnet_PersonalizationPerUser].[PathId], [dbo].[aspnet_PersonalizationPerUser].[UserId], [DataSize]=DATALENGTH([dbo].[aspnet_PersonalizationPerUser].[PageSettings]), [dbo].[aspnet_PersonalizationPerUser].[LastUpdatedDate]
  FROM [dbo].[aspnet_PersonalizationPerUser]
  ')
END
GO

EXEC [dbo].aspnet_RegisterSchemaVersion N'Personalization', N'1', 1, 1
GO

/*************************************************************/
/*************************************************************/

--
--Create Personalization roles
--

IF ( NOT EXISTS ( SELECT name
                  FROM sysusers
                  WHERE issqlrole = 1
                  AND name = N'aspnet_Personalization_FullAccess'  ) )
EXEC sp_addrole N'aspnet_Personalization_FullAccess'
GO

IF ( NOT EXISTS ( SELECT name
                  FROM dbo.sysusers
                  WHERE issqlrole = 1
                  AND name = N'aspnet_Personalization_BasicAccess'  ) )
EXEC sp_addrole N'aspnet_Personalization_BasicAccess'
GO

IF ( NOT EXISTS ( SELECT name
                  FROM sysusers
                  WHERE issqlrole = 1
                  AND name = N'aspnet_Personalization_ReportingAccess'  ) )
EXEC sp_addrole N'aspnet_Personalization_ReportingAccess'
GO

--
--Stored Procedure rights for BasicAccess
--
GRANT EXECUTE ON dbo.aspnet_Paths_CreatePath TO aspnet_Personalization_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_PersonalizationAllUsers_GetPageSettings TO aspnet_Personalization_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_PersonalizationPerUser_GetPageSettings TO aspnet_Personalization_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_PersonalizationAllUsers_ResetPageSettings TO aspnet_Personalization_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_PersonalizationPerUser_ResetPageSettings TO aspnet_Personalization_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_PersonalizationAllUsers_SetPageSettings TO aspnet_Personalization_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_PersonalizationPerUser_SetPageSettings TO aspnet_Personalization_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_Personalization_GetApplicationId TO aspnet_Personalization_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_CheckSchemaVersion TO aspnet_Personalization_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_RegisterSchemaVersion TO aspnet_Personalization_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_UnRegisterSchemaVersion TO aspnet_Personalization_BasicAccess
GO

--
--Stored Procedure rights for ReportingAccess
--
GRANT EXECUTE ON dbo.aspnet_PersonalizationAdministration_FindState TO aspnet_Personalization_ReportingAccess
GO

GRANT EXECUTE ON dbo.aspnet_PersonalizationAdministration_GetCountOfState TO aspnet_Personalization_ReportingAccess
GO

GRANT EXECUTE ON dbo.aspnet_CheckSchemaVersion TO aspnet_Personalization_ReportingAccess
GO

GRANT EXECUTE ON dbo.aspnet_RegisterSchemaVersion TO aspnet_Personalization_ReportingAccess
GO

GRANT EXECUTE ON dbo.aspnet_UnRegisterSchemaVersion TO aspnet_Personalization_ReportingAccess
GO

--
--Additional stored procedure rights for FullAccess
--
GRANT EXECUTE ON dbo.aspnet_PersonalizationAdministration_ResetUserState TO aspnet_Personalization_FullAccess
GO

GRANT EXECUTE ON dbo.aspnet_PersonalizationAdministration_ResetSharedState TO aspnet_Personalization_FullAccess
GO

GRANT EXECUTE ON dbo.aspnet_PersonalizationAdministration_DeleteAllState TO aspnet_Personalization_FullAccess
GO

--
--View rights
--
GRANT SELECT ON dbo.vw_aspnet_Applications TO aspnet_Personalization_ReportingAccess
GO

GRANT SELECT ON dbo.vw_aspnet_Users TO aspnet_Personalization_ReportingAccess
GO

GRANT SELECT ON dbo.vw_aspnet_WebPartState_Paths TO aspnet_Personalization_ReportingAccess
GO

GRANT SELECT ON dbo.vw_aspnet_WebPartState_Shared TO aspnet_Personalization_ReportingAccess
GO

GRANT SELECT ON dbo.vw_aspnet_WebPartState_User TO aspnet_Personalization_ReportingAccess
GO

PRINT '-------------------------------------------------'
GO

PRINT 'Completed execution of InstallPersonalization.SQL'
GO

PRINT '-------------------------------------------------'
GO

/**********************************************************************/
/* InstallProfile.SQL                                         */
/*                                                                    */
/* Installs the tables, triggers and stored procedures necessary for  */
/* supporting the aspnet feature of ASP.Net                           */
/*                                                                    */
/* InstallCommon.sql must be run before running this file.            */
/*
** Copyright Microsoft, Inc. 2002
** All Rights Reserved.
*/
/**********************************************************************/

PRINT '------------------------------------------------'
GO

PRINT 'Starting execution of InstallProfile.SQL'
GO

PRINT '------------------------------------------------'
GO

SET QUOTED_IDENTIFIER OFF
GO

-- We don't use quoted identifiers
SET ANSI_NULLS ON         -- We don't want (NULL = NULL) == TRUE
GO

SET ANSI_PADDING ON
GO

SET ANSI_NULL_DFLT_ON ON
GO

USE [aspnetdb]
GO

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_Applications')
                  AND (type = 'U')))
BEGIN
  RAISERROR('The table ''aspnet_Applications'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_Users')
                  AND (type = 'U')))
BEGIN
  RAISERROR('The table ''aspnet_Users'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

IF (NOT EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Applications_CreateApplication')
               AND (type = 'P')))
BEGIN
  RAISERROR('The stored procedure ''aspnet_Applications_CreateApplication'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

IF (NOT EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Users_CreateUser')
               AND (type = 'P')))
BEGIN
  RAISERROR('The stored procedure ''aspnet_Users_CreateUser'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

IF (NOT EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Users_DeleteUser')
               AND (type = 'P')))
BEGIN
  RAISERROR('The stored procedure ''aspnet_Users_DeleteUser'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_Profile')
                  AND (type = 'U')))
BEGIN
  PRINT 'Creating the aspnet_Profile table...'
  --The following statement was imported into the database project as a schema object and named dbo.aspnet_Profile.
--CREATE TABLE dbo.aspnet_Profile (
--        UserId                   uniqueidentifier   PRIMARY KEY FOREIGN KEY REFERENCES dbo.aspnet_Users(UserId),
--        PropertyNames            ntext NOT NULL,
--        PropertyValuesString     ntext NOT NULL,
--        PropertyValuesBinary     image NOT NULL,
--        LastUpdatedDate          datetime NOT NULL)

END
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Profile_GetProperties')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Profile_GetProperties
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Profile_SetProperties')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Profile_SetProperties
GO

/*************************************************************/
/*************************************************************/
IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Profile_DeleteProfiles')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Profile_DeleteProfiles
GO

/*************************************************************/
/*************************************************************/
IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Profile_DeleteInactiveProfiles')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Profile_DeleteInactiveProfiles
GO

/*************************************************************/
/*************************************************************/
 IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Profile_GetNumberOfInactiveProfiles')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Profile_GetNumberOfInactiveProfiles
GO

/*************************************************************/
/*************************************************************/
IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Profile_GetProfiles')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Profile_GetProfiles
GO

/*************************************************************/
/*************************************************************/
IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'vw_aspnet_Profiles')
                  AND (type = 'V')))
BEGIN
  PRINT 'Creating the vw_aspnet_Profiles view...'
  EXEC(N'
  CREATE VIEW [dbo].[vw_aspnet_Profiles]
  AS SELECT [dbo].[aspnet_Profile].[UserId], [dbo].[aspnet_Profile].[LastUpdatedDate],
      [DataSize]=  DATALENGTH([dbo].[aspnet_Profile].[PropertyNames])
                 + DATALENGTH([dbo].[aspnet_Profile].[PropertyValuesString])
                 + DATALENGTH([dbo].[aspnet_Profile].[PropertyValuesBinary])
  FROM [dbo].[aspnet_Profile]
  ')
END
GO

EXEC [dbo].aspnet_RegisterSchemaVersion N'Profile', N'1', 1, 1
GO

/*************************************************************/
/*************************************************************/

--
--Create Profile roles
--

IF ( NOT EXISTS ( SELECT name
                  FROM sysusers
                  WHERE issqlrole = 1
                  AND name = N'aspnet_Profile_FullAccess' ) )
EXEC sp_addrole N'aspnet_Profile_FullAccess'
GO

IF ( NOT EXISTS ( SELECT name
                  FROM sysusers
                  WHERE issqlrole = 1
                  AND name = N'aspnet_Profile_BasicAccess' ) )
EXEC sp_addrole N'aspnet_Profile_BasicAccess'
GO

IF ( NOT EXISTS ( SELECT name
                  FROM sysusers
                  WHERE issqlrole = 1
                  AND name = N'aspnet_Profile_ReportingAccess' ) )
EXEC sp_addrole N'aspnet_Profile_ReportingAccess'
GO

--
--Stored Procedure rights for BasicAccess
--
GRANT EXECUTE ON dbo.aspnet_Profile_GetProperties TO aspnet_Profile_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_Profile_SetProperties TO aspnet_Profile_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_CheckSchemaVersion TO aspnet_Profile_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_RegisterSchemaVersion TO aspnet_Profile_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_UnRegisterSchemaVersion TO aspnet_Profile_BasicAccess
GO

--
--Stored Procedure rights for ReportingAccess
--
GRANT EXECUTE ON dbo.aspnet_Profile_GetNumberOfInactiveProfiles TO aspnet_Profile_ReportingAccess
GO

GRANT EXECUTE ON dbo.aspnet_Profile_GetProfiles TO aspnet_Profile_ReportingAccess
GO

GRANT EXECUTE ON dbo.aspnet_CheckSchemaVersion TO aspnet_Profile_ReportingAccess
GO

GRANT EXECUTE ON dbo.aspnet_RegisterSchemaVersion TO aspnet_Profile_ReportingAccess
GO

GRANT EXECUTE ON dbo.aspnet_UnRegisterSchemaVersion TO aspnet_Profile_ReportingAccess
GO

--
--Additional stored procedure rights for FullAccess
--
GRANT EXECUTE ON dbo.aspnet_Profile_DeleteProfiles TO aspnet_Profile_FullAccess
GO

GRANT EXECUTE ON dbo.aspnet_Profile_DeleteInactiveProfiles TO aspnet_Profile_FullAccess
GO

--
--View rights
--
GRANT SELECT ON dbo.vw_aspnet_Applications TO aspnet_Profile_ReportingAccess
GO

GRANT SELECT ON dbo.vw_aspnet_Users TO aspnet_Profile_ReportingAccess
GO

GRANT SELECT ON dbo.vw_aspnet_Profiles TO aspnet_Profile_ReportingAccess
GO

PRINT '-------------------------------------------------'
GO

PRINT 'Completed execution of InstallProfile.SQL'
GO

PRINT '-------------------------------------------------'
GO

/**********************************************************************/
/* InstallRoles.SQL                                                   */
/*                                                                    */
/* Installs the tables, triggers and stored procedures necessary for  */
/* supporting the aspnet feature of ASP.Net                           */
/*                                                                    */
/* InstallCommon.sql must be run before running this file.            */
/*
** Copyright Microsoft, Inc. 2002
** All Rights Reserved.
*/
/**********************************************************************/

PRINT '--------------------------------------'
GO

PRINT 'Starting execution of InstallRoles.SQL'
GO

PRINT '--------------------------------------'
GO

SET QUOTED_IDENTIFIER OFF
GO

-- We don't use quoted identifiers
SET ANSI_NULLS ON         -- We don't want (NULL = NULL) == TRUE
GO

SET ANSI_PADDING ON
GO

SET ANSI_NULL_DFLT_ON ON
GO

USE [aspnetdb]
GO

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_Applications')
                  AND (type = 'U')))
BEGIN
  RAISERROR('The table ''aspnet_Applications'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_Users')
                  AND (type = 'U')))
BEGIN
  RAISERROR('The table ''aspnet_Users'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

IF (NOT EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Applications_CreateApplication')
               AND (type = 'P')))
BEGIN
  RAISERROR('The stored procedure ''aspnet_Applications_CreateApplication'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

IF (NOT EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Users_CreateUser')
               AND (type = 'P')))
BEGIN
  RAISERROR('The stored procedure ''aspnet_Users_CreateUser'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

IF (NOT EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Users_DeleteUser')
               AND (type = 'P')))
BEGIN
  RAISERROR('The stored procedure ''aspnet_Users_DeleteUser'' cannot be found. Please use aspnet_regsql.exe for installing ASP.NET application services.', 18, 1)
END
GO

/*************************************************************/
/*************************************************************/

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_Roles')
                  AND (type = 'U')))
BEGIN
  PRINT 'Creating the aspnet_Roles table...'
  --The following statement was imported into the database project as a schema object and named dbo.aspnet_Roles.
--CREATE TABLE dbo.aspnet_Roles (
--        ApplicationId    uniqueidentifier    NOT NULL FOREIGN KEY REFERENCES dbo.aspnet_Applications(ApplicationId),
--        RoleId           uniqueidentifier    PRIMARY KEY  NONCLUSTERED DEFAULT NEWID(),
--        RoleName         nvarchar(256)       NOT NULL,
--        LoweredRoleName  nvarchar(256)       NOT NULL,
--        Description      nvarchar(256)       )

 --The following statement was imported into the database project as a schema object and named dbo.aspnet_Roles.aspnet_Roles_index1.
--CREATE UNIQUE  CLUSTERED  INDEX aspnet_Roles_index1 ON  dbo.aspnet_Roles(ApplicationId, LoweredRoleName)

END
GO

/*************************************************************/
/*************************************************************/

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_UsersInRoles')
                  AND (type = 'U')))
BEGIN
  PRINT 'Creating the aspnet_UsersInRoles table...'
  --The following statement was imported into the database project as a schema object and named dbo.aspnet_UsersInRoles.
--CREATE TABLE dbo.aspnet_UsersInRoles (
--        UserId     uniqueidentifier NOT NULL PRIMARY KEY(UserId, RoleId) FOREIGN KEY REFERENCES dbo.aspnet_Users (UserId),
--        RoleId     uniqueidentifier NOT NULL FOREIGN KEY REFERENCES dbo.aspnet_Roles (RoleId))


  --The following statement was imported into the database project as a schema object and named dbo.aspnet_UsersInRoles.aspnet_UsersInRoles_index.
--CREATE INDEX aspnet_UsersInRoles_index ON  dbo.aspnet_UsersInRoles(RoleId)

END
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_UsersInRoles_IsUserInRole')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_UsersInRoles_IsUserInRole
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_UsersInRoles_GetRolesForUser')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_UsersInRoles_GetRolesForUser
GO

/*************************************************************/
/*************************************************************/
IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Roles_CreateRole')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Roles_CreateRole
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Roles_DeleteRole')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Roles_DeleteRole
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Roles_RoleExists')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Roles_RoleExists
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_UsersInRoles_AddUsersToRoles')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_UsersInRoles_AddUsersToRoles
GO

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_UsersInRoles_RemoveUsersFromRoles')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_UsersInRoles_RemoveUsersFromRoles
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_UsersInRoles_GetUsersInRoles')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_UsersInRoles_GetUsersInRoles
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_UsersInRoles_FindUsersInRole')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_UsersInRoles_FindUsersInRole
GO

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Roles_GetAllRoles')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Roles_GetAllRoles
GO

/*************************************************************/
/*************************************************************/

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'vw_aspnet_Roles')
                  AND (type = 'V')))
BEGIN
  PRINT 'Creating the vw_aspnet_Roles view...'
  EXEC(N'
  CREATE VIEW [dbo].[vw_aspnet_Roles]
  AS SELECT [dbo].[aspnet_Roles].[ApplicationId], [dbo].[aspnet_Roles].[RoleId], [dbo].[aspnet_Roles].[RoleName], [dbo].[aspnet_Roles].[LoweredRoleName], [dbo].[aspnet_Roles].[Description]
  FROM [dbo].[aspnet_Roles]
  ')
END
GO

/*************************************************************/
/*************************************************************/

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'vw_aspnet_UsersInRoles')
                  AND (type = 'V')))
BEGIN
  PRINT 'Creating the vw_aspnet_UsersInRoles view...'
  EXEC(N'
  CREATE VIEW [dbo].[vw_aspnet_UsersInRoles]
  AS SELECT [dbo].[aspnet_UsersInRoles].[UserId], [dbo].[aspnet_UsersInRoles].[RoleId]
  FROM [dbo].[aspnet_UsersInRoles]
  ')
END
GO

EXEC [dbo].aspnet_RegisterSchemaVersion N'Role Manager', N'1', 1, 1
GO

/*************************************************************/
/*************************************************************/

--
--Create Role Manager roles
--

IF ( NOT EXISTS ( SELECT name
                  FROM sysusers
                  WHERE issqlrole = 1
                  AND name = N'aspnet_Roles_FullAccess'  ) )
EXEC sp_addrole N'aspnet_Roles_FullAccess'
GO

IF ( NOT EXISTS ( SELECT name
                  FROM sysusers
                  WHERE issqlrole = 1
                  AND name = N'aspnet_Roles_BasicAccess'  ) )
EXEC sp_addrole N'aspnet_Roles_BasicAccess'
GO

IF ( NOT EXISTS ( SELECT name
                  FROM sysusers
                  WHERE issqlrole = 1
                  AND name = N'aspnet_Roles_ReportingAccess'  ) )
EXEC sp_addrole N'aspnet_Roles_ReportingAccess'
GO

--
--Stored Procedure rights for BasicAccess
--
GRANT EXECUTE ON dbo.aspnet_UsersInRoles_IsUserInRole TO aspnet_Roles_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_UsersInRoles_GetRolesForUser TO aspnet_Roles_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_CheckSchemaVersion TO aspnet_Roles_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_RegisterSchemaVersion TO aspnet_Roles_BasicAccess
GO

GRANT EXECUTE ON dbo.aspnet_UnRegisterSchemaVersion TO aspnet_Roles_BasicAccess
GO

--
--Stored Procedure rights for ReportingAccess
--
GRANT EXECUTE ON dbo.aspnet_UsersInRoles_IsUserInRole TO aspnet_Roles_ReportingAccess
GO

GRANT EXECUTE ON dbo.aspnet_UsersInRoles_GetRolesForUser TO aspnet_Roles_ReportingAccess
GO

GRANT EXECUTE ON dbo.aspnet_Roles_RoleExists TO aspnet_Roles_ReportingAccess
GO

GRANT EXECUTE ON dbo.aspnet_UsersInRoles_GetUsersInRoles TO aspnet_Roles_ReportingAccess
GO

GRANT EXECUTE ON dbo.aspnet_UsersInRoles_FindUsersInRole TO aspnet_Roles_ReportingAccess
GO

GRANT EXECUTE ON dbo.aspnet_Roles_GetAllRoles TO aspnet_Roles_ReportingAccess
GO

GRANT EXECUTE ON dbo.aspnet_CheckSchemaVersion TO aspnet_Roles_ReportingAccess
GO

GRANT EXECUTE ON dbo.aspnet_RegisterSchemaVersion TO aspnet_Roles_ReportingAccess
GO

GRANT EXECUTE ON dbo.aspnet_UnRegisterSchemaVersion TO aspnet_Roles_ReportingAccess
GO

--
--Additional stored procedure rights for FullAccess
--

GRANT EXECUTE ON dbo.aspnet_Roles_CreateRole TO aspnet_Roles_FullAccess
GO

GRANT EXECUTE ON dbo.aspnet_Roles_DeleteRole TO aspnet_Roles_FullAccess
GO

GRANT EXECUTE ON dbo.aspnet_UsersInRoles_AddUsersToRoles TO aspnet_Roles_FullAccess
GO

GRANT EXECUTE ON dbo.aspnet_UsersInRoles_RemoveUsersFromRoles TO aspnet_Roles_FullAccess
GO

--
--View rights
--
GRANT SELECT ON dbo.vw_aspnet_Applications TO aspnet_Roles_ReportingAccess
GO

GRANT SELECT ON dbo.vw_aspnet_Users TO aspnet_Roles_ReportingAccess
GO

GRANT SELECT ON dbo.vw_aspnet_Roles TO aspnet_Roles_ReportingAccess
GO

GRANT SELECT ON dbo.vw_aspnet_UsersInRoles TO aspnet_Roles_ReportingAccess
GO

PRINT '---------------------------------------'
GO

PRINT 'Completed execution of InstallRoles.SQL'
GO

PRINT '---------------------------------------'
GO

/*********************************************************************
  InstallSqlState.SQL                                                
                                                                    
  Installs the tables, and stored procedures necessary for           
  supporting ASP.NET session state.                                  

  Copyright Microsoft, Inc.
  All Rights Reserved.

 *********************************************************************/

SET QUOTED_IDENTIFIER OFF
GO

SET ANSI_NULLS ON
GO

PRINT ''
GO

PRINT '-----------------------------------------'
GO

PRINT 'Starting execution of InstallSqlState.SQL'
GO

PRINT '-----------------------------------------'
GO

PRINT '--------------------------------------------------'
GO

PRINT 'Note:                                             '
GO

PRINT 'Do not run this file manually.                    '
GO

PRINT 'You should use aspnet_regsql.exe to install       '
GO

PRINT 'and uninstall SQL session state.                  '
GO

PRINT ''
GO

PRINT 'Run ''aspnet_regsql.exe -?'' for details.         '
GO

PRINT '--------------------------------------------------'
GO

/*****************************************************************************/

USE master
GO

/* Create and populate the session state database */

IF DB_ID(N'ASPState') IS NULL BEGIN
    DECLARE @cmd nvarchar(500)
    SET @cmd = N'CREATE DATABASE [ASPState]'
    EXEC(@cmd)
END
GO

IF OBJECT_ID(N'dbo.ASPStateTempSessions','U') IS NOT NULL BEGIN
    DROP TABLE dbo.ASPStateTempSessions
END
GO

IF OBJECT_ID(N'dbo.ASPStateTempApplications','U') IS NOT NULL BEGIN
    DROP TABLE dbo.ASPStateTempApplications
END
GO

USE [ASPState]
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'GetMajorVersion') AND (type = 'P')))
    DROP PROCEDURE [dbo].GetMajorVersion
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'CreateTempTables') AND (type = 'P')))
    DROP PROCEDURE [dbo].CreateTempTables
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetVersion') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetVersion
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'GetHashCode') AND (type = 'P')))
    DROP PROCEDURE [dbo].GetHashCode
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetAppID') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetAppID
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItem') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItem
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItem2') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItem2
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItem3') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItem3
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItemExclusive') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItemExclusive
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItemExclusive2') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItemExclusive2
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItemExclusive3') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItemExclusive3
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempReleaseStateItemExclusive') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempReleaseStateItemExclusive
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempInsertUninitializedItem') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempInsertUninitializedItem
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempInsertStateItemShort') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempInsertStateItemShort
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempInsertStateItemLong') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempInsertStateItemLong
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemShort') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemShort
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemShortNullLong') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemShortNullLong
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemLong') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemLong
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemLongNullShort') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemLongNullShort
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempRemoveStateItem') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempRemoveStateItem
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempResetTimeout') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempResetTimeout
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'DeleteExpiredSessions') AND (type = 'P')))
    DROP PROCEDURE [dbo].DeleteExpiredSessions
GO

IF EXISTS(SELECT name FROM systypes WHERE name ='tSessionId')
    EXECUTE sp_droptype tSessionId
GO

IF EXISTS(SELECT name FROM systypes WHERE name ='tAppName')
    EXECUTE sp_droptype tAppName
GO

IF EXISTS(SELECT name FROM systypes WHERE name ='tSessionItemShort')
    EXECUTE sp_droptype tSessionItemShort
GO

IF EXISTS(SELECT name FROM systypes WHERE name ='tSessionItemLong')
    EXECUTE sp_droptype tSessionItemLong
GO

IF EXISTS(SELECT name FROM systypes WHERE name ='tTextPtr')
    EXECUTE sp_droptype tTextPtr
GO

/*****************************************************************************/

EXECUTE sp_addtype tSessionId, 'nvarchar(88)',  'NOT NULL'
GO

EXECUTE sp_addtype tAppName, 'varchar(280)', 'NOT NULL'
GO

EXECUTE sp_addtype tSessionItemShort, 'varbinary(7000)'
GO

EXECUTE sp_addtype tSessionItemLong, 'image'
GO

EXECUTE sp_addtype tTextPtr, 'varbinary(16)'
GO

/*****************************************************************************/

EXECUTE dbo.CreateTempTables
GO

USE master
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

PRINT ''
GO

PRINT '------------------------------------------'
GO

PRINT 'Completed execution of InstallSqlState.SQL'
GO

PRINT '------------------------------------------'
GO

/*********************************************************************
  InstallSqlStateTemplate.SQL                                                
                                                                    
  Installs the tables, and stored procedures necessary for           
  supporting ASP.NET session state.                                  

  Copyright Microsoft, Inc.
  All Rights Reserved.

 *********************************************************************/

SET QUOTED_IDENTIFIER OFF
GO

SET ANSI_NULLS ON
GO

PRINT ''
GO

PRINT '-------------------------------------------------'
GO

PRINT 'Starting execution of InstallSqlStateTemplate.SQL'
GO

PRINT '-------------------------------------------------'
GO

PRINT ''
GO

PRINT '--------------------------------------------------'
GO

PRINT 'Note:                                             '
GO

PRINT 'This file is included for backward compatibility  '
GO

PRINT 'only.  You should use aspnet_regsql.exe to install'
GO

PRINT 'and uninstall SQL session state.                  '
GO

PRINT ''
GO

PRINT 'Run ''aspnet_regsql.exe -?'' for details.         '
GO

PRINT '--------------------------------------------------'
GO

/*
   InstallSqlStateTemplate.sql and UninstallSqlStateTemplate.sql are
   templates files for installing the ASP.NET session state SQL objects
   on a database other than the default 'ASPState'.

   To create your own script files based on the template:
   1. Create your own script files by coping the two template files.
   2. Decide a name for your database (e.g. MyASPStateDB)
   3. In your own script files, replace all occurences of "DatabaseNamePlaceHolder"
      by your database name.
   4. Install and uninstall ASP.NET session state SQL objects using your own
      script files.
*/

/*****************************************************************************/

USE master
GO

/* Create and populate the session state database */

IF DB_ID(N'DatabaseNamePlaceHolder') IS NULL BEGIN
    DECLARE @cmd nvarchar(500)
    SET @cmd = N'CREATE DATABASE [DatabaseNamePlaceHolder]'
    EXEC(@cmd)
END
GO

IF OBJECT_ID(N'dbo.ASPStateTempSessions','U') IS NOT NULL BEGIN
    DROP TABLE dbo.ASPStateTempSessions
END
GO

IF OBJECT_ID(N'dbo.ASPStateTempApplications','U') IS NOT NULL BEGIN
    DROP TABLE dbo.ASPStateTempApplications
END
GO

USE [DatabaseNamePlaceHolder]
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'GetMajorVersion') AND (type = 'P')))
    DROP PROCEDURE [dbo].GetMajorVersion
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'CreateTempTables') AND (type = 'P')))
    DROP PROCEDURE [dbo].CreateTempTables
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetVersion') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetVersion
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'GetHashCode') AND (type = 'P')))
    DROP PROCEDURE [dbo].GetHashCode
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetAppID') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetAppID
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItem') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItem
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItem2') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItem2
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItem3') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItem3
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItemExclusive') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItemExclusive
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItemExclusive2') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItemExclusive2
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempGetStateItemExclusive3') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempGetStateItemExclusive3
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempReleaseStateItemExclusive') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempReleaseStateItemExclusive
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempInsertUninitializedItem') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempInsertUninitializedItem
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempInsertStateItemShort') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempInsertStateItemShort
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempInsertStateItemLong') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempInsertStateItemLong
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemShort') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemShort
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemShortNullLong') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemShortNullLong
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemLong') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemLong
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempUpdateStateItemLongNullShort') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempUpdateStateItemLongNullShort
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempRemoveStateItem') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempRemoveStateItem
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'TempResetTimeout') AND (type = 'P')))
    DROP PROCEDURE [dbo].TempResetTimeout
GO

IF (EXISTS (SELECT name FROM sysobjects WHERE (name = N'DeleteExpiredSessions') AND (type = 'P')))
    DROP PROCEDURE [dbo].DeleteExpiredSessions
GO

IF EXISTS(SELECT name FROM systypes WHERE name ='tSessionId')
    EXECUTE sp_droptype tSessionId
GO

IF EXISTS(SELECT name FROM systypes WHERE name ='tAppName')
    EXECUTE sp_droptype tAppName
GO

IF EXISTS(SELECT name FROM systypes WHERE name ='tSessionItemShort')
    EXECUTE sp_droptype tSessionItemShort
GO

IF EXISTS(SELECT name FROM systypes WHERE name ='tSessionItemLong')
    EXECUTE sp_droptype tSessionItemLong
GO

IF EXISTS(SELECT name FROM systypes WHERE name ='tTextPtr')
    EXECUTE sp_droptype tTextPtr
GO

/*****************************************************************************/

EXECUTE sp_addtype tSessionId, 'nvarchar(88)',  'NOT NULL'
GO

EXECUTE sp_addtype tAppName, 'varchar(280)', 'NOT NULL'
GO

EXECUTE sp_addtype tSessionItemShort, 'varbinary(7000)'
GO

EXECUTE sp_addtype tSessionItemLong, 'image'
GO

EXECUTE sp_addtype tTextPtr, 'varbinary(16)'
GO

/*****************************************************************************/

EXECUTE dbo.CreateTempTables
GO

USE master
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

PRINT ''
GO

PRINT '--------------------------------------------------'
GO

PRINT 'Completed execution of InstallSqlStateTemplate.SQL'
GO

PRINT '--------------------------------------------------'
GO

/**********************************************************************/
/* InstallWebEventSqlProvider.SQL                                     */
/*                                                                    */
/* Installs the tables, triggers and stored procedures necessary for  */
/* supporting the aspnet feature of ASP.Net                           */
/*                                                                    */
/* InstallCommon.sql must be run before running this file.            */
/*
** Copyright Microsoft, Inc. 2003
** All Rights Reserved.
*/
/**********************************************************************/

PRINT '----------------------------------------------------'
GO

PRINT 'Starting execution of InstallWebEventSqlProvider.SQL'
GO

PRINT '----------------------------------------------------'
GO

SET QUOTED_IDENTIFIER OFF
GO

-- We don't use quoted identifiers
SET ANSI_NULLS ON         -- We don't want (NULL = NULL) == TRUE
GO

SET ANSI_PADDING ON
GO

SET ANSI_NULL_DFLT_ON ON
GO

USE [aspnetdb]
GO

IF (NOT EXISTS (SELECT name
                FROM sysobjects
                WHERE (name = N'aspnet_WebEvent_Events')
                  AND (type = 'U')))
BEGIN
  PRINT 'Creating the aspnet_WebEvent_Events table...'
  --The following statement was imported into the database project as a schema object and named dbo.aspnet_WebEvent_Events.
--CREATE TABLE dbo.aspnet_WebEvent_Events (
--        EventId         char(32)            PRIMARY KEY,
--        EventTimeUtc    datetime            NOT NULL,
--        EventTime       datetime            NOT NULL,
--        EventType       nvarchar(256)       NOT NULL,
--        EventSequence   decimal(19,0)       NOT NULL, /* SQL7 doesn't support bigint */
--        EventOccurrence decimal(19,0)       NOT NULL, /* SQL7 doesn't support bigint */
--        EventCode       int                 NOT NULL,
--        EventDetailCode int                 NOT NULL,
--        Message         nvarchar(1024)      NULL,
--        ApplicationPath nvarchar(256)       NULL,
--        ApplicationVirtualPath nvarchar(256) NULL,
--        MachineName     nvarchar(256)       NOT NULL,
--        RequestUrl      nvarchar(1024)      NULL,
--        ExceptionType   nvarchar(256)       NULL,
--        Details         ntext               NULL
--  )

END
GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_WebEvent_LogEvent')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_WebEvent_LogEvent
GO

/*************************************************************/
/*************************************************************/

IF ( NOT EXISTS ( SELECT name
                  FROM sysusers
                  WHERE issqlrole = 1
                  AND name = N'aspnet_WebEvent_FullAccess'))
EXEC sp_addrole N'aspnet_WebEvent_FullAccess'
GO

GRANT EXECUTE ON dbo.aspnet_WebEvent_LogEvent TO aspnet_WebEvent_FullAccess
GO

GRANT EXECUTE ON dbo.aspnet_CheckSchemaVersion TO aspnet_WebEvent_FullAccess
GO

GRANT EXECUTE ON dbo.aspnet_RegisterSchemaVersion TO aspnet_WebEvent_FullAccess
GO

GRANT EXECUTE ON dbo.aspnet_UnRegisterSchemaVersion TO aspnet_WebEvent_FullAccess
GO

EXEC [dbo].aspnet_RegisterSchemaVersion N'Health Monitoring', N'1', 1, 1
GO

PRINT '-----------------------------------------------------'
GO

PRINT 'Completed execution of InstallWebEventSqlProvider.SQL'
GO

PRINT '-----------------------------------------------------'
GO


DECLARE @dbname nvarchar(128)
DECLARE @dboptions nvarchar(1024)

SET @dboptions = N'/**/'
SET @dbname = N'aspnetdb'

IF (NOT EXISTS (SELECT name
                FROM master.dbo.sysdatabases
                WHERE name = @dbname))
BEGIN
  PRINT 'Creating the ' + @dbname + ' database...'
  DECLARE @cmd nvarchar(500)
  SET @cmd = 'CREATE DATABASE [' + @dbname + '] ' + @dboptions
  EXEC(@cmd)
END

GO


DECLARE @command nvarchar(4000)

SET @command = 'GRANT EXECUTE ON [dbo].aspnet_Setup_RestorePermissions TO ' + QUOTENAME(user)
EXEC (@command)
SET @command = 'GRANT EXECUTE ON [dbo].aspnet_RegisterSchemaVersion TO ' + QUOTENAME(user)
EXEC (@command)

GO


/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/
DECLARE @command nvarchar(400)
SET @command = 'GRANT EXECUTE ON [dbo].aspnet_AnyDataInTables TO ' + QUOTENAME(user)
EXEC (@command)

GO


/*************************************************************/
/*************************************************************/
DECLARE @command nvarchar(4000)

SET @command = 'REVOKE EXECUTE ON [dbo].aspnet_Setup_RestorePermissions from ' + QUOTENAME(user)
EXEC (@command)
SET @command = 'REVOKE EXECUTE ON [dbo].aspnet_RegisterSchemaVersion from ' + QUOTENAME(user)
EXEC (@command)

GO


/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

DECLARE @dbname nvarchar(128)

SET @dbname = N'aspnetdb'

IF (NOT EXISTS (SELECT name
                FROM master.dbo.sysdatabases
                WHERE ('[' + name + ']' = @dbname OR name = @dbname)))
BEGIN
  RAISERROR('The database ''%s'' cannot be found. Please run InstallCommon.sql first.', 18, 1, @dbname)
END

GO


/*************************************************************/
/*************************************************************/
/*************************************************************/

DECLARE @ver int
DECLARE @version nchar(100)
DECLARE @dot int
DECLARE @hyphen int
DECLARE @SqlToExec nchar(400)

SELECT @ver = 8
SELECT @version = @@Version
SELECT @hyphen  = CHARINDEX(N' - ', @version)
IF (NOT(@hyphen IS NULL) AND @hyphen > 0)
BEGIN
    SELECT @hyphen = @hyphen + 3
    SELECT @dot    = CHARINDEX(N'.', @version, @hyphen)
    IF (NOT(@dot IS NULL) AND @dot > @hyphen)
    BEGIN
        SELECT @version = SUBSTRING(@version, @hyphen, @dot - @hyphen)
        SELECT @ver     = CONVERT(int, @version)
    END
END

/*************************************************************/

IF (@ver >= 8)
    EXEC sp_tableoption N'aspnet_Membership', 'text in row', 3000

/*************************************************************/
/*************************************************************/

IF (EXISTS (SELECT name
              FROM sysobjects
             WHERE (name = N'aspnet_Membership_CreateUser')
               AND (type = 'P')))
DROP PROCEDURE dbo.aspnet_Membership_CreateUser

GO


/*************************************************************/
/*************************************************************/

--
--Create Membership schema version
--
DECLARE @command nvarchar(4000)
SET @command = 'GRANT EXECUTE ON [dbo].aspnet_RegisterSchemaVersion TO ' + QUOTENAME(user)
EXECUTE (@command)

GO


--
--Stored Procedure rights for BasicAcess
--
GRANT EXECUTE ON dbo.aspnet_Membership_GetUserByUserId TO aspnet_Membership_BasicAccess
GRANT EXECUTE ON dbo.aspnet_Membership_GetUserByName TO aspnet_Membership_BasicAccess
GRANT EXECUTE ON dbo.aspnet_Membership_GetUserByEmail TO aspnet_Membership_BasicAccess
GRANT EXECUTE ON dbo.aspnet_Membership_GetPassword TO aspnet_Membership_BasicAccess
GRANT EXECUTE ON dbo.aspnet_Membership_GetPasswordWithFormat TO aspnet_Membership_BasicAccess
GRANT EXECUTE ON dbo.aspnet_Membership_UpdateUserInfo TO aspnet_Membership_BasicAccess
GRANT EXECUTE ON dbo.aspnet_Membership_GetNumberOfUsersOnline TO aspnet_Membership_BasicAccess
GRANT EXECUTE ON dbo.aspnet_CheckSchemaVersion TO aspnet_Membership_BasicAccess
GRANT EXECUTE ON dbo.aspnet_RegisterSchemaVersion TO aspnet_Membership_BasicAccess
GRANT EXECUTE ON dbo.aspnet_UnRegisterSchemaVersion TO aspnet_Membership_BasicAccess

--
--Stored Procedure rights for ReportingAccess
--
GRANT EXECUTE ON dbo.aspnet_Membership_GetUserByUserId TO aspnet_Membership_ReportingAccess
GRANT EXECUTE ON dbo.aspnet_Membership_GetUserByName TO aspnet_Membership_ReportingAccess
GRANT EXECUTE ON dbo.aspnet_Membership_GetUserByEmail TO aspnet_Membership_ReportingAccess
GRANT EXECUTE ON dbo.aspnet_Membership_GetAllUsers TO aspnet_Membership_ReportingAccess
GRANT EXECUTE ON dbo.aspnet_Membership_GetNumberOfUsersOnline TO aspnet_Membership_ReportingAccess
GRANT EXECUTE ON dbo.aspnet_Membership_FindUsersByName TO aspnet_Membership_ReportingAccess
GRANT EXECUTE ON dbo.aspnet_Membership_FindUsersByEmail TO aspnet_Membership_ReportingAccess
GRANT EXECUTE ON dbo.aspnet_CheckSchemaVersion TO aspnet_Membership_ReportingAccess
GRANT EXECUTE ON dbo.aspnet_RegisterSchemaVersion TO aspnet_Membership_ReportingAccess
GRANT EXECUTE ON dbo.aspnet_UnRegisterSchemaVersion TO aspnet_Membership_ReportingAccess

--
--Additional stored procedure rights for FullAccess
--
GRANT EXECUTE ON dbo.aspnet_Users_DeleteUser TO aspnet_Membership_FullAccess

GRANT EXECUTE ON dbo.aspnet_Membership_CreateUser TO aspnet_Membership_FullAccess
GRANT EXECUTE ON dbo.aspnet_Membership_SetPassword TO aspnet_Membership_FullAccess
GRANT EXECUTE ON dbo.aspnet_Membership_ResetPassword TO aspnet_Membership_FullAccess
GRANT EXECUTE ON dbo.aspnet_Membership_UpdateUser TO aspnet_Membership_FullAccess
GRANT EXECUTE ON dbo.aspnet_Membership_ChangePasswordQuestionAndAnswer TO aspnet_Membership_FullAccess
GRANT EXECUTE ON dbo.aspnet_Membership_UnlockUser TO aspnet_Membership_FullAccess

--
--View rights
--
GRANT SELECT ON dbo.vw_aspnet_Applications TO aspnet_Membership_ReportingAccess
GRANT SELECT ON dbo.vw_aspnet_Users TO aspnet_Membership_ReportingAccess

GRANT SELECT ON dbo.vw_aspnet_MembershipUsers TO aspnet_Membership_ReportingAccess

/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

DECLARE @command nvarchar(4000)
SET @command = 'REVOKE EXECUTE ON [dbo].aspnet_RegisterSchemaVersion FROM ' + QUOTENAME(user)
EXECUTE (@command)

GO


/* Drop all tables, startup procedures, stored procedures and types. */

/* Drop the DeleteExpiredSessions_Job */

DECLARE @jobname nvarchar(200)
SET @jobname = N'ASPState' + '_Job_DeleteExpiredSessions' 

-- Delete the [local] job 
-- We expected to get an error if the job doesn't exist.
PRINT 'If the job does not exist, an error from msdb.dbo.sp_delete_job is expected.'
EXECUTE msdb.dbo.sp_delete_job @job_name = @jobname

GO


DECLARE @sstype nvarchar(128)
SET @sstype = N'sstype_persisted'

IF UPPER(@sstype) = 'SSTYPE_TEMP' AND OBJECT_ID(N'dbo.ASPState_Startup', 'P') IS NOT NULL BEGIN
    DROP PROCEDURE dbo.ASPState_Startup
END    

USE [ASPState]

GO


/*****************************************************************************/

USE [ASPState]

/* Find out the version */
DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT

DECLARE @cmd nchar(4000)

IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.CreateTempTables
        AS
            CREATE TABLE [ASPState].dbo.ASPStateTempSessions (
                SessionId           nvarchar(88)    NOT NULL PRIMARY KEY,
                Created             datetime        NOT NULL DEFAULT GETUTCDATE(),
                Expires             datetime        NOT NULL,
                LockDate            datetime        NOT NULL,
                LockDateLocal       datetime        NOT NULL,
                LockCookie          int             NOT NULL,
                Timeout             int             NOT NULL,
                Locked              bit             NOT NULL,
                SessionItemShort    varbinary(7000) NULL,
                SessionItemLong     image           NULL,
                Flags               int             NOT NULL DEFAULT 0,
            ) 

            CREATE NONCLUSTERED INDEX Index_Expires ON [ASPState].dbo.ASPStateTempSessions(Expires)

            CREATE TABLE [ASPState].dbo.ASPStateTempApplications (
                AppId               int             NOT NULL PRIMARY KEY,
                AppName             char(280)       NOT NULL,
            ) 

            CREATE NONCLUSTERED INDEX Index_AppName ON [ASPState].dbo.ASPStateTempApplications(AppName)

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.CreateTempTables
        AS
            CREATE TABLE [ASPState].dbo.ASPStateTempSessions (
                SessionId           nvarchar(88)    NOT NULL PRIMARY KEY,
                Created             datetime        NOT NULL DEFAULT GETDATE(),
                Expires             datetime        NOT NULL,
                LockDate            datetime        NOT NULL,
                LockCookie          int             NOT NULL,
                Timeout             int             NOT NULL,
                Locked              bit             NOT NULL,
                SessionItemShort    VARBINARY(7000) NULL,
                SessionItemLong     IMAGE           NULL,
                Flags               int             NOT NULL DEFAULT 0,
            ) 

            CREATE NONCLUSTERED INDEX Index_Expires ON [ASPState].dbo.ASPStateTempSessions(Expires)

            CREATE TABLE [ASPState].dbo.ASPStateTempApplications (
                AppId               int             NOT NULL PRIMARY KEY,
                AppName             char(280)       NOT NULL,
            ) 

            CREATE NONCLUSTERED INDEX Index_AppName ON [ASPState].dbo.ASPStateTempApplications(AppName)

            RETURN 0'

EXEC (@cmd)

GO


/*****************************************************************************/

DECLARE @cmd nchar(4000)

SET @cmd = N'
    CREATE PROCEDURE dbo.TempGetAppID
    @appName    tAppName,
    @appId      int OUTPUT
    AS
    SET @appName = LOWER(@appName)
    SET @appId = NULL

    SELECT @appId = AppId
    FROM [ASPState].dbo.ASPStateTempApplications
    WHERE AppName = @appName

    IF @appId IS NULL BEGIN
        BEGIN TRAN        

        SELECT @appId = AppId
        FROM [ASPState].dbo.ASPStateTempApplications WITH (TABLOCKX)
        WHERE AppName = @appName
        
        IF @appId IS NULL
        BEGIN
            EXEC GetHashCode @appName, @appId OUTPUT
            
            INSERT [ASPState].dbo.ASPStateTempApplications
            VALUES
            (@appId, @appName)
            
            IF @@ERROR = 2627 
            BEGIN
                DECLARE @dupApp tAppName
            
                SELECT @dupApp = RTRIM(AppName)
                FROM [ASPState].dbo.ASPStateTempApplications 
                WHERE AppId = @appId
                
                RAISERROR(''SQL session state fatal error: hash-code collision between applications ''''%s'''' and ''''%s''''. Please rename the 1st application to resolve the problem.'', 
                            18, 1, @appName, @dupApp)
            END
        END

        COMMIT
    END

    RETURN 0'
EXEC(@cmd)    

GO


/*****************************************************************************/

/* Find out the version */

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItem
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            SET @now = GETUTCDATE()

            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @locked = Locked,
                @lockDate = LockDateLocal,
                @lockCookie = LockCookie,
                @itemShort = CASE @locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE @locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE @locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [ASPState].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItem
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            SET @now = GETDATE()

            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @locked = Locked,
                @lockDate = LockDate,
                @lockCookie = LockCookie,
                @itemShort = CASE @locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE @locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE @locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [ASPState].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
    
EXEC (@cmd)    

GO


/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItem2
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockAge    int OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            SET @now = GETUTCDATE()

            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @locked = Locked,
                @lockAge = DATEDIFF(second, LockDate, @now),
                @lockCookie = LockCookie,
                @itemShort = CASE @locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE @locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE @locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [ASPState].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'

EXEC (@cmd)    

GO

            

/*****************************************************************************/

/* Find out the version */

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItem3
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockAge    int OUTPUT,
            @lockCookie int OUTPUT,
            @actionFlags int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            SET @now = GETUTCDATE()

            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @locked = Locked,
                @lockAge = DATEDIFF(second, LockDate, @now),
                @lockCookie = LockCookie,
                @itemShort = CASE @locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE @locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE @locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,

                /* If the Uninitialized flag (0x1) if it is set,
                   remove it and return InitializeItem (0x1) in actionFlags */
                Flags = CASE
                    WHEN (Flags & 1) <> 0 THEN (Flags & ~1)
                    ELSE Flags
                    END,
                @actionFlags = CASE
                    WHEN (Flags & 1) <> 0 THEN 1
                    ELSE 0
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [ASPState].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItem3
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT,
            @actionFlags int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            SET @now = GETDATE()

            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @locked = Locked,
                @lockDate = LockDate,
                @lockCookie = LockCookie,
                @itemShort = CASE @locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE @locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE @locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,

                /* If the Uninitialized flag (0x1) if it is set,
                   remove it and return InitializeItem (0x1) in actionFlags */
                Flags = CASE
                    WHEN (Flags & 1) <> 0 THEN (Flags & ~1)
                    ELSE Flags
                    END,
                @actionFlags = CASE
                    WHEN (Flags & 1) <> 0 THEN 1
                    ELSE 0
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [ASPState].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
    
EXEC (@cmd)    

GO


/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItemExclusive
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime

            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()
            
            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                LockDate = CASE Locked
                    WHEN 0 THEN @now
                    ELSE LockDate
                    END,
                @lockDate = LockDateLocal = CASE Locked
                    WHEN 0 THEN @nowLocal
                    ELSE LockDateLocal
                    END,
                @lockCookie = LockCookie = CASE Locked
                    WHEN 0 THEN LockCookie + 1
                    ELSE LockCookie
                    END,
                @itemShort = CASE Locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE Locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE Locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,
                @locked = Locked,
                Locked = 1
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [ASPState].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItemExclusive
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime

            SET @now = GETDATE()
            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @lockDate = LockDate = CASE Locked
                    WHEN 0 THEN @now
                    ELSE LockDate
                    END,
                @lockCookie = LockCookie = CASE Locked
                    WHEN 0 THEN LockCookie + 1
                    ELSE LockCookie
                    END,
                @itemShort = CASE Locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE Locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE Locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,
                @locked = Locked,
                Locked = 1
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [ASPState].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'    

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItemExclusive2
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockAge    int OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime

            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()
            
            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                LockDate = CASE Locked
                    WHEN 0 THEN @now
                    ELSE LockDate
                    END,
                LockDateLocal = CASE Locked
                    WHEN 0 THEN @nowLocal
                    ELSE LockDateLocal
                    END,
                @lockAge = CASE Locked
                    WHEN 0 THEN 0
                    ELSE DATEDIFF(second, LockDate, @now)
                    END,
                @lockCookie = LockCookie = CASE Locked
                    WHEN 0 THEN LockCookie + 1
                    ELSE LockCookie
                    END,
                @itemShort = CASE Locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE Locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE Locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,
                @locked = Locked,
                Locked = 1
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [ASPState].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItemExclusive3
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockAge    int OUTPUT,
            @lockCookie int OUTPUT,
            @actionFlags int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime

            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()
            
            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                LockDate = CASE Locked
                    WHEN 0 THEN @now
                    ELSE LockDate
                    END,
                LockDateLocal = CASE Locked
                    WHEN 0 THEN @nowLocal
                    ELSE LockDateLocal
                    END,
                @lockAge = CASE Locked
                    WHEN 0 THEN 0
                    ELSE DATEDIFF(second, LockDate, @now)
                    END,
                @lockCookie = LockCookie = CASE Locked
                    WHEN 0 THEN LockCookie + 1
                    ELSE LockCookie
                    END,
                @itemShort = CASE Locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE Locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE Locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,
                @locked = Locked,
                Locked = 1,

                /* If the Uninitialized flag (0x1) if it is set,
                   remove it and return InitializeItem (0x1) in actionFlags */
                Flags = CASE
                    WHEN (Flags & 1) <> 0 THEN (Flags & ~1)
                    ELSE Flags
                    END,
                @actionFlags = CASE
                    WHEN (Flags & 1) <> 0 THEN 1
                    ELSE 0
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [ASPState].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItemExclusive3
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT,
            @actionFlags int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime

            SET @now = GETDATE()
            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @lockDate = LockDate = CASE Locked
                    WHEN 0 THEN @now
                    ELSE LockDate
                    END,
                @lockCookie = LockCookie = CASE Locked
                    WHEN 0 THEN LockCookie + 1
                    ELSE LockCookie
                    END,
                @itemShort = CASE Locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE Locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE Locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,
                @locked = Locked,
                Locked = 1,

                /* If the Uninitialized flag (0x1) if it is set,
                   remove it and return InitializeItem (0x1) in actionFlags */
                Flags = CASE
                    WHEN (Flags & 1) <> 0 THEN (Flags & ~1)
                    ELSE Flags
                    END,
                @actionFlags = CASE
                    WHEN (Flags & 1) <> 0 THEN 1
                    ELSE 0
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [ASPState].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'    

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempReleaseStateItemExclusive
            @id         tSessionId,
            @lockCookie int
        AS
            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, GETUTCDATE()), 
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempReleaseStateItemExclusive
            @id         tSessionId,
            @lockCookie int
        AS
            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, GETDATE()), 
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertUninitializedItem
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int
        AS    

            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime
            
            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()

            INSERT [ASPState].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemShort, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockDateLocal,
                 LockCookie,
                 Flags) 
            VALUES 
                (@id, 
                 @itemShort, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 @nowLocal,
                 1,
                 1)

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertUninitializedItem
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int
        AS    

            DECLARE @now AS datetime
            SET @now = GETDATE()

            INSERT [ASPState].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemShort, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockCookie,
                 Flags) 
            VALUES 
                (@id, 
                 @itemShort, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 1,
                 1)

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertStateItemShort
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int
        AS    

            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime
            
            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()

            INSERT [ASPState].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemShort, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockDateLocal,
                 LockCookie) 
            VALUES 
                (@id, 
                 @itemShort, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 @nowLocal,
                 1)

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertStateItemShort
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int
        AS    

            DECLARE @now AS datetime
            SET @now = GETDATE()

            INSERT [ASPState].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemShort, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockCookie) 
            VALUES 
                (@id, 
                 @itemShort, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 1)

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertStateItemLong
            @id         tSessionId,
            @itemLong   tSessionItemLong,
            @timeout    int
        AS    
            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime
            
            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()

            INSERT [ASPState].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemLong, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockDateLocal,
                 LockCookie) 
            VALUES 
                (@id, 
                 @itemLong, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 @nowLocal,
                 1)

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertStateItemLong
            @id         tSessionId,
            @itemLong   tSessionItemLong,
            @timeout    int
        AS    
            DECLARE @now AS datetime
            SET @now = GETDATE()

            INSERT [ASPState].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemLong, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockCookie) 
            VALUES 
                (@id, 
                 @itemLong, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 1)

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemShort
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETUTCDATE()), 
                SessionItemShort = @itemShort, 
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemShort
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETDATE()), 
                SessionItemShort = @itemShort, 
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemShortNullLong
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETUTCDATE()), 
                SessionItemShort = @itemShort, 
                SessionItemLong = NULL, 
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemShortNullLong
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETDATE()), 
                SessionItemShort = @itemShort, 
                SessionItemLong = NULL, 
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemLong
            @id         tSessionId,
            @itemLong   tSessionItemLong,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETUTCDATE()), 
                SessionItemLong = @itemLong,
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemLong
            @id         tSessionId,
            @itemLong   tSessionItemLong,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETDATE()), 
                SessionItemLong = @itemLong,
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'

EXEC (@cmd)            

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemLongNullShort
            @id         tSessionId,
            @itemLong   tSessionItemLong,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETUTCDATE()), 
                SessionItemLong = @itemLong, 
                SessionItemShort = NULL,
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'
ELSE
    SET @cmd = N'
    CREATE PROCEDURE dbo.TempUpdateStateItemLongNullShort
        @id         tSessionId,
        @itemLong   tSessionItemLong,
        @timeout    int,
        @lockCookie int
    AS    
        UPDATE [ASPState].dbo.ASPStateTempSessions
        SET Expires = DATEADD(n, @timeout, GETDATE()), 
            SessionItemLong = @itemLong, 
            SessionItemShort = NULL,
            Timeout = @timeout,
            Locked = 0
        WHERE SessionId = @id AND LockCookie = @lockCookie

        RETURN 0'

EXEC (@cmd)            

GO


/*****************************************************************************/

DECLARE @cmd nchar(4000)
SET @cmd = N'
    CREATE PROCEDURE dbo.TempRemoveStateItem
        @id     tSessionId,
        @lockCookie int
    AS
        DELETE [ASPState].dbo.ASPStateTempSessions
        WHERE SessionId = @id AND LockCookie = @lockCookie
        RETURN 0'
EXEC(@cmd)    

GO

            
/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempResetTimeout
            @id     tSessionId
        AS
            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, GETUTCDATE())
            WHERE SessionId = @id
            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempResetTimeout
            @id     tSessionId
        AS
            UPDATE [ASPState].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, GETDATE())
            WHERE SessionId = @id
            RETURN 0'

EXEC (@cmd)            

GO


            
/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.DeleteExpiredSessions
        AS
            SET NOCOUNT ON
            SET DEADLOCK_PRIORITY LOW 

            DECLARE @now datetime
            SET @now = GETUTCDATE() 

            CREATE TABLE #tblExpiredSessions 
            ( 
                SessionID nvarchar(88) NOT NULL PRIMARY KEY
            )

            INSERT #tblExpiredSessions (SessionID)
                SELECT SessionID
                FROM [ASPState].dbo.ASPStateTempSessions WITH (READUNCOMMITTED)
                WHERE Expires < @now

            IF @@ROWCOUNT <> 0 
            BEGIN 
                DECLARE ExpiredSessionCursor CURSOR LOCAL FORWARD_ONLY READ_ONLY
                FOR SELECT SessionID FROM #tblExpiredSessions 

                DECLARE @SessionID nvarchar(88)

                OPEN ExpiredSessionCursor

                FETCH NEXT FROM ExpiredSessionCursor INTO @SessionID

                WHILE @@FETCH_STATUS = 0 
                    BEGIN
                        DELETE FROM [ASPState].dbo.ASPStateTempSessions WHERE SessionID = @SessionID AND Expires < @now
                        FETCH NEXT FROM ExpiredSessionCursor INTO @SessionID
                    END

                CLOSE ExpiredSessionCursor

                DEALLOCATE ExpiredSessionCursor

            END 

            DROP TABLE #tblExpiredSessions

        RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.DeleteExpiredSessions
        AS
            SET NOCOUNT ON
            SET DEADLOCK_PRIORITY LOW 

            DECLARE @now datetime
            SET @now = GETDATE() 

            CREATE TABLE #tblExpiredSessions 
            ( 
                SessionID nvarchar(88) NOT NULL PRIMARY KEY
            )

            INSERT #tblExpiredSessions (SessionID)
                SELECT SessionID
                FROM [ASPState].dbo.ASPStateTempSessions WITH (READUNCOMMITTED)
                WHERE Expires < @now

            IF @@ROWCOUNT <> 0 
            BEGIN 
                DECLARE ExpiredSessionCursor CURSOR LOCAL FORWARD_ONLY READ_ONLY
                FOR SELECT SessionID FROM #tblExpiredSessions 

                DECLARE @SessionID nvarchar(88)

                OPEN ExpiredSessionCursor

                FETCH NEXT FROM ExpiredSessionCursor INTO @SessionID

                WHILE @@FETCH_STATUS = 0 
                    BEGIN
                        DELETE FROM [ASPState].dbo.ASPStateTempSessions WHERE SessionID = @SessionID AND Expires < @now
                        FETCH NEXT FROM ExpiredSessionCursor INTO @SessionID
                    END

                CLOSE ExpiredSessionCursor

                DEALLOCATE ExpiredSessionCursor

            END 

            DROP TABLE #tblExpiredSessions

        RETURN 0'
EXEC (@cmd)            

GO


DECLARE @sstype nvarchar(128)
SET @sstype = N'sstype_persisted'

IF UPPER(@sstype) = 'SSTYPE_TEMP' BEGIN
    DECLARE @cmd nchar(4000)

    SET @cmd = N'
        /* Create the startup procedure */
        CREATE PROCEDURE dbo.ASPState_Startup 
        AS
            EXECUTE ASPState.dbo.CreateTempTables

            RETURN 0'
    EXEC(@cmd)
    EXECUTE sp_procoption @ProcName='dbo.ASPState_Startup', @OptionName='startup', @OptionValue='true'
END    

/*****************************************************************************/

/* Create the job to delete expired sessions */

-- Add job category
-- We expect an error if the category already exists.
PRINT 'If the category already exists, an error from msdb.dbo.sp_add_category is expected.'
EXECUTE msdb.dbo.sp_add_category @name = N'[Uncategorized (Local)]'

GO


BEGIN TRANSACTION            
    DECLARE @JobID BINARY(16)  
    DECLARE @ReturnCode int    
    DECLARE @nameT nchar(200)
    SELECT @ReturnCode = 0     

    -- Add the job
    SET @nameT = N'ASPState' + '_Job_DeleteExpiredSessions'
    EXECUTE @ReturnCode = msdb.dbo.sp_add_job 
            @job_id = @JobID OUTPUT, 
            @job_name = @nameT, 
            @owner_login_name = NULL, 
            @description = N'Deletes expired sessions from the session state database.', 
            @category_name = N'[Uncategorized (Local)]', 
            @enabled = 1, 
            @notify_level_email = 0, 
            @notify_level_page = 0, 
            @notify_level_netsend = 0, 
            @notify_level_eventlog = 0, 
            @delete_level= 0

    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
    
    -- Add the job steps
    SET @nameT = N'ASPState' + '_JobStep_DeleteExpiredSessions'
    EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep 
            @job_id = @JobID,
            @step_id = 1, 
            @step_name = @nameT, 
            @command = N'EXECUTE DeleteExpiredSessions', 
            @database_name = N'ASPState', 
            @server = N'', 
            @database_user_name = N'', 
            @subsystem = N'TSQL', 
            @cmdexec_success_code = 0, 
            @flags = 0, 
            @retry_attempts = 0, 
            @retry_interval = 1, 
            @output_file_name = N'', 
            @on_success_step_id = 0, 
            @on_success_action = 1, 
            @on_fail_step_id = 0, 
            @on_fail_action = 2

    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

    EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1 
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
    
    -- Add the job schedules
    SET @nameT = N'ASPState' + '_JobSchedule_DeleteExpiredSessions'
    EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule 
            @job_id = @JobID, 
            @name = @nameT, 
            @enabled = 1, 
            @freq_type = 4,     
            @active_start_date = 20001016, 
            @active_start_time = 0, 
            @freq_interval = 1, 
            @freq_subday_type = 4, 
            @freq_subday_interval = 1, 
            @freq_relative_interval = 0, 
            @freq_recurrence_factor = 0, 
            @active_end_date = 99991231, 
            @active_end_time = 235959

    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
    
    -- Add the Target Servers
    EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'(local)' 
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
    
    COMMIT TRANSACTION          
    GOTO   EndSave              
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION 
EndSave: 

GO


/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

DECLARE @dbname NVARCHAR(128)

SET @dbname = N'aspnetdb'

IF (NOT EXISTS (SELECT name
                FROM master.dbo.sysdatabases
                WHERE ('[' + name + ']' = @dbname OR name = @dbname)))
BEGIN
  RAISERROR('The database ''%s'' cannot be found. Please run InstallCommon.sql first.', 18, 1, @dbname)
END

GO


/*************************************************************/
/*************************************************************/

--
--Create Personalization schema version
--

DECLARE @command nvarchar(4000)
SET @command = 'GRANT EXECUTE ON [dbo].aspnet_RegisterSchemaVersion TO ' + QUOTENAME(user)
EXECUTE (@command)

GO

-------------------------------------------------------------------------
--- Version specific install
-------------------------------------------------------------------------

DECLARE @ver INT
DECLARE @version NCHAR(100)
DECLARE @dot INT
DECLARE @hyphen INT
DECLARE @SqlToExec NCHAR(400)

SELECT @ver = 8
SELECT @version = @@Version
SELECT @hyphen  = CHARINDEX(N' - ', @version)
IF (NOT(@hyphen IS NULL) AND @hyphen > 0)
BEGIN
    SELECT @hyphen = @hyphen + 3
    SELECT @dot    = CHARINDEX(N'.', @version, @hyphen)
    IF (NOT(@dot IS NULL) AND @dot > @hyphen)
    BEGIN
        SELECT @version = SUBSTRING(@version, @hyphen, @dot - @hyphen)
        SELECT @ver     = CONVERT(INT, @version)
    END
END

IF (@ver >= 8)
BEGIN
    EXEC sp_tableoption N'aspnet_PersonalizationAllUsers', 'text in row', 6000
    EXEC sp_tableoption N'aspnet_PersonalizationPerUser', 'text in row', 6000
END

GO


/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

DECLARE @command nvarchar(4000)
SET @command = 'REVOKE EXECUTE ON [dbo].aspnet_RegisterSchemaVersion FROM ' + QUOTENAME(user)
EXECUTE (@command)

GO


/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

DECLARE @dbname nvarchar(128)

SET @dbname = N'aspnetdb'

IF (NOT EXISTS (SELECT name
                FROM master.dbo.sysdatabases
                WHERE ('[' + name + ']' = @dbname OR name = @dbname)))
BEGIN
  RAISERROR('The database ''%s'' cannot be found. Please run InstallCommon.sql first.', 18, 1, @dbname)
END

GO


/*************************************************************/
/*************************************************************/

--
--Create Profile schema version
--

DECLARE @command nvarchar(4000)
SET @command = 'GRANT EXECUTE ON [dbo].aspnet_RegisterSchemaVersion TO ' + QUOTENAME(user)
EXECUTE (@command)

GO


-------------------------------------------------------------------------
--- Version specific install
-------------------------------------------------------------------------

DECLARE @ver int
DECLARE @version nchar(100)
DECLARE @dot int
DECLARE @hyphen int
DECLARE @SqlToExec nchar(400)

SELECT @ver = 8
SELECT @version = @@Version
SELECT @hyphen  = CHARINDEX(N' - ', @version)
IF (NOT(@hyphen IS NULL) AND @hyphen > 0)
BEGIN
    SELECT @hyphen = @hyphen + 3
    SELECT @dot    = CHARINDEX(N'.', @version, @hyphen)
    IF (NOT(@dot IS NULL) AND @dot > @hyphen)
    BEGIN
        SELECT @version = SUBSTRING(@version, @hyphen, @dot - @hyphen)
        SELECT @ver     = CONVERT(int, @version)
    END
END

IF (@ver >= 8)
BEGIN
    EXEC sp_tableoption N'aspnet_Profile', 'text in row', 6000
END

GO

/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/


DECLARE @command nvarchar(4000)
SET @command = 'REVOKE EXECUTE ON [dbo].aspnet_RegisterSchemaVersion FROM ' + QUOTENAME(user)
EXECUTE (@command)

GO


/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

DECLARE @dbname nvarchar(128)

SET @dbname = N'aspnetdb'

IF (NOT EXISTS (SELECT name
                FROM master.dbo.sysdatabases
                WHERE ('[' + name + ']' = @dbname OR name = @dbname)))
BEGIN
  RAISERROR('The database ''%s'' cannot be found. Please run InstallCommon.sql first.', 18, 1, @dbname)
END

GO


DECLARE @ver            int
DECLARE @version        nchar(100)
DECLARE @dot            int
DECLARE @hyphen         int
DECLARE @SqlToExec      nchar(4000)

SELECT @ver = 7
SELECT @version = @@Version
SELECT @hyphen  = CHARINDEX(N' - ', @version)
IF (NOT(@hyphen IS NULL) AND @hyphen > 0)
BEGIN
    SELECT @hyphen = @hyphen + 3
    SELECT @dot    = CHARINDEX(N'.', @version, @hyphen)
    IF (NOT(@dot IS NULL) AND @dot > @hyphen)
    BEGIN
        SELECT @version = SUBSTRING(@version, @hyphen, @dot - @hyphen)
        SELECT @ver     = CONVERT(int, @version)
    END
END

IF (@ver > 7)
SELECT @SqlToExec = N'
CREATE PROCEDURE dbo.aspnet_UsersInRoles_AddUsersToRoles
	@ApplicationName  nvarchar(256),
	@UserNames		  nvarchar(4000),
	@RoleNames		  nvarchar(4000),
	@CurrentTimeUtc   datetime
AS
BEGIN
	DECLARE @AppId uniqueidentifier
	SELECT  @AppId = NULL
	SELECT  @AppId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
	IF (@AppId IS NULL)
		RETURN(2)
	DECLARE @TranStarted   bit
	SET @TranStarted = 0

	IF( @@TRANCOUNT = 0 )
	BEGIN
		BEGIN TRANSACTION
		SET @TranStarted = 1
	END

	DECLARE @tbNames	table(Name nvarchar(256) NOT NULL PRIMARY KEY)
	DECLARE @tbRoles	table(RoleId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @tbUsers	table(UserId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @Num		int
	DECLARE @Pos		int
	DECLARE @NextPos	int
	DECLARE @Name		nvarchar(256)

	SET @Num = 0
	SET @Pos = 1
	WHILE(@Pos <= LEN(@RoleNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N'','', @RoleNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@RoleNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@RoleNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbRoles
	  SELECT RoleId
	  FROM   dbo.aspnet_Roles ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredRoleName AND ar.ApplicationId = @AppId

	IF (@@ROWCOUNT <> @Num)
	BEGIN
		SELECT TOP 1 Name
		FROM   @tbNames
		WHERE  LOWER(Name) NOT IN (SELECT ar.LoweredRoleName FROM dbo.aspnet_Roles ar,  @tbRoles r WHERE r.RoleId = ar.RoleId)
		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(2)
	END

	DELETE FROM @tbNames WHERE 1=1
	SET @Num = 0
	SET @Pos = 1

	WHILE(@Pos <= LEN(@UserNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N'','', @UserNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@UserNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@UserNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbUsers
	  SELECT UserId
	  FROM   dbo.aspnet_Users ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredUserName AND ar.ApplicationId = @AppId

	IF (@@ROWCOUNT <> @Num)
	BEGIN
		DELETE FROM @tbNames
		WHERE LOWER(Name) IN (SELECT LoweredUserName FROM dbo.aspnet_Users au,  @tbUsers u WHERE au.UserId = u.UserId)

		INSERT dbo.aspnet_Users (ApplicationId, UserId, UserName, LoweredUserName, IsAnonymous, LastActivityDate)
		  SELECT @AppId, NEWID(), Name, LOWER(Name), 0, @CurrentTimeUtc
		  FROM   @tbNames

		INSERT INTO @tbUsers
		  SELECT  UserId
		  FROM	dbo.aspnet_Users au, @tbNames t
		  WHERE   LOWER(t.Name) = au.LoweredUserName AND au.ApplicationId = @AppId
	END

	IF (EXISTS (SELECT * FROM dbo.aspnet_UsersInRoles ur, @tbUsers tu, @tbRoles tr WHERE tu.UserId = ur.UserId AND tr.RoleId = ur.RoleId))
	BEGIN
		SELECT TOP 1 UserName, RoleName
		FROM		 dbo.aspnet_UsersInRoles ur, @tbUsers tu, @tbRoles tr, aspnet_Users u, aspnet_Roles r
		WHERE		u.UserId = tu.UserId AND r.RoleId = tr.RoleId AND tu.UserId = ur.UserId AND tr.RoleId = ur.RoleId

		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(3)
	END

	INSERT INTO dbo.aspnet_UsersInRoles (UserId, RoleId)
	SELECT UserId, RoleId
	FROM @tbUsers, @tbRoles

	IF( @TranStarted = 1 )
		COMMIT TRANSACTION
	RETURN(0)
END'
ELSE
SELECT @SqlToExec = N'
CREATE PROCEDURE dbo.aspnet_UsersInRoles_AddUsersToRoles
	@ApplicationName	nvarchar(256),
	@UserNames			nvarchar(4000),
	@RoleNames			nvarchar(4000),
	@CurrentTimeUtc		datetime
AS
BEGIN
	DECLARE @AppId uniqueidentifier
	SELECT  @AppId = NULL
	SELECT  @AppId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
	IF (@AppId IS NULL)
		RETURN(2)

	DECLARE @TranStarted   bit
	SET @TranStarted = 0
	IF( @@TRANCOUNT = 0 )
	BEGIN
		BEGIN TRANSACTION
		SET @TranStarted = 1
	END

	DECLARE @RoleId		uniqueidentifier
	DECLARE @UserId		uniqueidentifier
	DECLARE @UserName	nvarchar(256)
	DECLARE @RoleName	nvarchar(256)

	DECLARE @CurrentPosU	int
	DECLARE @NextPosU		int
	DECLARE @CurrentPosR	int
	DECLARE @NextPosR		int

	SELECT  @CurrentPosU = 1

	WHILE(@CurrentPosU <= LEN(@UserNames))
	BEGIN
		SELECT @NextPosU = CHARINDEX(N'','', @UserNames,  @CurrentPosU)
		IF (@NextPosU = 0 OR @NextPosU IS NULL)
			SELECT @NextPosU = LEN(@UserNames) + 1

		SELECT @UserName = SUBSTRING(@UserNames, @CurrentPosU, @NextPosU - @CurrentPosU)
		SELECT @CurrentPosU = @NextPosU+1

		SELECT @CurrentPosR = 1
		WHILE(@CurrentPosR <= LEN(@RoleNames))
		BEGIN
			SELECT @NextPosR = CHARINDEX(N'','', @RoleNames,  @CurrentPosR)
			IF (@NextPosR = 0 OR @NextPosR IS NULL)
				SELECT @NextPosR = LEN(@RoleNames) + 1
			SELECT @RoleName = SUBSTRING(@RoleNames, @CurrentPosR, @NextPosR - @CurrentPosR)
			SELECT @CurrentPosR = @NextPosR+1
			SELECT @RoleId = NULL
			SELECT @RoleId = RoleId FROM dbo.aspnet_Roles WHERE LoweredRoleName = LOWER(@RoleName) AND ApplicationId = @AppId
			IF (@RoleId IS NULL)
			BEGIN
				SELECT @RoleName
				IF( @TranStarted = 1 )
					ROLLBACK TRANSACTION
				RETURN(2)
			END

			SELECT @UserId = NULL
			SELECT @UserId = UserId FROM dbo.aspnet_Users WHERE LoweredUserName = LOWER(@UserName) AND ApplicationId = @AppId
			IF (@UserId IS NULL)
			BEGIN
				EXEC dbo.aspnet_Users_CreateUser @AppId, @UserName, 0, @CurrentTimeUtc, @UserId OUTPUT
			END

			IF (EXISTS(SELECT * FROM dbo.aspnet_UsersInRoles WHERE @UserId = UserId AND @RoleId = RoleId))
			BEGIN
				SELECT @UserName, @RoleName
				IF( @TranStarted = 1 )
					ROLLBACK TRANSACTION
				RETURN(3)
			END
			INSERT INTO dbo.aspnet_UsersInRoles (UserId, RoleId) VALUES(@UserId, @RoleId)
		END
	END
	IF( @TranStarted = 1 )
		COMMIT TRANSACTION
	RETURN(0)
END'

EXEC sp_executesql @SqlToExec

IF (@ver > 7)
SELECT @SqlToExec = N'
CREATE PROCEDURE dbo.aspnet_UsersInRoles_RemoveUsersFromRoles
	@ApplicationName  nvarchar(256),
	@UserNames		  nvarchar(4000),
	@RoleNames		  nvarchar(4000)
AS
BEGIN
	DECLARE @AppId uniqueidentifier
	SELECT  @AppId = NULL
	SELECT  @AppId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
	IF (@AppId IS NULL)
		RETURN(2)


	DECLARE @TranStarted   bit
	SET @TranStarted = 0

	IF( @@TRANCOUNT = 0 )
	BEGIN
		BEGIN TRANSACTION
		SET @TranStarted = 1
	END

	DECLARE @tbNames  table(Name nvarchar(256) NOT NULL PRIMARY KEY)
	DECLARE @tbRoles  table(RoleId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @tbUsers  table(UserId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @Num	  int
	DECLARE @Pos	  int
	DECLARE @NextPos  int
	DECLARE @Name	  nvarchar(256)
	DECLARE @CountAll int
	DECLARE @CountU	  int
	DECLARE @CountR	  int


	SET @Num = 0
	SET @Pos = 1
	WHILE(@Pos <= LEN(@RoleNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N'','', @RoleNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@RoleNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@RoleNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbRoles
	  SELECT RoleId
	  FROM   dbo.aspnet_Roles ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredRoleName AND ar.ApplicationId = @AppId
	SELECT @CountR = @@ROWCOUNT

	IF (@CountR <> @Num)
	BEGIN
		SELECT TOP 1 N'''', Name
		FROM   @tbNames
		WHERE  LOWER(Name) NOT IN (SELECT ar.LoweredRoleName FROM dbo.aspnet_Roles ar,  @tbRoles r WHERE r.RoleId = ar.RoleId)
		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(2)
	END


	DELETE FROM @tbNames WHERE 1=1
	SET @Num = 0
	SET @Pos = 1


	WHILE(@Pos <= LEN(@UserNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N'','', @UserNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@UserNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@UserNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbUsers
	  SELECT UserId
	  FROM   dbo.aspnet_Users ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredUserName AND ar.ApplicationId = @AppId

	SELECT @CountU = @@ROWCOUNT
	IF (@CountU <> @Num)
	BEGIN
		SELECT TOP 1 Name, N''''
		FROM   @tbNames
		WHERE  LOWER(Name) NOT IN (SELECT au.LoweredUserName FROM dbo.aspnet_Users au,  @tbUsers u WHERE u.UserId = au.UserId)

		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(1)
	END

	SELECT  @CountAll = COUNT(*)
	FROM	dbo.aspnet_UsersInRoles ur, @tbUsers u, @tbRoles r
	WHERE   ur.UserId = u.UserId AND ur.RoleId = r.RoleId

	IF (@CountAll <> @CountU * @CountR)
	BEGIN
		SELECT TOP 1 UserName, RoleName
		FROM		 @tbUsers tu, @tbRoles tr, dbo.aspnet_Users u, dbo.aspnet_Roles r
		WHERE		 u.UserId = tu.UserId AND r.RoleId = tr.RoleId AND
					 tu.UserId NOT IN (SELECT ur.UserId FROM dbo.aspnet_UsersInRoles ur WHERE ur.RoleId = tr.RoleId) AND
					 tr.RoleId NOT IN (SELECT ur.RoleId FROM dbo.aspnet_UsersInRoles ur WHERE ur.UserId = tu.UserId)
		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(3)
	END

	DELETE FROM dbo.aspnet_UsersInRoles
	WHERE UserId IN (SELECT UserId FROM @tbUsers)
	  AND RoleId IN (SELECT RoleId FROM @tbRoles)
	IF( @TranStarted = 1 )
		COMMIT TRANSACTION
	RETURN(0)
END
'
ELSE
SELECT @SqlToExec = N'
CREATE PROCEDURE dbo.aspnet_UsersInRoles_RemoveUsersFromRoles
	@ApplicationName  nvarchar(256),
	@UserNames		  nvarchar(4000),
	@RoleNames		  nvarchar(4000)
AS
BEGIN
	DECLARE @AppId uniqueidentifier
	SELECT  @AppId = NULL
	SELECT  @AppId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
	IF (@AppId IS NULL)
		RETURN(2)


	DECLARE @TranStarted   bit
	SET @TranStarted = 0

	IF( @@TRANCOUNT = 0 )
	BEGIN
		BEGIN TRANSACTION
		SET @TranStarted = 1
	END

	DECLARE @RoleId		uniqueidentifier
	DECLARE @UserId		uniqueidentifier
	DECLARE @UserName	nvarchar(256)
	DECLARE @RoleName	nvarchar(256)

	DECLARE @CurrentPosU	int
	DECLARE @NextPosU		int
	DECLARE @CurrentPosR	int
	DECLARE @NextPosR		int

	SELECT  @CurrentPosU = 1

	WHILE(@CurrentPosU <= LEN(@UserNames))
	BEGIN
		SELECT @NextPosU = CHARINDEX(N'','', @UserNames,  @CurrentPosU)
		IF (@NextPosU = 0  OR @NextPosU IS NULL)
			SELECT @NextPosU = LEN(@UserNames)+1
		SELECT @UserName = SUBSTRING(@UserNames, @CurrentPosU, @NextPosU - @CurrentPosU)
		SELECT @CurrentPosU = @NextPosU+1

		SELECT @CurrentPosR = 1
		WHILE(@CurrentPosR <= LEN(@RoleNames))
		BEGIN
			SELECT @NextPosR = CHARINDEX(N'','', @RoleNames,  @CurrentPosR)
			IF (@NextPosR = 0 OR @NextPosR IS NULL)
				SELECT @NextPosR = LEN(@RoleNames)+1
			SELECT @RoleName = SUBSTRING(@RoleNames, @CurrentPosR, @NextPosR - @CurrentPosR)
			SELECT @CurrentPosR = @NextPosR+1

			SELECT @RoleId = NULL
			SELECT @RoleId = RoleId FROM dbo.aspnet_Roles WHERE LoweredRoleName = LOWER(@RoleName) AND ApplicationId = @AppId
			IF (@RoleId IS NULL)
			BEGIN
				SELECT N'''', @RoleName
				IF( @TranStarted = 1 )
					ROLLBACK TRANSACTION
				RETURN(2)
			END

			SELECT @UserId = NULL
			SELECT @UserId = UserId FROM dbo.aspnet_Users WHERE LoweredUserName = LOWER(@UserName) AND ApplicationId = @AppId
			IF (@UserId IS NULL)
			BEGIN
				SELECT @UserName, N''''
				IF( @TranStarted = 1 )
					ROLLBACK TRANSACTION
				RETURN(1)
			END

			IF (NOT(EXISTS(SELECT * FROM dbo.aspnet_UsersInRoles WHERE @UserId = UserId AND @RoleId = RoleId)))
			BEGIN
				SELECT @UserName, @RoleName
				IF( @TranStarted = 1 )
					ROLLBACK TRANSACTION
				RETURN(3)
			END
			DELETE FROM dbo.aspnet_UsersInRoles WHERE (UserId = @UserId AND RoleId = @RoleId)
		END
	END
	IF( @TranStarted = 1 )
		COMMIT TRANSACTION
	RETURN(0)
END
'
EXEC sp_executesql @SqlToExec

GO


/*************************************************************/
/*************************************************************/

--
--Create Role Manager schema version
--

DECLARE @command nvarchar(4000)
SET @command = 'GRANT EXECUTE ON [dbo].aspnet_RegisterSchemaVersion TO ' + QUOTENAME(user)
EXECUTE (@command)

GO


/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

DECLARE @command nvarchar(4000)
SET @command = 'REVOKE EXECUTE ON [dbo].aspnet_RegisterSchemaVersion FROM ' + QUOTENAME(user)
EXECUTE (@command)

GO


/* Drop all tables, startup procedures, stored procedures and types. */

/* Drop the DeleteExpiredSessions_Job */

DECLARE @jobname nvarchar(200)
SET @jobname = N'ASPState' + '_Job_DeleteExpiredSessions' 

-- Delete the [local] job 
-- We expected to get an error if the job doesn't exist.
PRINT 'If the job does not exist, an error from msdb.dbo.sp_delete_job is expected.'

EXECUTE msdb.dbo.sp_delete_job @job_name = @jobname

GO


DECLARE @sstype nvarchar(128)
SET @sstype = N'sstype_temp'

IF UPPER(@sstype) = 'SSTYPE_TEMP' AND OBJECT_ID(N'dbo.ASPState_Startup', 'P') IS NOT NULL BEGIN
    DROP PROCEDURE dbo.ASPState_Startup
END    

USE [tempdb]

GO


/*****************************************************************************/

USE [ASPState]

/* Find out the version */
DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT

DECLARE @cmd nchar(4000)

IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.CreateTempTables
        AS
            CREATE TABLE [tempdb].dbo.ASPStateTempSessions (
                SessionId           nvarchar(88)    NOT NULL PRIMARY KEY,
                Created             datetime        NOT NULL DEFAULT GETUTCDATE(),
                Expires             datetime        NOT NULL,
                LockDate            datetime        NOT NULL,
                LockDateLocal       datetime        NOT NULL,
                LockCookie          int             NOT NULL,
                Timeout             int             NOT NULL,
                Locked              bit             NOT NULL,
                SessionItemShort    VARBINARY(7000) NULL,
                SessionItemLong     image           NULL,
                Flags               int             NOT NULL DEFAULT 0,
            ) 

            CREATE NONCLUSTERED INDEX Index_Expires ON [tempdb].dbo.ASPStateTempSessions(Expires)

            CREATE TABLE [tempdb].dbo.ASPStateTempApplications (
                AppId               int             NOT NULL PRIMARY KEY,
                AppName             char(280)       NOT NULL,
            ) 

            CREATE NONCLUSTERED INDEX Index_AppName ON [tempdb].dbo.ASPStateTempApplications(AppName)

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.CreateTempTables
        AS
            CREATE TABLE [tempdb].dbo.ASPStateTempSessions (
                SessionId           nvarchar(88)    NOT NULL PRIMARY KEY,
                Created             datetime        NOT NULL DEFAULT GETDATE(),
                Expires             datetime        NOT NULL,
                LockDate            datetime        NOT NULL,
                LockCookie          int             NOT NULL,
                Timeout             int             NOT NULL,
                Locked              bit             NOT NULL,
                SessionItemShort    VARBINARY(7000) NULL,
                SessionItemLong     image           NULL,
                Flags               int             NOT NULL DEFAULT 0,
            ) 

            CREATE NONCLUSTERED INDEX Index_Expires ON [tempdb].dbo.ASPStateTempSessions(Expires)

            CREATE TABLE [tempdb].dbo.ASPStateTempApplications (
                AppId               int             NOT NULL PRIMARY KEY,
                AppName             char(280)       NOT NULL,
            ) 

            CREATE NONCLUSTERED INDEX Index_AppName ON [tempdb].dbo.ASPStateTempApplications(AppName)

            RETURN 0'

EXEC (@cmd)

GO


/*****************************************************************************/

DECLARE @cmd nchar(4000)

SET @cmd = N'
    CREATE PROCEDURE dbo.TempGetAppID
    @appName    tAppName,
    @appId      int OUTPUT
    AS
    SET @appName = LOWER(@appName)
    SET @appId = NULL

    SELECT @appId = AppId
    FROM [tempdb].dbo.ASPStateTempApplications
    WHERE AppName = @appName

    IF @appId IS NULL BEGIN
        BEGIN TRAN        

        SELECT @appId = AppId
        FROM [tempdb].dbo.ASPStateTempApplications WITH (TABLOCKX)
        WHERE AppName = @appName
        
        IF @appId IS NULL
        BEGIN
            EXEC GetHashCode @appName, @appId OUTPUT
            
            INSERT [tempdb].dbo.ASPStateTempApplications
            VALUES
            (@appId, @appName)
            
            IF @@ERROR = 2627 
            BEGIN
                DECLARE @dupApp tAppName
            
                SELECT @dupApp = RTRIM(AppName)
                FROM [tempdb].dbo.ASPStateTempApplications 
                WHERE AppId = @appId
                
                RAISERROR(''SQL session state fatal error: hash-code collision between applications ''''%s'''' and ''''%s''''. Please rename the 1st application to resolve the problem.'', 
                            18, 1, @appName, @dupApp)
            END
        END

        COMMIT
    END

    RETURN 0'
EXEC(@cmd)    

GO


/*****************************************************************************/

/* Find out the version */

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItem
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            SET @now = GETUTCDATE()

            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @locked = Locked,
                @lockDate = LockDateLocal,
                @lockCookie = LockCookie,
                @itemShort = CASE @locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE @locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE @locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [tempdb].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItem
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            SET @now = GETDATE()

            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @locked = Locked,
                @lockDate = LockDate,
                @lockCookie = LockCookie,
                @itemShort = CASE @locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE @locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE @locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [tempdb].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
    
EXEC (@cmd)    

GO


/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItem2
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockAge    int OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            SET @now = GETUTCDATE()

            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @locked = Locked,
                @lockAge = DATEDIFF(second, LockDate, @now),
                @lockCookie = LockCookie,
                @itemShort = CASE @locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE @locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE @locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [tempdb].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'

EXEC (@cmd)    

GO

            

/*****************************************************************************/

/* Find out the version */

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItem3
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockAge    int OUTPUT,
            @lockCookie int OUTPUT,
            @actionFlags int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            SET @now = GETUTCDATE()

            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @locked = Locked,
                @lockAge = DATEDIFF(second, LockDate, @now),
                @lockCookie = LockCookie,
                @itemShort = CASE @locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE @locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE @locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,

                /* If the Uninitialized flag (0x1) if it is set,
                   remove it and return InitializeItem (0x1) in actionFlags */
                Flags = CASE
                    WHEN (Flags & 1) <> 0 THEN (Flags & ~1)
                    ELSE Flags
                    END,
                @actionFlags = CASE
                    WHEN (Flags & 1) <> 0 THEN 1
                    ELSE 0
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [tempdb].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItem3
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT,
            @actionFlags int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            SET @now = GETDATE()

            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @locked = Locked,
                @lockDate = LockDate,
                @lockCookie = LockCookie,
                @itemShort = CASE @locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE @locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE @locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,

                /* If the Uninitialized flag (0x1) if it is set,
                   remove it and return InitializeItem (0x1) in actionFlags */
                Flags = CASE
                    WHEN (Flags & 1) <> 0 THEN (Flags & ~1)
                    ELSE Flags
                    END,
                @actionFlags = CASE
                    WHEN (Flags & 1) <> 0 THEN 1
                    ELSE 0
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [tempdb].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
    
EXEC (@cmd)    

GO


/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItemExclusive
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime

            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()
            
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                LockDate = CASE Locked
                    WHEN 0 THEN @now
                    ELSE LockDate
                    END,
                @lockDate = LockDateLocal = CASE Locked
                    WHEN 0 THEN @nowLocal
                    ELSE LockDateLocal
                    END,
                @lockCookie = LockCookie = CASE Locked
                    WHEN 0 THEN LockCookie + 1
                    ELSE LockCookie
                    END,
                @itemShort = CASE Locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE Locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE Locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,
                @locked = Locked,
                Locked = 1
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [tempdb].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItemExclusive
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime

            SET @now = GETDATE()
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @lockDate = LockDate = CASE Locked
                    WHEN 0 THEN @now
                    ELSE LockDate
                    END,
                @lockCookie = LockCookie = CASE Locked
                    WHEN 0 THEN LockCookie + 1
                    ELSE LockCookie
                    END,
                @itemShort = CASE Locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE Locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE Locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,
                @locked = Locked,
                Locked = 1
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [tempdb].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'    

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItemExclusive2
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockAge    int OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime

            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()
            
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                LockDate = CASE Locked
                    WHEN 0 THEN @now
                    ELSE LockDate
                    END,
                LockDateLocal = CASE Locked
                    WHEN 0 THEN @nowLocal
                    ELSE LockDateLocal
                    END,
                @lockAge = CASE Locked
                    WHEN 0 THEN 0
                    ELSE DATEDIFF(second, LockDate, @now)
                    END,
                @lockCookie = LockCookie = CASE Locked
                    WHEN 0 THEN LockCookie + 1
                    ELSE LockCookie
                    END,
                @itemShort = CASE Locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE Locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE Locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,
                @locked = Locked,
                Locked = 1
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [tempdb].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItemExclusive3
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockAge    int OUTPUT,
            @lockCookie int OUTPUT,
            @actionFlags int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime

            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()
            
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                LockDate = CASE Locked
                    WHEN 0 THEN @now
                    ELSE LockDate
                    END,
                LockDateLocal = CASE Locked
                    WHEN 0 THEN @nowLocal
                    ELSE LockDateLocal
                    END,
                @lockAge = CASE Locked
                    WHEN 0 THEN 0
                    ELSE DATEDIFF(second, LockDate, @now)
                    END,
                @lockCookie = LockCookie = CASE Locked
                    WHEN 0 THEN LockCookie + 1
                    ELSE LockCookie
                    END,
                @itemShort = CASE Locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE Locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE Locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,
                @locked = Locked,
                Locked = 1,

                /* If the Uninitialized flag (0x1) if it is set,
                   remove it and return InitializeItem (0x1) in actionFlags */
                Flags = CASE
                    WHEN (Flags & 1) <> 0 THEN (Flags & ~1)
                    ELSE Flags
                    END,
                @actionFlags = CASE
                    WHEN (Flags & 1) <> 0 THEN 1
                    ELSE 0
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [tempdb].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItemExclusive3
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT,
            @actionFlags int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime

            SET @now = GETDATE()
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @lockDate = LockDate = CASE Locked
                    WHEN 0 THEN @now
                    ELSE LockDate
                    END,
                @lockCookie = LockCookie = CASE Locked
                    WHEN 0 THEN LockCookie + 1
                    ELSE LockCookie
                    END,
                @itemShort = CASE Locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE Locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE Locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,
                @locked = Locked,
                Locked = 1,

                /* If the Uninitialized flag (0x1) if it is set,
                   remove it and return InitializeItem (0x1) in actionFlags */
                Flags = CASE
                    WHEN (Flags & 1) <> 0 THEN (Flags & ~1)
                    ELSE Flags
                    END,
                @actionFlags = CASE
                    WHEN (Flags & 1) <> 0 THEN 1
                    ELSE 0
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [tempdb].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'    

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempReleaseStateItemExclusive
            @id         tSessionId,
            @lockCookie int
        AS
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, GETUTCDATE()), 
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempReleaseStateItemExclusive
            @id         tSessionId,
            @lockCookie int
        AS
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, GETDATE()), 
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertUninitializedItem
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int
        AS    

            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime
            
            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()

            INSERT [tempdb].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemShort, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockDateLocal,
                 LockCookie,
                 Flags) 
            VALUES 
                (@id, 
                 @itemShort, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 @nowLocal,
                 1,
                 1)

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertUninitializedItem
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int
        AS    

            DECLARE @now AS datetime
            SET @now = GETDATE()

            INSERT [tempdb].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemShort, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockCookie,
                 Flags) 
            VALUES 
                (@id, 
                 @itemShort, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 1,
                 1)

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertStateItemShort
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int
        AS    

            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime
            
            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()

            INSERT [tempdb].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemShort, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockDateLocal,
                 LockCookie) 
            VALUES 
                (@id, 
                 @itemShort, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 @nowLocal,
                 1)

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertStateItemShort
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int
        AS    

            DECLARE @now AS datetime
            SET @now = GETDATE()

            INSERT [tempdb].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemShort, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockCookie) 
            VALUES 
                (@id, 
                 @itemShort, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 1)

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertStateItemLong
            @id         tSessionId,
            @itemLong   tSessionItemLong,
            @timeout    int
        AS    
            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime
            
            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()

            INSERT [tempdb].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemLong, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockDateLocal,
                 LockCookie) 
            VALUES 
                (@id, 
                 @itemLong, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 @nowLocal,
                 1)

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertStateItemLong
            @id         tSessionId,
            @itemLong   tSessionItemLong,
            @timeout    int
        AS    
            DECLARE @now AS datetime
            SET @now = GETDATE()

            INSERT [tempdb].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemLong, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockCookie) 
            VALUES 
                (@id, 
                 @itemLong, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 1)

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemShort
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETUTCDATE()), 
                SessionItemShort = @itemShort, 
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemShort
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETDATE()), 
                SessionItemShort = @itemShort, 
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemShortNullLong
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETUTCDATE()), 
                SessionItemShort = @itemShort, 
                SessionItemLong = NULL, 
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemShortNullLong
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETDATE()), 
                SessionItemShort = @itemShort, 
                SessionItemLong = NULL, 
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemLong
            @id         tSessionId,
            @itemLong   tSessionItemLong,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETUTCDATE()), 
                SessionItemLong = @itemLong,
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemLong
            @id         tSessionId,
            @itemLong   tSessionItemLong,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETDATE()), 
                SessionItemLong = @itemLong,
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'

EXEC (@cmd)            

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemLongNullShort
            @id         tSessionId,
            @itemLong   tSessionItemLong,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETUTCDATE()), 
                SessionItemLong = @itemLong, 
                SessionItemShort = NULL,
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'
ELSE
    SET @cmd = N'
    CREATE PROCEDURE dbo.TempUpdateStateItemLongNullShort
        @id         tSessionId,
        @itemLong   tSessionItemLong,
        @timeout    int,
        @lockCookie int
    AS    
        UPDATE [tempdb].dbo.ASPStateTempSessions
        SET Expires = DATEADD(n, @timeout, GETDATE()), 
            SessionItemLong = @itemLong, 
            SessionItemShort = NULL,
            Timeout = @timeout,
            Locked = 0
        WHERE SessionId = @id AND LockCookie = @lockCookie

        RETURN 0'

EXEC (@cmd)            

GO


/*****************************************************************************/

DECLARE @cmd nchar(4000)
SET @cmd = N'
    CREATE PROCEDURE dbo.TempRemoveStateItem
        @id     tSessionId,
        @lockCookie int
    AS
        DELETE [tempdb].dbo.ASPStateTempSessions
        WHERE SessionId = @id AND LockCookie = @lockCookie
        RETURN 0'
EXEC(@cmd)    

GO

            
/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempResetTimeout
            @id     tSessionId
        AS
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, GETUTCDATE())
            WHERE SessionId = @id
            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempResetTimeout
            @id     tSessionId
        AS
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, GETDATE())
            WHERE SessionId = @id
            RETURN 0'

EXEC (@cmd)            

GO


            
/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.DeleteExpiredSessions
        AS
            SET NOCOUNT ON
            SET DEADLOCK_PRIORITY LOW 

            DECLARE @now datetime
            SET @now = GETUTCDATE() 

            CREATE TABLE #tblExpiredSessions 
            ( 
                SessionID nvarchar(88) NOT NULL PRIMARY KEY
            )

            INSERT #tblExpiredSessions (SessionID)
                SELECT SessionID
                FROM [tempdb].dbo.ASPStateTempSessions WITH (READUNCOMMITTED)
                WHERE Expires < @now

            IF @@ROWCOUNT <> 0 
            BEGIN 
                DECLARE ExpiredSessionCursor CURSOR LOCAL FORWARD_ONLY READ_ONLY
                FOR SELECT SessionID FROM #tblExpiredSessions 

                DECLARE @SessionID nvarchar(88)

                OPEN ExpiredSessionCursor

                FETCH NEXT FROM ExpiredSessionCursor INTO @SessionID

                WHILE @@FETCH_STATUS = 0 
                    BEGIN
                        DELETE FROM [tempdb].dbo.ASPStateTempSessions WHERE SessionID = @SessionID AND Expires < @now
                        FETCH NEXT FROM ExpiredSessionCursor INTO @SessionID
                    END

                CLOSE ExpiredSessionCursor

                DEALLOCATE ExpiredSessionCursor

            END 

            DROP TABLE #tblExpiredSessions

        RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.DeleteExpiredSessions
        AS
            SET NOCOUNT ON
            SET DEADLOCK_PRIORITY LOW 

            DECLARE @now datetime
            SET @now = GETDATE() 

            CREATE TABLE #tblExpiredSessions 
            ( 
                SessionID nvarchar(88) NOT NULL PRIMARY KEY
            )

            INSERT #tblExpiredSessions (SessionID)
                SELECT SessionID
                FROM [tempdb].dbo.ASPStateTempSessions WITH (READUNCOMMITTED)
                WHERE Expires < @now

            IF @@ROWCOUNT <> 0 
            BEGIN 
                DECLARE ExpiredSessionCursor CURSOR LOCAL FORWARD_ONLY READ_ONLY
                FOR SELECT SessionID FROM #tblExpiredSessions 

                DECLARE @SessionID nvarchar(88)

                OPEN ExpiredSessionCursor

                FETCH NEXT FROM ExpiredSessionCursor INTO @SessionID

                WHILE @@FETCH_STATUS = 0 
                    BEGIN
                        DELETE FROM [tempdb].dbo.ASPStateTempSessions WHERE SessionID = @SessionID AND Expires < @now
                        FETCH NEXT FROM ExpiredSessionCursor INTO @SessionID
                    END

                CLOSE ExpiredSessionCursor

                DEALLOCATE ExpiredSessionCursor

            END 

            DROP TABLE #tblExpiredSessions

        RETURN 0'
EXEC (@cmd)            

GO


DECLARE @sstype nvarchar(128)
SET @sstype = N'sstype_temp'

IF UPPER(@sstype) = 'SSTYPE_TEMP' BEGIN
    DECLARE @cmd nchar(4000)

    SET @cmd = N'
        /* Create the startup procedure */
        CREATE PROCEDURE dbo.ASPState_Startup 
        AS
            EXECUTE ASPState.dbo.CreateTempTables

            RETURN 0'
    EXEC(@cmd)
    EXECUTE sp_procoption @ProcName='dbo.ASPState_Startup', @OptionName='startup', @OptionValue='true'
END    

/*****************************************************************************/

/* Create the job to delete expired sessions */

-- Add job category
-- We expect an error if the category already exists.
PRINT 'If the category already exists, an error from msdb.dbo.sp_add_category is expected.'
EXECUTE msdb.dbo.sp_add_category @name = N'[Uncategorized (Local)]'

GO


BEGIN TRANSACTION            
    DECLARE @JobID BINARY(16)  
    DECLARE @ReturnCode int    
    DECLARE @nameT nchar(200)
    SELECT @ReturnCode = 0     

    -- Add the job
    SET @nameT = N'ASPState' + '_Job_DeleteExpiredSessions'
    EXECUTE @ReturnCode = msdb.dbo.sp_add_job 
            @job_id = @JobID OUTPUT, 
            @job_name = @nameT, 
            @owner_login_name = NULL, 
            @description = N'Deletes expired sessions from the session state database.', 
            @category_name = N'[Uncategorized (Local)]', 
            @enabled = 1, 
            @notify_level_email = 0, 
            @notify_level_page = 0, 
            @notify_level_netsend = 0, 
            @notify_level_eventlog = 0, 
            @delete_level= 0

    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
    
    -- Add the job steps
    SET @nameT = N'ASPState' + '_JobStep_DeleteExpiredSessions'
    EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep 
            @job_id = @JobID,
            @step_id = 1, 
            @step_name = @nameT, 
            @command = N'EXECUTE DeleteExpiredSessions', 
            @database_name = N'ASPState', 
            @server = N'', 
            @subsystem = N'TSQL', 
            @cmdexec_success_code = 0, 
            @flags = 0, 
            @retry_attempts = 0, 
            @retry_interval = 1, 
            @output_file_name = N'', 
            @on_success_step_id = 0, 
            @on_success_action = 1, 
            @on_fail_step_id = 0, 
            @on_fail_action = 2

    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

    EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1 
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
    
    -- Add the job schedules
    SET @nameT = N'ASPState' + '_JobSchedule_DeleteExpiredSessions'
    EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule 
            @job_id = @JobID, 
            @name = @nameT, 
            @enabled = 1, 
            @freq_type = 4,     
            @active_start_date = 20001016, 
            @active_start_time = 0, 
            @freq_interval = 1, 
            @freq_subday_type = 4, 
            @freq_subday_interval = 1, 
            @freq_relative_interval = 0, 
            @freq_recurrence_factor = 0, 
            @active_end_date = 99991231, 
            @active_end_time = 235959

    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
    
    -- Add the Target Servers
    EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'(local)' 
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
    
    COMMIT TRANSACTION          
    GOTO   EndSave              
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION 
EndSave: 

GO


/* Drop all tables, startup procedures, stored procedures and types. */

/* Drop the DeleteExpiredSessions_Job */

DECLARE @jobname nvarchar(200)
SET @jobname = N'DatabaseNamePlaceHolder' + '_Job_DeleteExpiredSessions' 

-- Delete the [local] job 
-- We expected to get an error if the job doesn't exist.
PRINT 'If the job does not exist, an error from msdb.dbo.sp_delete_job is expected.'
EXECUTE msdb.dbo.sp_delete_job @job_name = @jobname

GO


DECLARE @sstype nvarchar(128)
SET @sstype = N'sstype_custom'

IF UPPER(@sstype) = 'SSTYPE_TEMP' AND OBJECT_ID(N'dbo.ASPState_Startup', 'P') IS NOT NULL BEGIN
    DROP PROCEDURE dbo.ASPState_Startup
END    

USE [DatabaseNamePlaceHolder]

GO


/*****************************************************************************/

USE [DatabaseNamePlaceHolder]

/* Find out the version */
DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT

DECLARE @cmd nchar(4000)

IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.CreateTempTables
        AS
            CREATE TABLE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions (
                SessionId           nvarchar(88)    NOT NULL PRIMARY KEY,
                Created             datetime        NOT NULL DEFAULT GETUTCDATE(),
                Expires             datetime        NOT NULL,
                LockDate            datetime        NOT NULL,
                LockDateLocal       datetime        NOT NULL,
                LockCookie          int             NOT NULL,
                Timeout             int             NOT NULL,
                Locked              bit             NOT NULL,
                SessionItemShort    varbinary(7000) NULL,
                SessionItemLong     image           NULL,
                Flags               int             NOT NULL DEFAULT 0,
            ) 

            CREATE NONCLUSTERED INDEX Index_Expires ON [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions(Expires)

            CREATE TABLE [DatabaseNamePlaceHolder].dbo.ASPStateTempApplications (
                AppId               int             NOT NULL PRIMARY KEY,
                AppName             char(280)       NOT NULL,
            ) 

            CREATE NONCLUSTERED INDEX Index_AppName ON [DatabaseNamePlaceHolder].dbo.ASPStateTempApplications(AppName)

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.CreateTempTables
        AS
            CREATE TABLE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions (
                SessionId           nvarchar(88)    NOT NULL PRIMARY KEY,
                Created             datetime        NOT NULL DEFAULT GETDATE(),
                Expires             datetime        NOT NULL,
                LockDate            datetime        NOT NULL,
                LockCookie          int             NOT NULL,
                Timeout             int             NOT NULL,
                Locked              bit             NOT NULL,
                SessionItemShort    varbinary(7000) NULL,
                SessionItemLong     image           NULL,
                Flags               int             NOT NULL DEFAULT 0,
            ) 

            CREATE NONCLUSTERED INDEX Index_Expires ON [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions(Expires)

            CREATE TABLE [DatabaseNamePlaceHolder].dbo.ASPStateTempApplications (
                AppId               int             NOT NULL PRIMARY KEY,
                AppName             char(280)       NOT NULL,
            ) 

            CREATE NONCLUSTERED INDEX Index_AppName ON [DatabaseNamePlaceHolder].dbo.ASPStateTempApplications(AppName)

            RETURN 0'

EXEC (@cmd)

GO


/*****************************************************************************/

DECLARE @cmd nchar(4000)

SET @cmd = N'
    CREATE PROCEDURE dbo.TempGetAppID
    @appName    tAppName,
    @appId      int OUTPUT
    AS
    SET @appName = LOWER(@appName)
    SET @appId = NULL

    SELECT @appId = AppId
    FROM [DatabaseNamePlaceHolder].dbo.ASPStateTempApplications
    WHERE AppName = @appName

    IF @appId IS NULL BEGIN
        BEGIN TRAN        

        SELECT @appId = AppId
        FROM [DatabaseNamePlaceHolder].dbo.ASPStateTempApplications WITH (TABLOCKX)
        WHERE AppName = @appName
        
        IF @appId IS NULL
        BEGIN
            EXEC GetHashCode @appName, @appId OUTPUT
            
            INSERT [DatabaseNamePlaceHolder].dbo.ASPStateTempApplications
            VALUES
            (@appId, @appName)
            
            IF @@ERROR = 2627 
            BEGIN
                DECLARE @dupApp tAppName
            
                SELECT @dupApp = RTRIM(AppName)
                FROM [DatabaseNamePlaceHolder].dbo.ASPStateTempApplications 
                WHERE AppId = @appId
                
                RAISERROR(''SQL session state fatal error: hash-code collision between applications ''''%s'''' and ''''%s''''. Please rename the 1st application to resolve the problem.'', 
                            18, 1, @appName, @dupApp)
            END
        END

        COMMIT
    END

    RETURN 0'
EXEC(@cmd)    

GO


/*****************************************************************************/

/* Find out the version */

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItem
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            SET @now = GETUTCDATE()

            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @locked = Locked,
                @lockDate = LockDateLocal,
                @lockCookie = LockCookie,
                @itemShort = CASE @locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE @locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE @locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItem
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            SET @now = GETDATE()

            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @locked = Locked,
                @lockDate = LockDate,
                @lockCookie = LockCookie,
                @itemShort = CASE @locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE @locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE @locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
    
EXEC (@cmd)    

GO


/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItem2
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockAge    int OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            SET @now = GETUTCDATE()

            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @locked = Locked,
                @lockAge = DATEDIFF(second, LockDate, @now),
                @lockCookie = LockCookie,
                @itemShort = CASE @locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE @locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE @locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'

EXEC (@cmd)    

GO

            

/*****************************************************************************/

/* Find out the version */

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItem3
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockAge    int OUTPUT,
            @lockCookie int OUTPUT,
            @actionFlags int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            SET @now = GETUTCDATE()

            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @locked = Locked,
                @lockAge = DATEDIFF(second, LockDate, @now),
                @lockCookie = LockCookie,
                @itemShort = CASE @locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE @locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE @locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,

                /* If the Uninitialized flag (0x1) if it is set,
                   remove it and return InitializeItem (0x1) in actionFlags */
                Flags = CASE
                    WHEN (Flags & 1) <> 0 THEN (Flags & ~1)
                    ELSE Flags
                    END,
                @actionFlags = CASE
                    WHEN (Flags & 1) <> 0 THEN 1
                    ELSE 0
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItem3
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT,
            @actionFlags int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            SET @now = GETDATE()

            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @locked = Locked,
                @lockDate = LockDate,
                @lockCookie = LockCookie,
                @itemShort = CASE @locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE @locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE @locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,

                /* If the Uninitialized flag (0x1) if it is set,
                   remove it and return InitializeItem (0x1) in actionFlags */
                Flags = CASE
                    WHEN (Flags & 1) <> 0 THEN (Flags & ~1)
                    ELSE Flags
                    END,
                @actionFlags = CASE
                    WHEN (Flags & 1) <> 0 THEN 1
                    ELSE 0
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
    
EXEC (@cmd)    

GO


/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItemExclusive
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime

            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()
            
            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                LockDate = CASE Locked
                    WHEN 0 THEN @now
                    ELSE LockDate
                    END,
                @lockDate = LockDateLocal = CASE Locked
                    WHEN 0 THEN @nowLocal
                    ELSE LockDateLocal
                    END,
                @lockCookie = LockCookie = CASE Locked
                    WHEN 0 THEN LockCookie + 1
                    ELSE LockCookie
                    END,
                @itemShort = CASE Locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE Locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE Locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,
                @locked = Locked,
                Locked = 1
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItemExclusive
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime

            SET @now = GETDATE()
            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @lockDate = LockDate = CASE Locked
                    WHEN 0 THEN @now
                    ELSE LockDate
                    END,
                @lockCookie = LockCookie = CASE Locked
                    WHEN 0 THEN LockCookie + 1
                    ELSE LockCookie
                    END,
                @itemShort = CASE Locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE Locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE Locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,
                @locked = Locked,
                Locked = 1
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'    

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItemExclusive2
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockAge    int OUTPUT,
            @lockCookie int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime

            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()
            
            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                LockDate = CASE Locked
                    WHEN 0 THEN @now
                    ELSE LockDate
                    END,
                LockDateLocal = CASE Locked
                    WHEN 0 THEN @nowLocal
                    ELSE LockDateLocal
                    END,
                @lockAge = CASE Locked
                    WHEN 0 THEN 0
                    ELSE DATEDIFF(second, LockDate, @now)
                    END,
                @lockCookie = LockCookie = CASE Locked
                    WHEN 0 THEN LockCookie + 1
                    ELSE LockCookie
                    END,
                @itemShort = CASE Locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE Locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE Locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,
                @locked = Locked,
                Locked = 1
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItemExclusive3
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockAge    int OUTPUT,
            @lockCookie int OUTPUT,
            @actionFlags int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime

            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()
            
            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                LockDate = CASE Locked
                    WHEN 0 THEN @now
                    ELSE LockDate
                    END,
                LockDateLocal = CASE Locked
                    WHEN 0 THEN @nowLocal
                    ELSE LockDateLocal
                    END,
                @lockAge = CASE Locked
                    WHEN 0 THEN 0
                    ELSE DATEDIFF(second, LockDate, @now)
                    END,
                @lockCookie = LockCookie = CASE Locked
                    WHEN 0 THEN LockCookie + 1
                    ELSE LockCookie
                    END,
                @itemShort = CASE Locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE Locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE Locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,
                @locked = Locked,
                Locked = 1,

                /* If the Uninitialized flag (0x1) if it is set,
                   remove it and return InitializeItem (0x1) in actionFlags */
                Flags = CASE
                    WHEN (Flags & 1) <> 0 THEN (Flags & ~1)
                    ELSE Flags
                    END,
                @actionFlags = CASE
                    WHEN (Flags & 1) <> 0 THEN 1
                    ELSE 0
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempGetStateItemExclusive3
            @id         tSessionId,
            @itemShort  tSessionItemShort OUTPUT,
            @locked     bit OUTPUT,
            @lockDate   datetime OUTPUT,
            @lockCookie int OUTPUT,
            @actionFlags int OUTPUT
        AS
            DECLARE @textptr AS tTextPtr
            DECLARE @length AS int
            DECLARE @now AS datetime

            SET @now = GETDATE()
            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, @now), 
                @lockDate = LockDate = CASE Locked
                    WHEN 0 THEN @now
                    ELSE LockDate
                    END,
                @lockCookie = LockCookie = CASE Locked
                    WHEN 0 THEN LockCookie + 1
                    ELSE LockCookie
                    END,
                @itemShort = CASE Locked
                    WHEN 0 THEN SessionItemShort
                    ELSE NULL
                    END,
                @textptr = CASE Locked
                    WHEN 0 THEN TEXTPTR(SessionItemLong)
                    ELSE NULL
                    END,
                @length = CASE Locked
                    WHEN 0 THEN DATALENGTH(SessionItemLong)
                    ELSE NULL
                    END,
                @locked = Locked,
                Locked = 1,

                /* If the Uninitialized flag (0x1) if it is set,
                   remove it and return InitializeItem (0x1) in actionFlags */
                Flags = CASE
                    WHEN (Flags & 1) <> 0 THEN (Flags & ~1)
                    ELSE Flags
                    END,
                @actionFlags = CASE
                    WHEN (Flags & 1) <> 0 THEN 1
                    ELSE 0
                    END
            WHERE SessionId = @id
            IF @length IS NOT NULL BEGIN
                READTEXT [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions.SessionItemLong @textptr 0 @length
            END

            RETURN 0'    

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempReleaseStateItemExclusive
            @id         tSessionId,
            @lockCookie int
        AS
            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, GETUTCDATE()), 
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempReleaseStateItemExclusive
            @id         tSessionId,
            @lockCookie int
        AS
            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, GETDATE()), 
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertUninitializedItem
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int
        AS    

            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime
            
            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()

            INSERT [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemShort, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockDateLocal,
                 LockCookie,
                 Flags) 
            VALUES 
                (@id, 
                 @itemShort, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 @nowLocal,
                 1,
                 1)

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertUninitializedItem
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int
        AS    

            DECLARE @now AS datetime
            SET @now = GETDATE()

            INSERT [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemShort, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockCookie,
                 Flags) 
            VALUES 
                (@id, 
                 @itemShort, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 1,
                 1)

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertStateItemShort
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int
        AS    

            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime
            
            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()

            INSERT [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemShort, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockDateLocal,
                 LockCookie) 
            VALUES 
                (@id, 
                 @itemShort, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 @nowLocal,
                 1)

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertStateItemShort
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int
        AS    

            DECLARE @now AS datetime
            SET @now = GETDATE()

            INSERT [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemShort, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockCookie) 
            VALUES 
                (@id, 
                 @itemShort, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 1)

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertStateItemLong
            @id         tSessionId,
            @itemLong   tSessionItemLong,
            @timeout    int
        AS    
            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime
            
            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()

            INSERT [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemLong, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockDateLocal,
                 LockCookie) 
            VALUES 
                (@id, 
                 @itemLong, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 @nowLocal,
                 1)

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempInsertStateItemLong
            @id         tSessionId,
            @itemLong   tSessionItemLong,
            @timeout    int
        AS    
            DECLARE @now AS datetime
            SET @now = GETDATE()

            INSERT [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemLong, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockCookie) 
            VALUES 
                (@id, 
                 @itemLong, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 1)

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemShort
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETUTCDATE()), 
                SessionItemShort = @itemShort, 
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemShort
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETDATE()), 
                SessionItemShort = @itemShort, 
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemShortNullLong
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETUTCDATE()), 
                SessionItemShort = @itemShort, 
                SessionItemLong = NULL, 
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemShortNullLong
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETDATE()), 
                SessionItemShort = @itemShort, 
                SessionItemLong = NULL, 
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'

EXEC (@cmd)    

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemLong
            @id         tSessionId,
            @itemLong   tSessionItemLong,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETUTCDATE()), 
                SessionItemLong = @itemLong,
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemLong
            @id         tSessionId,
            @itemLong   tSessionItemLong,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETDATE()), 
                SessionItemLong = @itemLong,
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'

EXEC (@cmd)            

GO



/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempUpdateStateItemLongNullShort
            @id         tSessionId,
            @itemLong   tSessionItemLong,
            @timeout    int,
            @lockCookie int
        AS    
            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, @timeout, GETUTCDATE()), 
                SessionItemLong = @itemLong, 
                SessionItemShort = NULL,
                Timeout = @timeout,
                Locked = 0
            WHERE SessionId = @id AND LockCookie = @lockCookie

            RETURN 0'
ELSE
    SET @cmd = N'
    CREATE PROCEDURE dbo.TempUpdateStateItemLongNullShort
        @id         tSessionId,
        @itemLong   tSessionItemLong,
        @timeout    int,
        @lockCookie int
    AS    
        UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
        SET Expires = DATEADD(n, @timeout, GETDATE()), 
            SessionItemLong = @itemLong, 
            SessionItemShort = NULL,
            Timeout = @timeout,
            Locked = 0
        WHERE SessionId = @id AND LockCookie = @lockCookie

        RETURN 0'

EXEC (@cmd)            

GO


/*****************************************************************************/

DECLARE @cmd nchar(4000)
SET @cmd = N'
    CREATE PROCEDURE dbo.TempRemoveStateItem
        @id     tSessionId,
        @lockCookie int
    AS
        DELETE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
        WHERE SessionId = @id AND LockCookie = @lockCookie
        RETURN 0'
EXEC(@cmd)    

GO

            
/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempResetTimeout
            @id     tSessionId
        AS
            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, GETUTCDATE())
            WHERE SessionId = @id
            RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.TempResetTimeout
            @id     tSessionId
        AS
            UPDATE [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, GETDATE())
            WHERE SessionId = @id
            RETURN 0'

EXEC (@cmd)            

GO


            
/*****************************************************************************/

DECLARE @ver int
EXEC dbo.GetMajorVersion @@ver=@ver OUTPUT
DECLARE @cmd nchar(4000)
IF (@ver >= 8)
    SET @cmd = N'
        CREATE PROCEDURE dbo.DeleteExpiredSessions
        AS
            SET NOCOUNT ON
            SET DEADLOCK_PRIORITY LOW 

            DECLARE @now datetime
            SET @now = GETUTCDATE() 

            CREATE TABLE #tblExpiredSessions 
            ( 
                SessionID nvarchar(88) NOT NULL PRIMARY KEY
            )

            INSERT #tblExpiredSessions (SessionID)
                SELECT SessionID
                FROM [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions WITH (READUNCOMMITTED)
                WHERE Expires < @now

            IF @@ROWCOUNT <> 0 
            BEGIN 
                DECLARE ExpiredSessionCursor CURSOR LOCAL FORWARD_ONLY READ_ONLY
                FOR SELECT SessionID FROM #tblExpiredSessions 

                DECLARE @SessionID nvarchar(88)

                OPEN ExpiredSessionCursor

                FETCH NEXT FROM ExpiredSessionCursor INTO @SessionID

                WHILE @@FETCH_STATUS = 0 
                    BEGIN
                        DELETE FROM [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions WHERE SessionID = @SessionID AND Expires < @now
                        FETCH NEXT FROM ExpiredSessionCursor INTO @SessionID
                    END

                CLOSE ExpiredSessionCursor

                DEALLOCATE ExpiredSessionCursor

            END 

            DROP TABLE #tblExpiredSessions

        RETURN 0'
ELSE
    SET @cmd = N'
        CREATE PROCEDURE dbo.DeleteExpiredSessions
        AS
            SET NOCOUNT ON
            SET DEADLOCK_PRIORITY LOW 

            DECLARE @now datetime
            SET @now = GETDATE() 

            CREATE TABLE #tblExpiredSessions 
            ( 
                SessionID nvarchar(88) NOT NULL PRIMARY KEY
            )

            INSERT #tblExpiredSessions (SessionID)
                SELECT SessionID
                FROM [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions WITH (READUNCOMMITTED)
                WHERE Expires < @now

            IF @@ROWCOUNT <> 0 
            BEGIN 
                DECLARE ExpiredSessionCursor CURSOR LOCAL FORWARD_ONLY READ_ONLY
                FOR SELECT SessionID FROM #tblExpiredSessions 

                DECLARE @SessionID nvarchar(88)

                OPEN ExpiredSessionCursor

                FETCH NEXT FROM ExpiredSessionCursor INTO @SessionID

                WHILE @@FETCH_STATUS = 0 
                    BEGIN
                        DELETE FROM [DatabaseNamePlaceHolder].dbo.ASPStateTempSessions WHERE SessionID = @SessionID AND Expires < @now
                        FETCH NEXT FROM ExpiredSessionCursor INTO @SessionID
                    END

                CLOSE ExpiredSessionCursor

                DEALLOCATE ExpiredSessionCursor

            END 

            DROP TABLE #tblExpiredSessions

        RETURN 0'
EXEC (@cmd)            

GO


DECLARE @sstype nvarchar(128)
SET @sstype = N'sstype_custom'

IF UPPER(@sstype) = 'SSTYPE_TEMP' BEGIN
    DECLARE @cmd nchar(4000)

    SET @cmd = N'
        /* Create the startup procedure */
        CREATE PROCEDURE dbo.ASPState_Startup 
        AS
            EXECUTE ASPState.dbo.CreateTempTables

            RETURN 0'
    EXEC(@cmd)
    EXECUTE sp_procoption @ProcName='dbo.ASPState_Startup', @OptionName='startup', @OptionValue='true'
END    

/*****************************************************************************/

/* Create the job to delete expired sessions */

-- Add job category
-- We expect an error if the category already exists.
PRINT 'If the category already exists, an error from msdb.dbo.sp_add_category is expected.'
EXECUTE msdb.dbo.sp_add_category @name = N'[Uncategorized (Local)]'

GO


BEGIN TRANSACTION            
    DECLARE @JobID BINARY(16)  
    DECLARE @ReturnCode int    
    DECLARE @nameT nchar(200)
    SELECT @ReturnCode = 0     

    -- Add the job
    SET @nameT = N'DatabaseNamePlaceHolder' + '_Job_DeleteExpiredSessions'
    EXECUTE @ReturnCode = msdb.dbo.sp_add_job 
            @job_id = @JobID OUTPUT, 
            @job_name = @nameT, 
            @owner_login_name = NULL, 
            @description = N'Deletes expired sessions from the session state database.', 
            @category_name = N'[Uncategorized (Local)]', 
            @enabled = 1, 
            @notify_level_email = 0, 
            @notify_level_page = 0, 
            @notify_level_netsend = 0, 
            @notify_level_eventlog = 0, 
            @delete_level= 0

    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
    
    -- Add the job steps
    SET @nameT = N'DatabaseNamePlaceHolder' + '_JobStep_DeleteExpiredSessions'
    EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep 
            @job_id = @JobID,
            @step_id = 1, 
            @step_name = @nameT, 
            @command = N'EXECUTE DeleteExpiredSessions', 
            @database_name = N'DatabaseNamePlaceHolder', 
            @server = N'', 
            @database_user_name = N'', 
            @subsystem = N'TSQL', 
            @cmdexec_success_code = 0, 
            @flags = 0, 
            @retry_attempts = 0, 
            @retry_interval = 1, 
            @output_file_name = N'', 
            @on_success_step_id = 0, 
            @on_success_action = 1, 
            @on_fail_step_id = 0, 
            @on_fail_action = 2

    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

    EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1 
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
    
    -- Add the job schedules
    SET @nameT = N'DatabaseNamePlaceHolder' + '_JobSchedule_DeleteExpiredSessions'
    EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule 
            @job_id = @JobID, 
            @name = @nameT, 
            @enabled = 1, 
            @freq_type = 4,     
            @active_start_date = 20001016, 
            @active_start_time = 0, 
            @freq_interval = 1, 
            @freq_subday_type = 4, 
            @freq_subday_interval = 1, 
            @freq_relative_interval = 0, 
            @freq_recurrence_factor = 0, 
            @active_end_date = 99991231, 
            @active_end_time = 235959

    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
    
    -- Add the Target Servers
    EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'(local)' 
    IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
    
    COMMIT TRANSACTION          
    GOTO   EndSave              
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION 
EndSave: 

GO


/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/
/*************************************************************/

DECLARE @dbname NVARCHAR(128)

SET @dbname = N'aspnetdb'

IF (NOT EXISTS (SELECT name
                FROM master.dbo.sysdatabases
                WHERE ('[' + name + ']' = @dbname OR name = @dbname)))
BEGIN
  RAISERROR('The database ''%s'' cannot be found. Please run InstallCommon.sql first.', 18, 1, @dbname)
END

GO


/*************************************************************/
/*************************************************************/

--
--Create Health Monitoring schema version
--

DECLARE @command nvarchar(4000)
SET @command = 'GRANT EXECUTE ON [dbo].aspnet_RegisterSchemaVersion TO ' + QUOTENAME(user)
EXECUTE (@command)

GO


/*************************************************************/
/*************************************************************/

DECLARE @command nvarchar(4000)
SET @command = 'REVOKE EXECUTE ON [dbo].aspnet_RegisterSchemaVersion FROM ' + QUOTENAME(user)
EXECUTE (@command)


GO
