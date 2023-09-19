DECLARE @myid uniqueidentifier
SET @myid = 'acfe524a-9795-ea11-806f-9cb6d0f9cfb6'

INSERT INTO [dbo].[tCurrency]
           ([CurrencyCode]
           ,[TitleCurrency])
     VALUES
           (Id, uniqueidentifier,@myid
           ,CurrencyCode, nvarchar(3),'EUR'
           ,TitleCurrency, nvarchar(30),'Euro')
GO

DECLARE @myid uniqueidentifier
SET @myid = 'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6'

DECLARE @curid uniqueidentifier
SET @curid = 'acfe524a-9795-ea11-806f-9cb6d0f9cfb6'

INSERT INTO [dbo].[tClient]
           ([Id]
           ,[TitleClient]
           ,[idCurrencyClient]
           ,[FlagTemplate]
           ,[StartOfBusinessYear]
           ,[DATEVClientNumber])
     VALUES
           (Id, uniqueidentifier, @myid
           ,TitleClient, nvarchar(30),'saperatec GmbH'
           ,idCurrencyClient, uniqueidentifier, @curid
           ,FlagTemplate, bit, 0
           ,StartOfBusinessYear, int, 1
           ,DATEVClientNumber, int, 31761)
GO

DECLARE @myid uniqueidentifier
SET @myid = 'efceb7bb-2e98-ea11-8071-9cb6d0f9cfb6'

INSERT INTO [dbo].[tUser]
           ([Id]
           ,[UserName]
           ,[UserLogin]
           ,[UserPasswordHash]
           ,[idClientDefault]
           ,[TypeUser])
     VALUES
           (Id, uniqueidentifier,@myid
           ,UserName, nvarchar(255),'Thorsten Hornung'
           ,UserLogin, nvarchar(30),'thornung'
           ,UserPasswordHash, nvarchar(48),'oKhQaDz/SAKfzuHtlPaqhAf2H1ctcl2+h33WIVZo5AHQlsxq'
           ,idClientDefault, uniqueidentifier,'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6'
           ,TypeUser, smallint,1)
GO

DECLARE @myid uniqueidentifier
SET @myid = '1b951374-3298-ea11-8071-9cb6d0f9cfb6'

INSERT INTO [dbo].[tUser]
           ([Id]
           ,[UserName]
           ,[UserLogin]
           ,[UserPasswordHash]
           ,[idClientDefault]
           ,[TypeUser])
     VALUES
           (Id, uniqueidentifier,@myid
           ,UserName, nvarchar(255),'Test Controller'
           ,UserLogin, nvarchar(30),'test_controller'
           ,UserPasswordHash, nvarchar(48),'taPoSw6iNxeeI94657+fJHBEo73wcKgAual/9Zt7Nf31no9p'
           ,idClientDefault, uniqueidentifier,'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6'
           ,TypeUser, smallint,0)
GO
