ALTER TABLE [dbo].[tPlanHRTariff] ADD CONSTRAINT [FK_tPlanHRTariff_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

ALTER TABLE [dbo].[tPlanHRTariff] ADD CONSTRAINT [FK_tPlanHRTariff_idAccountSalary]
FOREIGN Key([idAccountSalary])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

