ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idPlanInstance]
FOREIGN Key([idPlanInstance])
REFERENCES [dbo].[tPlanElementInstance] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idAccountMain]
FOREIGN Key([idAccountMain])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idAllocationSchedule]
FOREIGN Key([idAllocationSchedule])
REFERENCES [dbo].[tPlanAllocationSchedule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idAccountAdvance]
FOREIGN Key([idAccountAdvance])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idParTriggerAdvance]
FOREIGN Key([idParTriggerAdvance])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idDepreciationRule]
FOREIGN Key([idDepreciationRule])
REFERENCES [dbo].[tDepreciationRule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idDepreciationTrigger]
FOREIGN Key([idDepreciationTrigger])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idVATRule]
FOREIGN Key([idVATRule])
REFERENCES [dbo].[tVATRule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idInflationRule]
FOREIGN Key([idInflationRule])
REFERENCES [dbo].[tPlanInflationRule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idParPrice1]
FOREIGN Key([idParPrice1])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idParPrice2]
FOREIGN Key([idParPrice2])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idParContingencyRate]
FOREIGN Key([idParContingencyRate])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

