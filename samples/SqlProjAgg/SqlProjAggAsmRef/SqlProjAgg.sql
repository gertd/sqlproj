CREATE SCHEMA [Sales] AUTHORIZATION [dbo];
GO

CREATE TABLE [Sales].[Customer] (
	[CustomerID]    INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
	[PersonID]      INT              NULL,
	[StoreID]       INT              NULL,
	[TerritoryID]   INT              NULL,
	[SalesPersonID]	INT				 NULL,
	[ModifiedDate]  DATETIME         NOT NULL
);
GO

CREATE TABLE [Sales].[Store] (
	[BusinessEntityID] INT                                                NOT NULL,
	[Name]             NVARCHAR(50)                                       NOT NULL,
	[SalesPersonID]    INT                                                NULL,
	[CustomerID]	   INT                                                NULL,
	[ModifiedDate]     DATETIME                                           NOT NULL
);
GO

CREATE TABLE [Sales].[SalesPerson] (
	[SalesPersonID]	   INT              NOT NULL,
	[TerritoryID]      INT              NULL,
	[SalesQuota]       MONEY            NULL,
	[Bonus]            MONEY            NOT NULL,
	[CommissionPct]    SMALLMONEY       NOT NULL,
	[SalesYTD]         MONEY            NOT NULL,
	[SalesLastYear]    MONEY            NOT NULL,
	[ModifiedDate]     DATETIME         NOT NULL
);
GO

CREATE VIEW vUsingAgg
AS
SELECT		scu.SalesPersonID, 
			dbo.Concatenate(sst.Name) AS ConcateName
FROM		Sales.Customer as scu 
INNER JOIN	Sales.Store as sst ON scu.CustomerID = sst.CustomerID
INNER JOIN	Sales.SalesPerson as spr ON scu.SalesPersonID = spr.SalesPersonID
WHERE		scu.SalesPersonID = 283
GROUP BY	scu.SalesPersonID
GO
