USE AdventureWorks2019
GO

/***Update Column OrderQty From History Table****/

CREATE PROCEDURE [Sales].[UpdateOrderQty_From_HistoryTable] @IdIdentity INT, @dateHistory DATETIME2(7)
AS
BEGIN
SET NOCOUNT ON
SET XACT_ABORT ON


BEGIN TRY
BEGIN TRANSACTION

UPDATE [Sales].[SalesOrderDetail_SV]
SET OrderQty = History.OrderQty
FROM [Sales].[SalesOrderDetail_SV] 
FOR SYSTEM_TIME AS OF @dateHistory AS History
WHERE History.[SalesOrderDetailID] = @IdIdentity
AND [Sales].[SalesOrderDetail_SV].[SalesOrderDetailID] = @IdIdentity 

COMMIT TRANSACTION
END TRY

  BEGIN CATCH
     IF XACT_STATE() <> 0 ROLLBACK TRANSACTION
	 PRINT 'Unable to insert record'
	 ;THROW
	 RETURN -1
  END CATCH
  RETURN 0

  END
GO
