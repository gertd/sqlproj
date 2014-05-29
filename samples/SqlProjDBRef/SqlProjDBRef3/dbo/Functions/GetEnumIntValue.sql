create function dbo.GetEnumIntValue(@name nvarchar(30), @item nvarchar(30))
returns int
as
begin
	declare @value int
	select  @value = Value
	from	dbo.Enums
	where	EnumName = @name
	and		Item = @item
	return  @value
end