CREATE TABLE [dbo].[tPlanElementBooking] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idPlanInstance]	uniqueidentifier	NOT NULL,
	[idAccountDebit]	uniqueidentifier	NOT NULL,
	[idAccountCredit]	uniqueidentifier	NOT NULL,
	[idAllocationSchedule]	uniqueidentifier	NULL,
	[TypeRepeat]	smallint	DEFAULT(0)	NOT NULL,
	[idInflationRule]	uniqueidentifier	NULL,
	[idParPrice1]	uniqueidentifier	NULL,
	[idParPrice2]	uniqueidentifier	NULL,
	[NumberOfUnits]	int	DEFAULT(1)	NOT NULL,
	[Price]			float	NOT NULL,
	[PriceDate]		datetime2	NULL,
	[BudgetFixed]	float	NOT NULL,
	[idParContingencyRate]	uniqueidentifier	NULL,
	[FlagAccountOpening]	bit	DEFAULT(0)	NOT NULL,
);
GO
ALTER TABLE [dbo].[tPlanElementBooking] ADD CONSTRAINT [FK_tPlanElementBooking_idPlanInstance]
FOREIGN Key([idPlanInstance])
REFERENCES [dbo].[tPlanElementInstance] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanElementBooking] ADD CONSTRAINT [FK_tPlanElementBooking_idAccountDebit]
FOREIGN Key([idAccountDebit])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementBooking] ADD CONSTRAINT [FK_tPlanElementBooking_idAccountCredit]
FOREIGN Key([idAccountCredit])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementBooking] ADD CONSTRAINT [FK_tPlanElementBooking_idAllocationSchedule]
FOREIGN Key([idAllocationSchedule])
REFERENCES [dbo].[tPlanAllocationSchedule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementBooking] ADD CONSTRAINT [FK_tPlanElementBooking_idInflationRule]
FOREIGN Key([idInflationRule])
REFERENCES [dbo].[tPlanInflationRule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementBooking] ADD CONSTRAINT [FK_tPlanElementBooking_idParPrice1]
FOREIGN Key([idParPrice1])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementBooking] ADD CONSTRAINT [FK_tPlanElementBooking_idParPrice2]
FOREIGN Key([idParPrice2])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElementBooking] ADD CONSTRAINT [FK_tPlanElementBooking_idParContingencyRate]
FOREIGN Key([idParContingencyRate])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementBooking_idPlanInstance] ON [dbo].[tPlanElementBooking]
(
	[idPlanInstance] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementBooking_idAccountDebit] ON [dbo].[tPlanElementBooking]
(
	[idAccountDebit] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementBooking_idAccountCredit] ON [dbo].[tPlanElementBooking]
(
	[idAccountCredit] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementBooking_idAllocationSchedule] ON [dbo].[tPlanElementBooking]
(
	[idAllocationSchedule] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementBooking_idInflationRule] ON [dbo].[tPlanElementBooking]
(
	[idInflationRule] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementBooking_idParPrice1] ON [dbo].[tPlanElementBooking]
(
	[idParPrice1] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementBooking_idParPrice2] ON [dbo].[tPlanElementBooking]
(
	[idParPrice2] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElementBooking_idParContingencyRate] ON [dbo].[tPlanElementBooking]
(
	[idParContingencyRate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanElementBooking] ON [dbo].[tPlanElementBooking] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanElementBooking] SET [dbo].[tPlanElementBooking].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanElementBooking].[Id] END