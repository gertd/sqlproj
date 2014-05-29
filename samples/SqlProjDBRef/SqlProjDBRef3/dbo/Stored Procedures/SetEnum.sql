create proc dbo.SetEnum @name nvarchar(30), @item nvarchar(30), @value int
as
begin
	set nocount on
	if exists (select * from dbo.Enums where EnumName = @name and Item = @item)
	begin
		update	dbo.Enums 
		set		Value = @value 
		where	EnumName = @name 
		and		Item = @item
	end
	else
	begin
		insert	dbo.Enums(EnumName, Item, Value)
		values( @name, @item, @value)
	end
	
end