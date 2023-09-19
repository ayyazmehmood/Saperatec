CREATE TABLE [dbo].[tCurrency] (
	[Id]		int	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	int	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[CurrencyCode]	nvarchar(3)	NOT NULL,
	[TitleCurrency]	nvarchar(30)	NOT NULL,
CONSTRAINT [PK_dbo.tCurrency] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
CREATE TRIGGER [TR_UPD_tCurrency] ON [dbo].[tCurrency] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tCurrency] SET [dbo].[tCurrency].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tCurrency].[Id] END