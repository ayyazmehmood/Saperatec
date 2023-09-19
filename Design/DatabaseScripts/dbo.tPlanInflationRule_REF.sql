ALTER TABLE [dbo].[tPlanInflationRule] ADD CONSTRAINT [FK_tPlanInflationRule_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

