ALTER TABLE [dbo].[tPlanHRExpenseGroup] ADD CONSTRAINT [FK_tPlanHRExpenseGroup_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

