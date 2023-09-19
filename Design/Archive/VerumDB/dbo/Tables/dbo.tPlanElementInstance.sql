CREATE TABLE [dbo].[tPlanElementInstance] (
	[Id]		bigint	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	bigint	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idPlanElement]	bigint	NOT NULL,
	[idPlan]		bigint	NOT NULL,
	[idPlanItem]	bigint	NOT NULL,
CONSTRAINT [PK_dbo.tPlanElementInstance] PRIMARY KEY NONCLUSTERED ([Id] ASC)
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
CREATE NONCLUSTERED INDEX [IX_tPlanElementInstance_idPlanItem] ON [dbo].[tPlanElementInstance]
(
	[idPlanItem] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanElementInstance] ON [dbo].[tPlanElementInstance] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanElementInstance] SET [dbo].[tPlanElementInstance].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanElementInstance].[Id] END