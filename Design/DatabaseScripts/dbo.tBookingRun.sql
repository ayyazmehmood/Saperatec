CREATE TABLE [dbo].[tBookingRun] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[BookingRunCode]	nvarchar(30)	NOT NULL,
	[PeriodYear]	int	NOT NULL,
	[PeriodMonth]	smallint	NOT NULL,
	[SerialNum]		nvarchar(10)	NOT NULL,
	[VersionCode]	smallint	DEFAULT(0)	NOT NULL,
	[StatusPreliminary]	bit	DEFAULT(0)	NOT NULL,
	[BookingRunTitle]	nvarchar(100)	NULL,
	[ImportFileName]	nvarchar(255)	NOT NULL,
	[ImportFileDate]	datetime2	NOT NULL,
	[ImportedDate]	datetime2	NOT NULL,
	[RecordsImported]	int	NOT NULL,
	[RecordsOmitted]	int	NOT NULL,
);

GO

CREATE TRIGGER [TR_UPD_tBookingRun] ON [dbo].[tBookingRun] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tBookingRun] SET [dbo].[tBookingRun].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tBookingRun].[Id] END
