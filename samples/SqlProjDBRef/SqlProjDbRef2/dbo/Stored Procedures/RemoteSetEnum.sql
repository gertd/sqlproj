create proc dbo.RemoteSetEnum @name nvarchar(30), @item nvarchar(30), @value int
as
begin
	set nocount on
	if exists (select * from dbo.RemoteEnums with (updlock, holdlock) where EnumName = @name and Item = @item)
	begin
		update	dbo.RemoteEnums 
		set		Value = @value 
		where	EnumName = @name 
		and		Item = @item
	end
	else
	begin
		insert	dbo.RemoteEnums(EnumName, Item, Value)
		values( @name, @item, @value)
	end
	
end