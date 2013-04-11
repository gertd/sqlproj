CREATE VIEW [DataWarehouseTableMetadata]
AS 
SELECT	t.[name],t.[_schema_name]
FROM	(
		SELECT	t.*,_schema_name = OBJECT_SCHEMA_NAME(t.[object_id], DB_ID('$(DataWarehouse)'))
		FROM	[$(DataWarehouse)].[sys].[tables] t
		)t
CROSS APPLY [$(DataWarehouse)]..fn_listextendedproperty('@vWarehouseTableTypeExPropName',		'schema',_schema_name,'table',t.[name],default,default) ep_type
CROSS APPLY [$(DataWarehouse)]..fn_listextendedproperty('@vDoCodeGenerationFlagExPropName',	'schema',_schema_name,'table',t.[name],default,default) ep_codegen
GO
