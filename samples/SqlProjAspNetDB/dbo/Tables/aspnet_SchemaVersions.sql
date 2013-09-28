CREATE TABLE [dbo].aspnet_SchemaVersions (
    Feature                  nvarchar(128)  NOT NULL PRIMARY KEY CLUSTERED( Feature, CompatibleSchemaVersion ),
    CompatibleSchemaVersion  nvarchar(128)	NOT NULL,
    IsCurrentVersion         bit            NOT NULL )

