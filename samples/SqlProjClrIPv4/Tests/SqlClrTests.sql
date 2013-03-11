PRINT N'SqlClrTests.sql'
GO

SET NOCOUNT ON;
GO

-- default value is NULL
DECLARE	@ip [clr].[IPv4];
SELECT	@ip.ToString();
GO

-- convert from string
DECLARE @ip [clr].[IPv4];
SELECT  @ip = CONVERT([clr].[IPv4], '1.2.3.4');
SELECT  @ip, @ip.ToString();
GO

-- using static accessor to create value
DECLARE @ip [clr].[IPv4];
SELECT 	@ip = [clr].[IPv4]::[CreateIPv4](5,6,7,8);
SELECT  @ip, @ip.ToString();
GO

-- chaining of functions
-- SELECT [clr].[IsValidIPv4]([clr].[CreateIPv4](2,3,2,4));
SELECT [clr].[IsValidIPv4]([clr].[IPv4]::[CreateIPv4](1,2,3,4));
GO

-- table variable
DECLARE @IP2 AS TABLE
(
	IP1 tinyint not null,
	IP2 tinyint not null,
	IP3 tinyint not null,
	IP4 tinyint not null,
	IP  [clr].[IPv4] not null
)

INSERT 	INTO @IP2 VALUES(100, 1, 169, 1, clr.IPv4::CreateIPv4(100,1,169,1));
SELECT 	CONVERT(nchar(15), IP)
FROM 	@IP2
GO

--
-- add test data
--
DECLARE	@i1 tinyint,
		@i2 tinyint,
		@i3 tinyint,
		@i4 tinyint,
		@ip clr.IPv4,
		@max tinyint 

SELECT 	@i1 = 0,
		@i2 = 0,
		@i3 = 0,
		@i4 = 0,
		@max = 10
		
WHILE (@i1 < @max)
BEGIN
	SELECT @i1 = @i1 + 1

	WHILE (@i2 < @max)
	BEGIN
		SELECT @i2 = @i2 + 1

		WHILE (@i3 < @max)
		BEGIN
			SELECT @i3 = @i3 + 1

			BEGIN TRAN

			WHILE (@i4 < @max)
			BEGIN
				SELECT @i4 = @i4 + 1

				-- SELECT i1 = @i1, i2 = @i2, i3 = @i3, i4 = @i4

				INSERT INTO sql.IPTable VALUES(@i1, @i2, @i3, @i4, clr.IPv4::CreateIPv4(@i1, @i2, @i3, @i4))
			END
		
			COMMIT TRAN

			SELECT @i4 = 0
		END
		SELECT @i3 = 0
	END
	SELECT @i2 = 0
END
GO

DECLARE	@ip clr.IPv4
SELECT  @ip = clr.IPv4::CreateIPv4(255, 255, 255, 255)
IF (@ip = clr.IPv4::IP255255255255)
BEGIN
	PRINT '255.255.255.255'
END
GO

INSERT INTO sql.IPTable VALUES(1, 1, 1, 1, clr.IPv4::CreateIPv4(1, 1, 1, 1))
INSERT INTO sql.IPTable VALUES(255, 255, 255, 255, clr.IPv4::CreateIPv4(255, 255, 255, 255))
GO

DECLARE @IP clr.IPv4
EXEC	[dbo].[IPv4TestProc] @p1 = 255, @p2 = 255, @p3 = 255, @p4 = 255, @p5 = @IP OUTPUT
SELECT  @IP.ToString() AS IP,
		CASE @IP
		WHEN clr.IPv4::IP255255255255 THEN N'EQUAL' ELSE N'NO EQUAL' END
GO

DECLARE	@ip clr.IPv4
EXEC	[dbo].[IPv4TestProc] @p5 = @ip output, @p1 = 1, @p2 = 1, @p3 = 1, @p4 = 1
SELECT	@ip
GO

SELECT	* 
FROM	dbo.IPv4TestView1
GO

SELECT	*
FROM	dbo.IPv4TestView2
GO
