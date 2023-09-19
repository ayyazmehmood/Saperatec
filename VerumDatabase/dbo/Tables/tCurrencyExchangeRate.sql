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
ALTER TABLE [dbo].[tCurrencyExchangeRate] ADD CONSTRAINT [FK_tCurrencyExchangeRate_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tCurrencyExchangeRate] ADD CONSTRAINT [FK_tCurrencyExchangeRate_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tCurrencyExchangeRate] ADD CONSTRAINT [FK_tCurrencyExchangeRate_idCurrencyExchangeRate]
FOREIGN Key([idCurrencyExchangeRate])
REFERENCES [dbo].[tCurrency] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tCurrencyExchangeRate_idClient] ON [dbo].[tCurrencyExchangeRate]
(
	[idClient] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tCurrencyExchangeRate_idPlan] ON [dbo].[tCurrencyExchangeRate]
(
	[idPlan] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tCurrencyExchangeRate_idCurrencyExchangeRate] ON [dbo].[tCurrencyExchangeRate]
(
	[idCurrencyExchangeRate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tCurrencyExchangeRate_RateDate] ON [dbo].[tCurrencyExchangeRate]
(
	[DateExchangeRate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tCurrencyExchangeRate] ON [dbo].[tCurrencyExchangeRate] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tCurrencyExchangeRate] SET [dbo].[tCurrencyExchangeRate].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tCurrencyExchangeRate].[Id] END