﻿create function dbo.RemoteGetEnumStringValue(@name nvarchar(30), @value int)
returns nvarchar(30)
as
begin
	declare @item nvarchar(30)
	select  @item = Item 
	from	dbo.RemoteEnums
	where	EnumName = @name
	and		Value = @value
	return  @item
end