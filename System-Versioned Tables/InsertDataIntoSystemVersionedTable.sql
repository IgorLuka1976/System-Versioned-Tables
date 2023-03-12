---Important
USE [AdventureWorks2019]
GO
/****** Script For Insert Data Into [Sales].[SalesOrderDetail]    Script Date: 12.03.2023 by Igor Luca******/

INSERT INTO [Sales].[SalesOrderDetail_SV]
           ([SalesOrderID]
           ,[CarrierTrackingNumber]
           ,[OrderQty]
           ,[ProductID]
           ,[SpecialOfferID]
           ,[UnitPrice]
           ,[UnitPriceDiscount]
           ,[rowguid]
           ,[ModifiedDate])

SELECT [SalesOrderID]
      ,[CarrierTrackingNumber]
      ,[OrderQty]
      ,[ProductID]
      ,[SpecialOfferID]
      ,[UnitPrice]
      ,[UnitPriceDiscount]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2019].[Sales].[SalesOrderDetail]
GO


