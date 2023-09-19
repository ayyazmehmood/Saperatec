ALTER TABLE [dbo].[tPlanElementInstance] ADD CONSTRAINT [FK_tPlanElementInstance_idPlanElement]
FOREIGN Key([idPlanElement])
REFERENCES [dbo].[tPlanElement] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementInstance] ADD CONSTRAINT [FK_tPlanElementInstance_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

ALTER TABLE [dbo].[tPlanElementInstance] ADD CONSTRAINT [FK_tPlanElementInstance_idParTriggerDueDate]
FOREIGN Key([idParTriggerDueDate])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

