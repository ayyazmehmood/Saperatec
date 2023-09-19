CREATE TABLE [dbo].[tPlanElementInstance] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idPlanElement]	uniqueidentifier	NOT NULL,
	[idPlan]		uniqueidentifier	NOT NULL,
	[FlagUpdate]	bit	DEFAULT(0)	NOT NULL,
	[FlagBaseline]	bit	DEFAULT(0)	NOT NULL,
	[FlagDateOffset]	bit	DEFAULT(1)	NOT NULL,
	[DueDateYear]	int	DEFAULT(0)	NOT NULL,
	[DueDateMonth]	int	DEFAULT(0)	NOT NULL,
	[DueDateDay]	int	DEFAULT(0)	NOT NULL,
	[UntilDateYear]	int	NULL,
	[UntilDateMonth]	int	NULL,
	[UntilDateDay]	int	NULL,
	[idParTriggerDueDate]	uniqueidentifier	NULL,
	[Assumptions]	nvarchar(max)	NULL,
	[Revisions]		nvarchar(max)	NULL,
);
GO
ALTER TABLE [dbo].[tPlanElementInstance] ADD CONSTRAINT [FK_tPlanElementInstance_idPlanElement]
FOREIGN Key([idPlanElement])
REFERENCES [dbo].[tPlanElement] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementInstance] ADD CONSTRAINT [FK_tPlanElementInstance_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanElementInstance] ADD CONSTRAINT [FK_tPlanElementInstance_idParTriggerDueDate]
FOREIGN Key([idParTriggerDueDate])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementInstance_idPlanElement] ON [dbo].[tPlanElementInstance]
(
	[idPlanElement] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementInstance_idPlan] ON [dbo].[tPlanElementInstance]
(
	[idPlan] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementInstance_idParTriggerDueDate] ON [dbo].[tPlanElementInstance]
(
	[idParTriggerDueDate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanElementInstance] ON [dbo].[tPlanElementInstance] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanElementInstance] SET [dbo].[tPlanElementInstance].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanElementInstance].[Id] END