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

CREATE TRIGGER [TR_UPD_tBookRecord] ON [dbo].[tBookRecord] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tBookRecord] SET [dbo].[tBookRecord].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tBookRecord].[Id] END
