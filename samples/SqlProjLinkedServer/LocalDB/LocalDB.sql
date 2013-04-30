EXEC sp_addlinkedserver   
   @server=N'RemoteServer', 
   @srvproduct=N'',
   @provider=N'SQLNCLI', 
   @datasrc=N'localhost\sql2012';
go

create view dbo.SelectFromRemoteDB
as
select	*
from	[$(RemoteServer)].[$(RemoteDB)].[RemoteSchema].[RemoteTable]
go
