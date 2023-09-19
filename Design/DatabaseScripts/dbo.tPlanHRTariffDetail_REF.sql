ALTER TABLE [dbo].[tPlanHRTariffDetail] ADD CONSTRAINT [FK_tPlanHRTariffDetail_idTariff]
FOREIGN Key([idTariff])
REFERENCES [dbo].[tPlanHRTariff] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

