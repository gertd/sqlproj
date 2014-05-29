create table dbo.Enums
(
	[Id]		int not null identity primary key clustered,
	[EnumName]	nvarchar(30) not null,
	[Item]		nvarchar(30) not null,
	[Value]		int not null
)
GO
create unique nonclustered index Idx_EnumNameItemValue ON dbo.Enums 
(
	EnumName,
	Item,
	Value
)
GO
create unique nonclustered index Idx_EnumNameValueItem ON dbo.Enums 
(
	EnumName,
	Value,
	Item
)