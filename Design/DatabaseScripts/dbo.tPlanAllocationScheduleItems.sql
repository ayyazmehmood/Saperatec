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

CREATE TRIGGER [TR_UPD_tPlanAllocationScheduleItems] ON [dbo].[tPlanAllocationScheduleItems] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanAllocationScheduleItems] SET [dbo].[tPlanAllocationScheduleItems].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanAllocationScheduleItems].[Id] END
