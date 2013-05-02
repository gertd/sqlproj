create schema RemoteSchema
go

create table RemoteSchema.RemoteTable
(
	id int not null identity(1, 1) primary key clustered,
	ref int not null,
	name nvarchar(100) not null,
	created datetime not null default getdate()
)
go
