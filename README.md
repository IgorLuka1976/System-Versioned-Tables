# System-Versioned Tables
Work with System Versioned Tables
These scripts  allow you to Create system-versioned temporal table with Identity Column, Select, Insert and Update data, as well as create procedures for deleting rows with the parameter @IdIdentity, deleting rows in the history table for the last @n days with parameter @n 

1. Create and Insert data into System-Versioned table. Use scripts: CreateSystemVersionedtables.sql, InsertDataIntoSystemVersionedTable.sql
2. Update same column, example column OrderQty, using Identity column. Create Procedure Sales.UpdateOrderQty_In_SalesOrderDetail_SV
    For Update data in column OrderQty need to: EXECUTE Sales.UpdateOrderQty_In_SalesOrderDetail_SV @IdIdentity,@OrderQty
3. Update data in column OrderQty by IdIdentity from history table. Create Procedure Sales.UpdateOrderQty_From_HistoryTable   
    For Update use: EXECUTE Sales.UpdateOrderQty_From_HistoryTable @IdIdentity,@dateHistory
4. Some helpful select in SelectDataIntoSystemVersionedTable.sql
    
5. For precise removal by IdIdentity (delete in both Current and History tables ), need to create procedure in DeleteByIdIdentity.sql
   and than: EXECUTE [Sales].[DeleteByIdIdentityFromTSV] @IdIdentity  
6. For Daily Clear Job, need to use Procedure: EXECUTE [Sales].[ClearHistoryTableOlderThan] @days, which will create by script: ClearHistoryTableOlderThan.sql
