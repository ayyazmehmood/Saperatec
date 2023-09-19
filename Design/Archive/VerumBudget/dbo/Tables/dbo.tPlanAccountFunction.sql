CREATE TABLE [dbo].[tPlanAccountFunction] (
	[Id]		int	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	int	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idClient]		int	NOT NULL,
	[idPlanFunctionDef]	int	NOT NULL,
	[idAccountPlanAccountFunction]	int	NOT NULL,
CONSTRAINT [PK_dbo.tPlanAccountFunction] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [dbo].[tPlanAccountFunction] ADD CONSTRAINT [FK_tPlanAccountFunction_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanAccountFunction] ADD CONSTRAINT [FK_tPlanAccountFunction_idPlanFunctionDef]
FOREIGN Key([idPlanFunctionDef])
REFERENCES [dbo].[tPlanFunctionDef] ([Id])
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
CREATE NONCLUSTERED INDEX [IX_tPlanAccountFunction_idPlanFunctionDef] ON [dbo].[tPlanAccountFunction]
(
	[idPlanFunctionDef] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanAccountFunction_idAccountPlanAccountFunction] ON [dbo].[tPlanAccountFunction]
(
	[idAccountPlanAccountFunction] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanAccountFunction] ON [dbo].[tPlanAccountFunction] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanAccountFunction] SET [dbo].[tPlanAccountFunction].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanAccountFunction].[Id] END