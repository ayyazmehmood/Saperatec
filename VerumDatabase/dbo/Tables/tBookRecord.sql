CREATE TABLE [dbo].[tBookRecord] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[FlagOutdated]	bit	DEFAULT(0)	NOT NULL,
	[DateOutdated]	datetime2	NULL,
	[TypeBookRecord]	smallint	DEFAULT(0)	NOT NULL,
	[FlagAccountOpening]	bit	DEFAULT(0)	NOT NULL,
	[idAccountDebit]	uniqueidentifier	NOT NULL,
	[idAccountCredit]	uniqueidentifier	NOT NULL,
	[idCostCenterBookRecord]	uniqueidentifier	NULL,
	[idBookingRun]	uniqueidentifier	NULL,
	[BookingRunCode]	nvarchar(30)	NULL,
	[BookingSequenceNum]	int	NULL,
	[AccountCodeDebit]	int	NOT NULL,
	[AccountCodeCredit]	int	NOT NULL,
	[DATEVBUCode]	smallint	NOT NULL,
	[idPlanElementInstance]	uniqueidentifier	NULL,
	[TitleBookRecord]	nvarchar(255)	NULL,
	[BookingDate]	datetime2	NOT NULL,
	[Amount]		float	NOT NULL,
	[BookingDocument]	nvarchar(50)	NULL,
	[ReferenceIDBookRecord]	nvarchar(15)	NULL,
	[BookRecordComment]	nvarchar(max)	NULL,
);
GO
ALTER TABLE [dbo].[tBookRecord] ADD CONSTRAINT [FK_tBookRecord_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tBookRecord] ADD CONSTRAINT [FK_tBookRecord_idAccountDebit]
FOREIGN Key([idAccountDebit])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tBookRecord] ADD CONSTRAINT [FK_tBookRecord_idAccountCredit]
FOREIGN Key([idAccountCredit])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tBookRecord] ADD CONSTRAINT [FK_tBookRecord_idCostCenterBookRecord]
FOREIGN Key([idCostCenterBookRecord])
REFERENCES [dbo].[tCostCenter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tBookRecord] ADD CONSTRAINT [FK_tBookRecord_idBookingRun]
FOREIGN Key([idBookingRun])
REFERENCES [dbo].[tBookingRun] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tBookRecord] ADD CONSTRAINT [FK_tBookRecord_idPlanElementInstance]
FOREIGN Key([idPlanElementInstance])
REFERENCES [dbo].[tPlanElementInstance] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tBookRecord_idClient] ON [dbo].[tBookRecord]
(
	[idClient] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tBookRecord_idAccountDebit] ON [dbo].[tBookRecord]
(
	[idAccountDebit] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tBookRecord_idAccountCredit] ON [dbo].[tBookRecord]
(
	[idAccountCredit] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tBookRecord_idCostCenterBookRecord] ON [dbo].[tBookRecord]
(
	[idCostCenterBookRecord] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tBookRecord_idBookingRun] ON [dbo].[tBookRecord]
(
	[idBookingRun] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tBookRecord_idPlanElementInstance] ON [dbo].[tBookRecord]
(
	[idPlanElementInstance] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tBookRecord_ReferenceIDBookRecord] ON [dbo].[tBookRecord]
(
	[ReferenceIDBookRecord] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tBookRecord] ON [dbo].[tBookRecord] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tBookRecord] SET [dbo].[tBookRecord].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tBookRecord].[Id] END