ALTER TABLE [dbo].[tPlanParameter] ADD CONSTRAINT [FK_tPlanParameter_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

