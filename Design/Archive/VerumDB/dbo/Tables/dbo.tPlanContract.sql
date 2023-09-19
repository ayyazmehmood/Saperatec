CREATE TABLE [dbo].[tPlanContract] (
	[Id]		bigint	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	bigint	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idPlanInstance]	bigint	NOT NULL,
	[idAccountMain]	bigint	NOT NULL,
	[idAllocationSchedule]	bigint	NULL,
	[TypeRepeat]	smallint	DEFAULT(0)	NOT NULL,
	[idAccountAdvanceAccrual]	bigint	NULL,
	[AdvanceDelay]	int	DEFAULT(0)	NOT NULL,
	[idAccrualSchedule]	bigint	NULL,
	[idDepreciationRule]	bigint	NULL,
	[idDepreciationTrigger]	bigint	NULL,
	[DepreciationDelay]	int	DEFAULT(0)	NOT NULL,
	[idVATRule]		bigint	NULL,
	[idParInflation]	bigint	NULL,
	[idParPrice1]	bigint	NULL,
	[idParPrice2]	bigint	NULL,
	[idCurrency]	bigint	NOT NULL,
	[idParTriggerDate]	bigint	NULL,
	[FlagBaseline]	bit	DEFAULT(0)	NOT NULL,
	[FlagDateOffset]	bit	DEFAULT(0)	NOT NULL,
	[DueDateYear]	int	DEFAULT(0)	NOT NULL,
	[DueDateMonth]	int	DEFAULT(0)	NOT NULL,
	[DueDateDay]	int	DEFAULT(0)	NOT NULL,
	[UntilDateYear]	int	DEFAULT(0)	NOT NULL,
	[UntilDateMonth]	int	DEFAULT(0)	NOT NULL,
	[UntilDateDay]	int	DEFAULT(0)	NULL,
	[PaymentTerm]	int	NOT NULL,
	[NumberOfUnits]	int	DEFAULT(1)	NOT NULL,
	[Price]			float	NOT NULL,
	[PriceDate]		datetime	NULL,
	[BudgetBase]	float	NOT NULL,
	[ContingencyRate]	float	NOT NULL,
	[BudgetContingency]	float	NOT NULL,
	[Assumptions]	nvarchar(max)	NULL,
	[Revisions]		nvarchar(max)	NULL,
CONSTRAINT [PK_dbo.tPlanContract] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [dbo].[tPlanContract] ADD CONSTRAINT [FK_tPlanContract_idPlanInstance]
FOREIGN Key([idPlanInstance])
REFERENCES [dbo].[tPlanElementInstance] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanContract] ADD CONSTRAINT [FK_tPlanContract_idAccountMain]
FOREIGN Key([idAccountMain])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanContract] ADD CONSTRAINT [FK_tPlanContract_idAllocationSchedule]
FOREIGN Key([idAllocationSchedule])
REFERENCES [dbo].[tPlanAllocationSchedule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanContract] ADD CONSTRAINT [FK_tPlanContract_idAccountAdvanceAccrual]
FOREIGN Key([idAccountAdvanceAccrual])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanContract] ADD CONSTRAINT [FK_tPlanContract_idAccrualSchedule]
FOREIGN Key([idAccrualSchedule])
REFERENCES [dbo].[tPlanAllocationSchedule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanContract] ADD CONSTRAINT [FK_tPlanContract_idDepreciationRule]
FOREIGN Key([idDepreciationRule])
REFERENCES [dbo].[tDepreciationRule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanContract] ADD CONSTRAINT [FK_tPlanContract_idDepreciationTrigger]
FOREIGN Key([idDepreciationTrigger])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanContract] ADD CONSTRAINT [FK_tPlanContract_idVATRule]
FOREIGN Key([idVATRule])
REFERENCES [dbo].[tVATRule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanContract] ADD CONSTRAINT [FK_tPlanContract_idParInflation]
FOREIGN Key([idParInflation])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanContract] ADD CONSTRAINT [FK_tPlanContract_idParPrice1]
FOREIGN Key([idParPrice1])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanContract] ADD CONSTRAINT [FK_tPlanContract_idParPrice2]
FOREIGN Key([idParPrice2])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanContract] ADD CONSTRAINT [FK_tPlanContract_idCurrency]
FOREIGN Key([idCurrency])
REFERENCES [dbo].[tCurrency] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanContract] ADD CONSTRAINT [FK_tPlanContract_idParTriggerDate]
FOREIGN Key([idParTriggerDate])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tPlanContract_idPlanInstance] ON [dbo].[tPlanContract]
(
	[idPlanInstance] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanContract_idAccountMain] ON [dbo].[tPlanContract]
(
	[idAccountMain] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanContract_idAllocationSchedule] ON [dbo].[tPlanContract]
(
	[idAllocationSchedule] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanContract_idAccountAdvanceAccrual] ON [dbo].[tPlanContract]
(
	[idAccountAdvanceAccrual] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanContract_idAccrualSchedule] ON [dbo].[tPlanContract]
(
	[idAccrualSchedule] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanContract_idDepreciationRule] ON [dbo].[tPlanContract]
(
	[idDepreciationRule] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanContract_idDepreciationTrigger] ON [dbo].[tPlanContract]
(
	[idDepreciationTrigger] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanContract_idVATRule] ON [dbo].[tPlanContract]
(
	[idVATRule] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanContract_idParInflation] ON [dbo].[tPlanContract]
(
	[idParInflation] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanContract_idParPrice1] ON [dbo].[tPlanContract]
(
	[idParPrice1] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanContract_idParPrice2] ON [dbo].[tPlanContract]
(
	[idParPrice2] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanContract_idCurrency] ON [dbo].[tPlanContract]
(
	[idCurrency] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanContract_idParTriggerDate] ON [dbo].[tPlanContract]
(
	[idParTriggerDate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanContract] ON [dbo].[tPlanContract] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanContract] SET [dbo].[tPlanContract].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanContract].[Id] END