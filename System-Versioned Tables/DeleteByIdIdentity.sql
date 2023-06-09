USE [AdventureWorks2019]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----This script create procedure, which delete row by IdIdentity both in current and history tables

ALTER PROCEDURE [Sales].[DeleteByIdIdentityFromTSV] @IdIdentity INT
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @disableVersioningScript nvarchar(max) = 'ALTER TABLE Sales.SalesOrderDetail_SV SET (SYSTEM_VERSIONING = OFF)'
DECLARE @deleteCurrentDataScript nvarchar(max) = 'DELETE FROM Sales.SalesOrderDetail_SV WHERE SalesOrderDetailID='+CONVERT(VARCHAR,@IdIdentity)
DECLARE @deleteHistoryDataScript nvarchar(max) = 'DELETE FROM Sales.SalesOrderDetail_SVHistory WHERE SalesOrderDetailID='+CONVERT(VARCHAR,@IdIdentity)
DECLARE @enableVersioningScript nvarchar(max) = 'ALTER TABLE Sales.SalesOrderDetail_SV SET
                                                 (
                                                 SYSTEM_VERSIONING = ON (HISTORY_TABLE = [Sales].[SalesOrderDetail_SVHistory])
                                                 )'


BEGIN TRY
BEGIN TRANSACTION

    EXEC (@disableVersioningScript)
	EXEC (@deleteCurrentDataScript)
    EXEC (@deleteHistoryDataScript)
    EXEC (@enableVersioningScript)

COMMIT TRANSACTION
END TRY

  BEGIN CATCH
     IF XACT_STATE() <> 0 ROLLBACK TRANSACTION
	 PRINT 'Unable to delete record'
	 ;THROW
	 RETURN -1
  END CATCH
  RETURN 0

  END


												 