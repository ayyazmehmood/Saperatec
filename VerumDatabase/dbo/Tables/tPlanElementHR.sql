CREATE TABLE [dbo].[tPlanElementHR] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idPlanInstance]	uniqueidentifier	NOT NULL,
	[idInflationRule]	uniqueidentifier	NULL,
	[idTariff]		uniqueidentifier	NOT NULL,
	[idExpenseGroup]	uniqueidentifier	NOT NULL,
	[StaffName]		nvarchar(50)	NULL,
	[Department]	nvarchar(50)	NULL,
);
GO
ALTER TABLE [dbo].[tPlanElementHR] ADD CONSTRAINT [FK_tPlanElementHR_idPlanInstance]
FOREIGN Key([idPlanInstance])
REFERENCES [dbo].[tPlanElementInstance] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanElementHR] ADD CONSTRAINT [FK_tPlanElementHR_idInflationRule]
FOREIGN Key([idInflationRule])
REFERENCES [dbo].[tPlanInflationRule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementHR] ADD CONSTRAINT [FK_tPlanElementHR_idTariff]
FOREIGN Key([idTariff])
REFERENCES [dbo].[tPlanHRTariff] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementHR] ADD CONSTRAINT [FK_tPlanElementHR_idExpenseGroup]
FOREIGN Key([idExpenseGroup])
REFERENCES [dbo].[tPlanHRExpenseGroup] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementHR_idPlanInstance] ON [dbo].[tPlanElementHR]
(
	[idPlanInstance] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementHR_idInflationRule] ON [dbo].[tPlanElementHR]
(
	[idInflationRule] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementHR_idTariff] ON [dbo].[tPlanElementHR]
(
	[idTariff] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementHR_idExpenseGroup] ON [dbo].[tPlanElementHR]
(
	[idExpenseGroup] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanElementHR] ON [dbo].[tPlanElementHR] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanElementHR] SET [dbo].[tPlanElementHR].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanElementHR].[Id] END