create table dbo.RestaurantOrder
(
	RestaurantOrderId	uniqueidentifier not null primary key nonclustered,
	CustomerId			uniqueidentifier not null,
	RestaurantId		uniqueidentifier not null,
	OrderDetail			xml not null,
	SubmittedDate		datetime not null,
	Total				money not null default 0,
	WorkflowId			uniqueidentifier null,
	WorkflowStatus		nvarchar(50) null,
	OrderStatusUpdatedTime	datetime null,
	DeliverySpecialistUsername	nvarchar(50) null
)
GO
create nonclustered index NCI_RestaurantOrder_CustomertId
on dbo.RestaurantOrder 
(
	CustomerId
)
GO
create nonclustered index NCI_RestaurantOrder_RestaurantId 
on dbo.RestaurantOrder 
(
	RestaurantId 
)