create table dbo.RemoteEnums
(
	[Id]		int not null identity primary key clustered,
	[EnumName]	nvarchar(30) not null,
	[Item]		nvarchar(30) not null,
	[Value]		int not null
)
GO
create unique nonclustered index Idx_EnumNameItemValue ON dbo.RemoteEnums 
(
	EnumName,
	Item,
	Value
)
GO
create unique nonclustered index Idx_EnumNameValueItem ON dbo.RemoteEnums 
(
	EnumName,
	Value,
	Item
)