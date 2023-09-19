ALTER TABLE [dbo].[tPlanAllocationScheduleItems] ADD CONSTRAINT [FK_tPlanAllocationScheduleItems_idPlanAllocationSchedule]
FOREIGN Key([idPlanAllocationSchedule])
REFERENCES [dbo].[tPlanAllocationSchedule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

