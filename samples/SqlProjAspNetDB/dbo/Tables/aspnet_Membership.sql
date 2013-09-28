CREATE TABLE dbo.aspnet_Membership (
        ApplicationId                           uniqueidentifier    NOT NULL FOREIGN KEY REFERENCES dbo.aspnet_Applications(ApplicationId),
        UserId                                  uniqueidentifier    NOT NULL PRIMARY KEY NONCLUSTERED FOREIGN KEY REFERENCES dbo.aspnet_Users(UserId),
        Password                                nvarchar(128)       NOT NULL,
        PasswordFormat                          int                 NOT NULL DEFAULT 0,
        PasswordSalt                            nvarchar(128)       NOT NULL,
        MobilePIN                               nvarchar(16),
        Email                                   nvarchar(256),
        LoweredEmail                            nvarchar(256),
        PasswordQuestion                        nvarchar(256),
        PasswordAnswer                          nvarchar(128),
        IsApproved                              bit                 NOT NULL,
        IsLockedOut                             bit                 NOT NULL,
        CreateDate                              datetime            NOT NULL,
        LastLoginDate                           datetime            NOT NULL,
        LastPasswordChangedDate                 datetime            NOT NULL,
        LastLockoutDate                         datetime            NOT NULL,
        FailedPasswordAttemptCount              int                 NOT NULL,
        FailedPasswordAttemptWindowStart        datetime            NOT NULL,
        FailedPasswordAnswerAttemptCount        int                 NOT NULL,
        FailedPasswordAnswerAttemptWindowStart  datetime            NOT NULL,
        Comment                                 ntext )


GO



GO
CREATE CLUSTERED INDEX aspnet_Membership_index ON aspnet_Membership(ApplicationId, LoweredEmail)

