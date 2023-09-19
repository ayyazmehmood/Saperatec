CREATE TABLE [dbo].[tPlanAllocationSchedule] (
	[Id]		int	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	int	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idPlan]		int	NOT NULL,
	[TitleAllocationSchedule]	nvarchar(30)	NOT NULL,
	[MonthsBetweenItems]	int	NOT NULL,
	[PerpetualRate]	float	NOT NULL,
CONSTRAINT [PK_dbo.tPlanAllocationSchedule] PRIMARY KEY NONCLUSTERED ([Id] ASC)
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