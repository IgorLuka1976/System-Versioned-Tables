---Important
USE AdventureWorks2019
GO
/****** Script For Insert Data Into [Sales].[SalesOrderDetail]    Script Date: 12.03.2023 by Igor Luca******/

CREATE PROCEDURE [Sales].[UpdateOrderQty_In_SalesOrderDetail_SV] @IdIdentity INT, @OrderQty SMALLINT
AS
BEGIN
SET NOCOUNT ON
SET XACT_ABORT ON


BEGIN TRY
BEGIN TRANSACTION

UPDATE t
  SET t.OrderQty=@OrderQty
FROM [Sales].[SalesOrderDetail_SV] t
WHERE t.SalesOrderDetailID=@IdIdentity
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