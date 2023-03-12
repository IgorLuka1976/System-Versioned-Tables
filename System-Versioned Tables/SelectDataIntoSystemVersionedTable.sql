---Important
USE [AdventureWorks2019]
GO

/****** Script for Query for changes to specific rows over time  Script Date: 12.03.2023 by Igor Luca******/
/***If Rows were changed in period from 2023-03-12 17:49 to 2023-03-12 17:59, query below will show this***/
SELECT  
       [SalesOrderDetailID]     
      ,[OrderQty]
	  ,LineTotal
  FROM [Sales].[SalesOrderDetail_SV]
  FOR SYSTEM_TIME CONTAINED IN ('2023-03-12 17:49', '2023-03-12 17:59')
  ORDER BY ValidFrom DESC;

  /**If need to determine whether the ros is up-to-date**/
  SELECT  
       [SalesOrderDetailID]     
      ,[OrderQty]
	  ,LineTotal
	  ,ValidFrom
	  ,ValidTo
	  ,IIF (YEAR(ValidTo) = 9999, 1, 0) AS IsActual
  FROM [Sales].[SalesOrderDetail_SV]
  FOR SYSTEM_TIME FROM '2023-03-12 17:49' TO '2023-03-12 17:59'
  ORDER BY ValidFrom DESC;

/**Comparison between two points in time for subset of rows,with determine whether the ros is up-to-date**/

DECLARE @ADayAgo datetime2
SET @ADayAgo = DATEADD(hour, -1, sysutcdatetime())

SELECT  
   D.[SalesOrderDetailID]
  ,D_1_Ago.[OrderQty] AS [OrderQty_history]
  ,D.[OrderQty] AS [OrderQty_Now]
  ,D_1_Ago.[ValidFrom] AS [ValidFrom_history]
  ,D.[ValidFrom] AS [ValidFrom_Now]
  ,D_1_Ago.[ValidTo] AS [ValidTo_history]
  ,D.[ValidTo] AS [ValidTo_Now]
  ,IIF (YEAR(D_1_Ago.ValidTo) = 9999, 1, 0) AS IsActual
FROM [Sales].[SalesOrderDetail_SV] FOR SYSTEM_TIME AS OF @ADayAgo AS D_1_Ago
JOIN [Sales].[SalesOrderDetail_SV] AS D ON D_1_Ago.[SalesOrderDetailID] = [D].[SalesOrderDetailID]
AND D_1_Ago.[SalesOrderDetailID] BETWEEN 1 and 20;