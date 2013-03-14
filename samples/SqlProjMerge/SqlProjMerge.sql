CREATE TABLE Production.UpdatedInventory
    (ProductID INT NOT NULL, LocationID int, NewQty int, PreviousQty int,
     CONSTRAINT PK_Inventory PRIMARY KEY CLUSTERED (ProductID, LocationID));
GO
CREATE PROC MergeTest
AS

INSERT INTO Production.UpdatedInventory
SELECT ProductID, LocationID, NewQty, PreviousQty 
FROM
(    MERGE AW2012.Production.ProductInventory AS pi
     USING (SELECT ProductID, SUM(OrderQty) 
            FROM AW2012.Sales.SalesOrderDetail AS sod
            JOIN AW2012.Sales.SalesOrderHeader AS soh
            ON sod.SalesOrderID = soh.SalesOrderID
            AND soh.OrderDate BETWEEN '20030701' AND '20030731'
            GROUP BY ProductID) AS src (ProductID, OrderQty)
     ON pi.ProductID = src.ProductID
    WHEN MATCHED AND pi.Quantity - src.OrderQty >= 0 
        THEN UPDATE SET pi.Quantity = pi.Quantity - src.OrderQty
    WHEN MATCHED AND pi.Quantity - src.OrderQty <= 0 
        THEN DELETE
    OUTPUT $action, Inserted.ProductID, Inserted.LocationID, Inserted.Quantity AS NewQty, Deleted.Quantity AS PreviousQty)
 AS Changes (Action, ProductID, LocationID, NewQty, PreviousQty) WHERE $action = 'UPDATE';
GO
