CREATE SCHEMA [sql]
GO

CREATE TABLE [sql].[IPTable] 
(
	IP1 tinyint not null,
	IP2 tinyint not null,
	IP3 tinyint not null,
	IP4 tinyint not null,
	IP  clr.IPv4 not null
)
GO

CREATE PROC [sql].[AddIPAddress](@IP clr.IPv4)
AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO [sql].[IPTable](IP) values(@IP)
	RETURN @@rowcount
END
GO

CREATE FUNCTION [sql].[GetIPAdress](@IP1 tinyint, @IP2 tinyint, @IP3 tinyint, @IP4 tinyint)
RETURNS clr.IPv4
AS
BEGIN
	DECLARE @ip clr.IPv4
	SELECT 	@ip = clr.IPv4::CreateIPv4(@IP1, @IP2, @IP3, @IP4)
	RETURN  @ip
END
GO

CREATE PROCEDURE [dbo].[IPv4TestProc]
	@p1 tinyint = 0, 
	@p2 tinyint = 0,
	@p3 tinyint = 0,
	@p4 tinyint = 0,
	@p5 clr.IPv4 output
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @ip clr.IPv4 
	SELECT  @ip = clr.IPv4::CreateIPv4(@p1, @p2, @p3, @p4)

	SELECT 	@p5 = IP.IP
	FROM 	sql.IPTable as IP
	WHERE 	IP.IP1 = @p1
	AND		IP.IP2 = @p2
	AND		IP.IP3 = @p3
	AND 	IP.IP4 = @p4
	
	RETURN @@rowcount
END
GO

CREATE VIEW [dbo].[IPv4TestView1] 
AS
SELECT 	IP  as IPv40,
		IP1 as IPv41,
		IP2 as IPv42,
		IP3 as IPv43,
		IP4 as IPv44
FROM 	sql.IPTable
WHERE 	IP = clr.IPv4::CreateIPv4(IP1, IP2, IP3, IP4)
GO

CREATE VIEW [dbo].[IPv4TestView2]
AS
SELECT 	IP  as IPv40,
		IP1 as IPv41,
		IP2 as IPv42,
		IP3 as IPv43,
		IP4 as IPv44
FROM 	sql.IPTable
WHERE 	IP = clr.IPv4::IP255255255255
GO
