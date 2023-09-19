CREATE TABLE [dbo].[tPlanAllocationSchedule] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idPlan]		uniqueidentifier	NOT NULL,
	[TitleAllocationSchedule]	nvarchar(255)	NOT NULL,
	[MonthsBetweenItems]	int	DEFAULT(1)	NOT NULL,
	[PerpetualRate]	float	NOT NULL,
	[FlagScheduleShared]	bit	NOT NULL,
	[FlagAbsoluteRates]	bit	DEFAULT(0)	NOT NULL,
	[AdvanceDelayPeriods]	int	DEFAULT(0)	NOT NULL,
	[FlagAuto]		bit	DEFAULT(0)	NOT NULL,
	[Period1]		smallint	NULL,
	[Rate1]			float	NULL,
	[Period2]		smallint	NULL,
	[Rate2]			float	NULL,
	[Period3]		smallint	NULL,
	[Rate3]			float	NULL,
);
GO
ALTER TABLE [dbo].[tPlanAllocationSchedule] ADD CONSTRAINT [FK_tPlanAllocationSchedule_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
CREATE NONCLUSTERED INDEX [IX_tPlanAllocationSchedule_idPlan] ON [dbo].[tPlanAllocationSchedule]
(
	[idPlan] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanAllocationSchedule] ON [dbo].[tPlanAllocationSchedule] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanAllocationSchedule] SET [dbo].[tPlanAllocationSchedule].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanAllocationSchedule].[Id] END