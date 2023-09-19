ALTER TABLE [dbo].[tClient] ADD CONSTRAINT [FK_tClient_idCurrencyClient]
FOREIGN Key([idCurrencyClient])
REFERENCES [dbo].[tCurrency] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tClient] ADD CONSTRAINT [FK_tClient_idReferenceGroupDefault]
FOREIGN Key([idReferenceGroupDefault])
REFERENCES [dbo].[tReferenceGroup] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

