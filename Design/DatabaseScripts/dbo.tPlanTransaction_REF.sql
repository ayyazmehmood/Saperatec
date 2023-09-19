ALTER TABLE [dbo].[tPlanTransaction] ADD CONSTRAINT [FK_tPlanTransaction_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

ALTER TABLE [dbo].[tPlanTransaction] ADD CONSTRAINT [FK_tPlanTransaction_idBookTransaction]
FOREIGN Key([idBookTransaction])
REFERENCES [dbo].[tBookTransaction] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

