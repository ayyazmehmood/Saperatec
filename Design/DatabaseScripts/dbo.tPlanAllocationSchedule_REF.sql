ALTER TABLE [dbo].[tPlanAllocationSchedule] ADD CONSTRAINT [FK_tPlanAllocationSchedule_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

