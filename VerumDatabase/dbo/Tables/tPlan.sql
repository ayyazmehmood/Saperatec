CREATE TABLE [dbo].[tPlan] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[idPlanBase]	uniqueidentifier	NULL,
	[TitlePlan]		nvarchar(30)	NOT NULL,
	[DateValidFrom]	datetime2	NOT NULL,
	[DateValidTo]	datetime2	NOT NULL,
	[ApprovedTo]	datetime2	NULL,
	[PlanFlagBaseline]	bit	DEFAULT(0)	NOT NULL,
	[TypeStatus]	smallint	DEFAULT(3)	NOT NULL,
);
GO
ALTER TABLE [dbo].[tPlan] ADD CONSTRAINT [FK_tPlan_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlan] ADD CONSTRAINT [FK_tPlan_idPlanBase]
FOREIGN Key([idPlanBase])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tPlan_idClient] ON [dbo].[tPlan]
(
	[idClient] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlan_idPlanBase] ON [dbo].[tPlan]
(
	[idPlanBase] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlan] ON [dbo].[tPlan] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlan] SET [dbo].[tPlan].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlan].[Id] END