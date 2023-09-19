CREATE TABLE [dbo].[tCurrency] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[CurrencyCode]	nvarchar(3)	NOT NULL,
	[TitleCurrency]	nvarchar(30)	NOT NULL,
);
GO
CREATE TRIGGER [TR_UPD_tCurrency] ON [dbo].[tCurrency] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tCurrency] SET [dbo].[tCurrency].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tCurrency].[Id] END