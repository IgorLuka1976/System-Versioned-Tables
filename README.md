# System-Versioned Tables
Work with System Versioned Tables
These scripts  allow you to Create system-versioned temporal table with Identity Column, Select, Insert and Update data, as well as create procedures for deleting rows with the parameter @IdIdentity, deleting rows in the history table for the last @n days with parameter @n 

1. Create and Insert data into System-Versioned table. Use scripts: CreateSystemVersionedtables.sql, InsertDataIntoSystemVersionedTable.sql
2. Update same column, example column OrderQty, using Identity column. Create Procedure Sales.UpdateOrderQty_In_SalesOrderDetail_SV
    For Update data in column OrderQty need to EXECUTE Sales.UpdateOrderQty_In_SalesOrderDetail_SV @IdIdentity,@OrderQty
3. Some helpful select in SelectDataIntoSystemVersionedTable.sql
    
