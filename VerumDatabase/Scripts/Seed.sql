/*
Vorlage für ein Skript nach der Bereitstellung							
--------------------------------------------------------------------------------------
 Diese Datei enthält SQL-Anweisungen, die an das Buildskript angefügt werden.		
 Schließen Sie mit der SQLCMD-Syntax eine Datei in das Skript nach der Bereitstellung ein.			
 Beispiel:   :r .\myfile.sql								
 Verwenden Sie die SQLCMD-Syntax, um auf eine Variable im Skript nach der Bereitstellung zu verweisen.		
 Beispiel:   :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
/*
DECLARE @curid uniqueidentifier;
SET @curid = 'acfe524a-9795-ea11-806f-9cb6d0f9cfb6';

INSERT INTO [dbo].[tCurrency]
            ([Id]
            ,[CurrencyCode]
            ,[TitleCurrency])
        VALUES
            (@curid, 'EUR', 'Euro');
GO

DECLARE @curid uniqueidentifier;
SET @curid = 'acfe524a-9795-ea11-806f-9cb6d0f9cfb6';

DECLARE @clientid uniqueidentifier;
SET @clientid = 'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6';

INSERT INTO [dbo].[tClient]
           ([Id]
           ,[TitleClient]
           ,[idCurrencyClient]
           ,[FlagTemplate]
           ,[StartOfBusinessYear]
           ,[DATEVClientNumber])
     VALUES
           (@clientid, 'saperatec GmbH',@curid,0,1,31761)
GO

DECLARE @clientid uniqueidentifier;
SET @clientid = 'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6';

DECLARE @userid1 uniqueidentifier
SET @userid1 = 'efceb7bb-2e98-ea11-8071-9cb6d0f9cfb6'

DECLARE @userid2 uniqueidentifier
SET @userid2 = '1b951374-3298-ea11-8071-9cb6d0f9cfb6'

INSERT INTO [dbo].[tUser]
           ([Id]
           ,[UserName]
           ,[UserLogin]
           ,[UserPasswordHash]
           ,[idClientDefault]
           ,[TypeUser])
     VALUES
           (@userid1,'Thorsten Hornung','thornung','oKhQaDz/SAKfzuHtlPaqhAf2H1ctcl2+h33WIVZo5AHQlsxq',@clientid,1),
           (@userid2,'Test Controller','test_controller','taPoSw6iNxeeI94657+fJHBEo73wcKgAual/9Zt7Nf31no9p',@clientid,0)
GO

*/