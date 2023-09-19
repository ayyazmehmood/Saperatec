CREATE TABLE [dbo].[tPlanElementContract] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idPlanInstance]	uniqueidentifier	NOT NULL,
	[idAccountMain]	uniqueidentifier	NOT NULL,
	[idAllocationSchedule]	uniqueidentifier	NULL,
	[TypeRepeat]	smallint	DEFAULT(0)	NOT NULL,
	[idAccountAdvance]	uniqueidentifier	NULL,
	[idParTriggerAdvance]	uniqueidentifier	NULL,
	[AdvanceDelay]	int	DEFAULT(0)	NOT NULL,
	[idDepreciationRule]	uniqueidentifier	NULL,
	[idDepreciationTrigger]	uniqueidentifier	NULL,
	[DepreciationStartDay]	int	NULL,
	[DepreciationStartMonth]	int	NULL,
	[DepreciationStartYear]	int	NULL,
	[DepreciationDelay]	int	DEFAULT(0)	NOT NULL,
	[idVATRule]		uniqueidentifier	NULL,
	[idInflationRule]	uniqueidentifier	NULL,
	[idParPrice1]	uniqueidentifier	NULL,
	[idParPrice2]	uniqueidentifier	NULL,
	[PaymentTerm]	int	NOT NULL,
	[NumberOfUnits]	int	DEFAULT(1)	NOT NULL,
	[Price]			float	NOT NULL,
	[PriceDate]		datetime2	NULL,
	[BudgetFixed]	float	NOT NULL,
	[idParContingencyRate]	uniqueidentifier	NULL,
);
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idPlanInstance]
FOREIGN Key([idPlanInstance])
REFERENCES [dbo].[tPlanElementInstance] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idAccountMain]
FOREIGN Key([idAccountMain])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idAllocationSchedule]
FOREIGN Key([idAllocationSchedule])
REFERENCES [dbo].[tPlanAllocationSchedule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idAccountAdvance]
FOREIGN Key([idAccountAdvance])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idParTriggerAdvance]
FOREIGN Key([idParTriggerAdvance])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idDepreciationRule]
FOREIGN Key([idDepreciationRule])
REFERENCES [dbo].[tDepreciationRule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idDepreciationTrigger]
FOREIGN Key([idDepreciationTrigger])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idVATRule]
FOREIGN Key([idVATRule])
REFERENCES [dbo].[tVATRule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idInflationRule]
FOREIGN Key([idInflationRule])
REFERENCES [dbo].[tPlanInflationRule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idParPrice1]
FOREIGN Key([idParPrice1])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idParPrice2]
FOREIGN Key([idParPrice2])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD CONSTRAINT [FK_tPlanElementContract_idParContingencyRate]
FOREIGN Key([idParContingencyRate])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idPlanInstance] ON [dbo].[tPlanElementContract]
(
	[idPlanInstance] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idAccountMain] ON [dbo].[tPlanElementContract]
(
	[idAccountMain] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idAllocationSchedule] ON [dbo].[tPlanElementContract]
(
	[idAllocationSchedule] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idAccountAdvance] ON [dbo].[tPlanElementContract]
(
	[idAccountAdvance] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idParTriggerAdvance] ON [dbo].[tPlanElementContract]
(
	[idParTriggerAdvance] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idDepreciationRule] ON [dbo].[tPlanElementContract]
(
	[idDepreciationRule] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idDepreciationTrigger] ON [dbo].[tPlanElementContract]
(
	[idDepreciationTrigger] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idVATRule] ON [dbo].[tPlanElementContract]
(
	[idVATRule] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idInflationRule] ON [dbo].[tPlanElementContract]
(
	[idInflationRule] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idParPrice1] ON [dbo].[tPlanElementContract]
(
	[idParPrice1] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idParPrice2] ON [dbo].[tPlanElementContract]
(
	[idParPrice2] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idParContingencyRate] ON [dbo].[tPlanElementContract]
(
	[idParContingencyRate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanElementContract] ON [dbo].[tPlanElementContract] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanElementContract] SET [dbo].[tPlanElementContract].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanElementContract].[Id] END