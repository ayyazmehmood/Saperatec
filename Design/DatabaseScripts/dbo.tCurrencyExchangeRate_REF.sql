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

