CREATE TABLE [dbo].[tPlanAccountFunction] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[TypeAccountFunction]	int	NOT NULL,
	[idAccountPlanAccountFunction]	uniqueidentifier	NOT NULL,
);
GO
ALTER TABLE [dbo].[tPlanAccountFunction] ADD CONSTRAINT [FK_tPlanAccountFunction_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanAccountFunction] ADD CONSTRAINT [FK_tPlanAccountFunction_idAccountPlanAccountFunction]
FOREIGN Key([idAccountPlanAccountFunction])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tPlanAccountFunction_idClient] ON [dbo].[tPlanAccountFunction]
(
	[idClient] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanAccountFunction_TypeAccountFunction] ON [dbo].[tPlanAccountFunction]
(
	[TypeAccountFunction] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanAccountFunction_idAccountPlanAccountFunction] ON [dbo].[tPlanAccountFunction]
(
	[idAccountPlanAccountFunction] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanAccountFunction] ON [dbo].[tPlanAccountFunction] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanAccountFunction] SET [dbo].[tPlanAccountFunction].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanAccountFunction].[Id] END