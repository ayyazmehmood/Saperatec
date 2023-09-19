CREATE TABLE [dbo].[tBookingRun] (
	[Id]		bigint	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	bigint	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idClient]		bigint	NOT NULL,
	[Code]			nvarchar(20)	NOT NULL,
	[PeriodYear]	int	NOT NULL,
	[PeriodMonth]	smallint	NOT NULL,
	[SerialNum]		int	NOT NULL,
	[Title]			nvarchar(50)	NOT NULL,
CONSTRAINT [PK_dbo.tBookingRun] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [dbo].[tBookingRun] ADD CONSTRAINT [FK_tBookingRun_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
CREATE NONCLUSTERED INDEX [IX_tBookingRun_idClient] ON [dbo].[tBookingRun]
(
	[idClient] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tBookingRun] ON [dbo].[tBookingRun] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tBookingRun] SET [dbo].[tBookingRun].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tBookingRun].[Id] END