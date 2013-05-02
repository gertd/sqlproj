CREATE TABLE dbo.aspnet_WebEvent_Events (
        EventId         char(32)            PRIMARY KEY,
        EventTimeUtc    datetime            NOT NULL,
        EventTime       datetime            NOT NULL,
        EventType       nvarchar(256)       NOT NULL,
        EventSequence   decimal(19,0)       NOT NULL, /* SQL7 doesn't support bigint */
        EventOccurrence decimal(19,0)       NOT NULL, /* SQL7 doesn't support bigint */
        EventCode       int                 NOT NULL,
        EventDetailCode int                 NOT NULL,
        Message         nvarchar(1024)      NULL,
        ApplicationPath nvarchar(256)       NULL,
        ApplicationVirtualPath nvarchar(256) NULL,
        MachineName     nvarchar(256)       NOT NULL,
        RequestUrl      nvarchar(1024)      NULL,
        ExceptionType   nvarchar(256)       NULL,
        Details         ntext               NULL
  )

