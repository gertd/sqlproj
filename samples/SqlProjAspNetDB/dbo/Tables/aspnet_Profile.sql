CREATE TABLE dbo.aspnet_Profile (
        UserId                   uniqueidentifier   PRIMARY KEY FOREIGN KEY REFERENCES dbo.aspnet_Users(UserId),
        PropertyNames            ntext NOT NULL,
        PropertyValuesString     ntext NOT NULL,
        PropertyValuesBinary     image NOT NULL,
        LastUpdatedDate          datetime NOT NULL)


GO


