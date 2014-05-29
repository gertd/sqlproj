create function dbo.RemoteListEnum(@name nvarchar(30))
returns table
as
return
(
	select	Item,
			Value
	from	dbo.RemoteEnums
	where	EnumName = @name
);