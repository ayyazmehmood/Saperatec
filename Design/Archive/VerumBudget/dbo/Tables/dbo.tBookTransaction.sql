CREATE TABLE [dbo].[tBookTransaction] (
	[Id]		int	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	int	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idBookingRecord]	int	NOT NULL,
	[idAccountTransaction]	int	NOT NULL,
	[idAccountCounter]	int	NOT NULL,
	[AmountDebit]	float	NOT NULL,
	[AmountCredit]	float	NOT NULL,
	[AmountTotal]	float	NOT NULL,
CONSTRAINT [PK_dbo.tBookTransaction] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [dbo].[tBookTransaction] ADD CONSTRAINT [FK_tBookTransaction_idBookingRecord]
FOREIGN Key([idBookingRecord])
REFERENCES [dbo].[tBookRecord] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tBookTransaction] ADD CONSTRAINT [FK_tBookTransaction_idAccountTransaction]
FOREIGN Key([idAccountTransaction])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tBookTransaction] ADD CONSTRAINT [FK_tBookTransaction_idAccountCounter]
FOREIGN Key([idAccountCounter])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idBookingRecord] ON [dbo].[tBookTransaction]
(
	[idBookingRecord] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idAccountTransaction] ON [dbo].[tBookTransaction]
(
	[idAccountTransaction] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idAccountCounter] ON [dbo].[tBookTransaction]
(
	[idAccountCounter] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tBookTransaction] ON [dbo].[tBookTransaction] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tBookTransaction] SET [dbo].[tBookTransaction].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tBookTransaction].[Id] END