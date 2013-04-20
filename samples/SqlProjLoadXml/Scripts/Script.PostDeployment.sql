/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
print 'Post deployment script'

declare @h int
declare @x xml

select @x = bulkcolumn FROM OPENROWSET(BULK N'$(XMLDATAPATH)\CustomerData.xml', SINGLE_BLOB) AS x

exec sp_xml_preparedocument @h OUTPUT, @x

insert into dbo.Customers
select	* 
from	openxml(@h, N'/root/Customers', 1)
with
(
    [CustomerID]   NCHAR (5),
    [CompanyName]  NVARCHAR (40),
    [ContactName]  NVARCHAR (30),
    [ContactTitle] NVARCHAR (30),
    [Address]      NVARCHAR (60),
    [City]         NVARCHAR (15),
    [Region]       NVARCHAR (15),
    [PostalCode]   NVARCHAR (10),
    [Country]      NVARCHAR (15),
    [Phone]        NVARCHAR (24),
    [Fax]          NVARCHAR (24)
) 

print 'Inserted in to Customers ' + convert(nvarchar(10), @@rowcount)

exec sp_xml_removedocument @h;
go
