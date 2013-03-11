CREATE SCHEMA [clr] 
GO

CREATE TYPE [clr].[IPv4]
EXTERNAL name SqlProjClrIPv4.IPv4
GO

CREATE PROC [clr].[SwitchIPv4](@ip1 clr.IPv4 output, @ip2 clr.IPv4 output)
AS 
EXTERNAL NAME SqlProjClrIPv4.StoredProcedures.SwitchIPv4
GO

CREATE FUNCTION [clr].[IsValidIPv4](@ip clr.IPv4)
RETURNS BIT
AS
EXTERNAL NAME SqlProjClrIPv4.UserDefinedFunctions.IsValidIPv4
GO

CREATE FUNCTION [clr].[CreateIP](@ip1 tinyint, @ip2 tinyint, @ip3 tinyint, @ip4 tinyint)
RETURNS clr.IPv4
AS
EXTERNAL NAME SqlProjClrIPv4.UserDefinedFunctions.CreateIPv4
GO
