create view dbo.Restaurants
as
select	R.Name AS Name,
		R.StreetAddress AS StreetAddress,
		R.PostalCode AS PostalCode,
		R.City AS City,
		R.State AS State,
		RC.Description AS Catergory,
		R.Description AS Description 
from	dbo.Restaurant as R
join	dbo.RestaurantCategory AS RC
on		R.RestaurantCategoryId = RC.RestaurantCategoryId