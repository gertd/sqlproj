create function dbo.RemoteGetEnumIntValue(@name nvarchar(30), @item nvarchar(30))
returns int
as
begin
	declare @value int
	select  @value = Value
	from	dbo.RemoteEnums
	where	EnumName = @name
	and		Item = @item
	return  @value
end