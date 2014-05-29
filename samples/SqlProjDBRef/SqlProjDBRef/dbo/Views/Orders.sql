create view dbo.Orders
as
select	O.OrderId, 
		O.SubmittedDate, 
		O.CustomerID, 
		O.Total, 
		O.ContactTelephone, 
		O.PostalCode, 
		O.State, 
		O.StreetAddress, 
		O.City,
		OD.OrderDetailId, 
		-- OD.OrderId, 
		OD.RestaurantId, 
		OD.MenuItemId, 
		OD.DeliveryId, 
		OD.Quantity, 
		OD.UnitCost, 
		OD.Status, 
		OD.StatusUpdatedTime, 
		OD.WorkflowId, 
		OD.ETA
from	dbo.[Order] as O
join	dbo.OrderDetail as OD 
on		O.OrderId = OD.OrderId