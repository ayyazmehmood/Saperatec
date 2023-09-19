CREATE TABLE [dbo].[tCurrencyExchangeRate] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[idPlan]		uniqueidentifier	NULL,
	[idCurrencyExchangeRate]	uniqueidentifier	NOT NULL,
	[DateExchangeRate]	datetime2	NOT NULL,
	[RatePerClientCurrency]	float	NOT NULL,
);

GO

CREATE TRIGGER [TR_UPD_tCurrencyExchangeRate] ON [dbo].[tCurrencyExchangeRate] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tCurrencyExchangeRate] SET [dbo].[tCurrencyExchangeRate].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tCurrencyExchangeRate].[Id] END
