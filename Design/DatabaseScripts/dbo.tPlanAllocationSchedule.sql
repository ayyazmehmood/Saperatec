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

CREATE TRIGGER [TR_UPD_tPlanAllocationSchedule] ON [dbo].[tPlanAllocationSchedule] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanAllocationSchedule] SET [dbo].[tPlanAllocationSchedule].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanAllocationSchedule].[Id] END
