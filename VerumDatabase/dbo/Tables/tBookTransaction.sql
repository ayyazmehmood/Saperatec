CREATE TABLE [dbo].[tBookTransaction] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idBookingRecord]	uniqueidentifier	NOT NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[idPlan]		uniqueidentifier	NULL,
	[idPlanElement]	uniqueidentifier	NULL,
	[idAccountReport]	uniqueidentifier	NOT NULL,
	[idAccountBooking]	uniqueidentifier	NOT NULL,
	[idCostCenter]	uniqueidentifier	NULL,
	[AccountCodeReport]	int	NULL,
	[CostCenterCode]	nvarchar(12)	NULL,
	[TypeBookRecord]	smallint	NULL,
	[FlagAccountOpening]	bit	DEFAULT(0)	NOT NULL,
	[BookingDate]	datetime2	NULL,
	[MonthIndex]	int	NOT NULL,
	[AmountDebit]	float	NOT NULL,
	[AmountCredit]	float	NOT NULL,
	[ReviewComment]	nvarchar(max)	NULL,
	[FlagForecast]	smallint	DEFAULT(0)	NOT NULL,
	[ReferenceIDBookTransaction]	nvarchar(15)	NULL,
);
GO
ALTER TABLE [dbo].[tBookTransaction] ADD CONSTRAINT [FK_tBookTransaction_idBookingRecord]
FOREIGN Key([idBookingRecord])
REFERENCES [dbo].[tBookRecord] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tBookTransaction] ADD CONSTRAINT [FK_tBookTransaction_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tBookTransaction] ADD CONSTRAINT [FK_tBookTransaction_idPlanElement]
FOREIGN Key([idPlanElement])
REFERENCES [dbo].[tPlanElement] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tBookTransaction] ADD CONSTRAINT [FK_tBookTransaction_idAccountReport]
FOREIGN Key([idAccountReport])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tBookTransaction] ADD CONSTRAINT [FK_tBookTransaction_idAccountBooking]
FOREIGN Key([idAccountBooking])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tBookTransaction] ADD CONSTRAINT [FK_tBookTransaction_idCostCenter]
FOREIGN Key([idCostCenter])
REFERENCES [dbo].[tCostCenter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idBookingRecord] ON [dbo].[tBookTransaction]
(
	[idBookingRecord] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idClient] ON [dbo].[tBookTransaction]
(
	[idClient] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idPlan] ON [dbo].[tBookTransaction]
(
	[idPlan] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idPlanElement] ON [dbo].[tBookTransaction]
(
	[idPlanElement] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idAccountReport] ON [dbo].[tBookTransaction]
(
	[idAccountReport] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idAccountBooking] ON [dbo].[tBookTransaction]
(
	[idAccountBooking] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idCostCenter] ON [dbo].[tBookTransaction]
(
	[idCostCenter] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tBookTransaction] ON [dbo].[tBookTransaction] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tBookTransaction] SET [dbo].[tBookTransaction].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tBookTransaction].[Id] END