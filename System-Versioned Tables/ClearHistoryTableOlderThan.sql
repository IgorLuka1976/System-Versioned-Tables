USE [AdventureWorks2019]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-----This script create procedure, which delete rows in history table older than @days

CREATE PROCEDURE [Sales].[ClearHistoryTableOlderThan] @days INT
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @disableVersioningScript nvarchar(max) = 'ALTER TABLE Sales.SalesOrderDetail_SV SET (SYSTEM_VERSIONING = OFF)'
DECLARE @deleteHistoryDataScript nvarchar(max) = 'DELETE FROM Sales.SalesOrderDetail_SVHistory WHERE DATEDIFF(DD,ValidTo,GETDATE())>'+CONVERT(VARCHAR,@days)
DECLARE @enableVersioningScript nvarchar(max) = 'ALTER TABLE Sales.SalesOrderDetail_SV SET
                                                 (
                                                 SYSTEM_VERSIONING = ON (HISTORY_TABLE = [Sales].[SalesOrderDetail_SVHistory])
                                                 )'


BEGIN TRY
BEGIN TRANSACTION

    EXEC (@disableVersioningScript)
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

												 
GO


