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
	[FlagBaseline]	smallint	DEFAULT(0)	NOT NULL,
);

GO

CREATE TRIGGER [TR_UPD_tBookTransaction] ON [dbo].[tBookTransaction] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tBookTransaction] SET [dbo].[tBookTransaction].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tBookTransaction].[Id] END
