CREATE TABLE [dbo].[tPlanElementContract] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idPlanInstance]	uniqueidentifier	NOT NULL,
	[idAccountMain]	uniqueidentifier	NOT NULL,
	[idAllocationSchedule]	uniqueidentifier	NULL,
	[TypeRepeat]	smallint	DEFAULT(0)	NOT NULL,
	[idAccountAdvance]	uniqueidentifier	NULL,
	[idParTriggerAdvance]	uniqueidentifier	NULL,
	[AdvanceDelay]	int	DEFAULT(0)	NOT NULL,
	[idDepreciationRule]	uniqueidentifier	NULL,
	[idDepreciationTrigger]	uniqueidentifier	NULL,
	[DepreciationStartDay]	int	NULL,
	[DepreciationStartMonth]	int	NULL,
	[DepreciationStartYear]	int	NULL,
	[DepreciationDelay]	int	DEFAULT(0)	NOT NULL,
	[idVATRule]		uniqueidentifier	NULL,
	[idInflationRule]	uniqueidentifier	NULL,
	[idParPrice1]	uniqueidentifier	NULL,
	[idParPrice2]	uniqueidentifier	NULL,
	[PaymentTerm]	int	NOT NULL,
	[NumberOfUnits]	int	DEFAULT(1)	NOT NULL,
	[Price]			float	NOT NULL,
	[PriceDate]		datetime2	NULL,
	[BudgetFixed]	float	NOT NULL,
	[idParContingencyRate]	uniqueidentifier	NULL,
);

GO

CREATE TRIGGER [TR_UPD_tPlanElementContract] ON [dbo].[tPlanElementContract] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanElementContract] SET [dbo].[tPlanElementContract].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanElementContract].[Id] END
