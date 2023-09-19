CREATE TABLE [dbo].[tBookRecord] (
	[Id]		int	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	int	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idClient]		int	NOT NULL,
	[FlagOutdated]	bit	DEFAULT(0)	NOT NULL,
	[DateOutdated]	datetime	NOT NULL,
	[TypeBookRecord]	smallint	DEFAULT(0)	NOT NULL,
	[idAccountDebit]	int	NOT NULL,
	[idAccountCredit]	int	NOT NULL,
	[idCostCenterBookRecord]	int	NOT NULL,
	[idBookingRun]	int	NOT NULL,
	[BookingSequenceNum]	int	NOT NULL,
	[idPlanElementInstance]	int	NOT NULL,
	[TitleBookRecord]	nvarchar(255)	NOT NULL,
	[BookingDate]	datetime	NOT NULL,
	[BusinessYear]	int	NOT NULL,
	[BookingYear]	int	NOT NULL,
	[BookingQuarter]	smallint	NOT NULL,
	[BookingMonth]	smallint	NOT NULL,
	[Amount]		float	NOT NULL,
	[BookingDocument1]	nvarchar(50)	NOT NULL,
	[BookingDocument2]	nvarchar(50)	NOT NULL,
	[ReferenceIDBookRecord]	nvarchar(15)	NOT NULL,
	[BookRecordComment]	nvarchar(max)	NOT NULL,
CONSTRAINT [PK_dbo.tBookRecord] PRIMARY KEY NONCLUSTERED ([Id] ASC)
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