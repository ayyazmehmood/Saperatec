CREATE TABLE [dbo].[tPlanAllocationScheduleItems] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idPlanAllocationSchedule]	uniqueidentifier	NOT NULL,
	[OrderNum]		int	NOT NULL,
	[ItemRate]		float	NOT NULL,
);
GO
ALTER TABLE [dbo].[tPlanAllocationScheduleItems] ADD CONSTRAINT [FK_tPlanAllocationScheduleItems_idPlanAllocationSchedule]
FOREIGN Key([idPlanAllocationSchedule])
REFERENCES [dbo].[tPlanAllocationSchedule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tPlanAllocationScheduleItems_idPlanAllocationSchedule] ON [dbo].[tPlanAllocationScheduleItems]
(
	[idPlanAllocationSchedule] ASC,
	[OrderNum] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanAllocationScheduleItems] ON [dbo].[tPlanAllocationScheduleItems] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanAllocationScheduleItems] SET [dbo].[tPlanAllocationScheduleItems].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanAllocationScheduleItems].[Id] END