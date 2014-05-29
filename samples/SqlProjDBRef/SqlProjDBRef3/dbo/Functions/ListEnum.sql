create function dbo.ListEnum(@name nvarchar(30))
returns table
as
return
(
	select	Item,
			Value
	from	dbo.Enums
	where	EnumName = @name
);