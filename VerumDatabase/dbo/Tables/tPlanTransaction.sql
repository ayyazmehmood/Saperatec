CREATE TABLE [dbo].[tPlanTransaction] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idPlan]		uniqueidentifier	NOT NULL,
	[idBookTransaction]	uniqueidentifier	NOT NULL,
);
GO
ALTER TABLE [dbo].[tPlanTransaction] ADD CONSTRAINT [FK_tPlanTransaction_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanTransaction] ADD CONSTRAINT [FK_tPlanTransaction_idBookTransaction]
FOREIGN Key([idBookTransaction])
REFERENCES [dbo].[tBookTransaction] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tPlanTransaction_idPlan] ON [dbo].[tPlanTransaction]
(
	[idPlan] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanTransaction_idBookTransaction] ON [dbo].[tPlanTransaction]
(
	[idBookTransaction] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanTransaction] ON [dbo].[tPlanTransaction] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanTransaction] SET [dbo].[tPlanTransaction].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanTransaction].[Id] END