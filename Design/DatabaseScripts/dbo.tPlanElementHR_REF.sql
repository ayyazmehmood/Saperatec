ALTER TABLE [dbo].[tPlanElementHR] ADD CONSTRAINT [FK_tPlanElementHR_idPlanInstance]
FOREIGN Key([idPlanInstance])
REFERENCES [dbo].[tPlanElementInstance] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

ALTER TABLE [dbo].[tPlanElementHR] ADD CONSTRAINT [FK_tPlanElementHR_idInflationRule]
FOREIGN Key([idInflationRule])
REFERENCES [dbo].[tPlanInflationRule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementHR] ADD CONSTRAINT [FK_tPlanElementHR_idTariff]
FOREIGN Key([idTariff])
REFERENCES [dbo].[tPlanHRTariff] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementHR] ADD CONSTRAINT [FK_tPlanElementHR_idExpenseGroup]
FOREIGN Key([idExpenseGroup])
REFERENCES [dbo].[tPlanHRExpenseGroup] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

