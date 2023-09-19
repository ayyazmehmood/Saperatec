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

CREATE TRIGGER [TR_UPD_tPlanElementBooking] ON [dbo].[tPlanElementBooking] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanElementBooking] SET [dbo].[tPlanElementBooking].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanElementBooking].[Id] END
