create table dbo.t1
(
	id int not null identity(1, 1) primary key clustered,
	c1 nvarchar(100) not null
)
go

create proc dbo.p1
as
print N'Hello I am Self Referencing my database name'
select id, c1 from [$(DatabaseName)].dbo.t1
go


/*
Warning	1	SQL71562: Procedure: [dbo].[p2] has an unresolved reference to object [SqlProjSelfRef].[dbo].[t1].	D:\Users\gertd\Dropbox\Projects\SqlProjSelfRef\SqlProjSelfRef.sql	18	20	SqlProjSelfRef
Warning	2	SQL71562: Procedure: [dbo].[p2] has an unresolved reference to object [SqlProjSelfRef].[dbo].[t1].[id].	D:\Users\gertd\Dropbox\Projects\SqlProjSelfRef\SqlProjSelfRef.sql	18	8	SqlProjSelfRef
Warning	3	SQL71562: Procedure: [dbo].[p2] has an unresolved reference to object [SqlProjSelfRef].[dbo].[t1].[c1].	D:\Users\gertd\Dropbox\Projects\SqlProjSelfRef\SqlProjSelfRef.sql	18	12	SqlProjSelfRef
*/
/*
create proc dbo.p2
as
print N'Hello I am Self Referencing my database name'
select id, c1 from [SqlProjSelfRef].dbo.t1
go
*/

create view dbo.v1
as
select id, c1 from [$(DatabaseName)].dbo.t1
go

/*
Error	1	SQL71561: View: [dbo].[v2] has an unresolved reference to object [SqlProjSelfRef].[dbo].[t1].	D:\Users\gertd\Dropbox\Projects\SqlProjSelfRef\SqlProjSelfRef.sql	34	20	SqlProjSelfRef
Error	2	SQL71561: View: [dbo].[v2] has an unresolved reference to object [SqlProjSelfRef].[dbo].[t1].[id].	D:\Users\gertd\Dropbox\Projects\SqlProjSelfRef\SqlProjSelfRef.sql	34	8	SqlProjSelfRef
Error	3	SQL71561: View: [dbo].[v2] has an unresolved reference to object [SqlProjSelfRef].[dbo].[t1].[c1].	D:\Users\gertd\Dropbox\Projects\SqlProjSelfRef\SqlProjSelfRef.sql	34	12	SqlProjSelfRef
Error	4	SQL71561: Computed Column: [dbo].[v2].[id] has an unresolved reference to object [SqlProjSelfRef].[dbo].[t1].[id].	D:\Users\gertd\Dropbox\Projects\SqlProjSelfRef\SqlProjSelfRef.sql	34	8	SqlProjSelfRef
Error	5	SQL71561: Computed Column: [dbo].[v2].[c1] has an unresolved reference to object [SqlProjSelfRef].[dbo].[t1].[c1].	D:\Users\gertd\Dropbox\Projects\SqlProjSelfRef\SqlProjSelfRef.sql	34	12	SqlProjSelfRef
*/
/*
create view dbo.v2
as
select id, c1 from [SqlProjSelfRef].dbo.t1
go
*/
