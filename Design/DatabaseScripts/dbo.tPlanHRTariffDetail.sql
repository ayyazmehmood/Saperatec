CREATE TABLE [dbo].[tPlanHRTariffDetail] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idTariff]		uniqueidentifier	NOT NULL,
	[DateValidTo]	datetime2	NULL,
	[WorkTimeWeekly]	smallint	DEFAULT(40)	NOT NULL,
	[FTEFactor]		float	DEFAULT(1)	NOT NULL,
	[RatioShiftNight]	float	DEFAULT(0)	NOT NULL,
	[RatioShiftSpecial]	float	DEFAULT(0)	NOT NULL,
	[RatioOvertime]	float	DEFAULT(0)	NOT NULL,
	[AnnualLeave]	smallint	DEFAULT(0)	NOT NULL,
	[StandardHolidays]	smallint	DEFAULT(0)	NOT NULL,
	[BaseSalaryMonthly]	float	DEFAULT(0)	NOT NULL,
	[RateShiftNight]	float	DEFAULT(0)	NOT NULL,
	[RateShiftSpecial]	float	DEFAULT(0)	NOT NULL,
	[RateOvertime]	float	DEFAULT(1)	NOT NULL,
	[RateAnnualBonus]	float	NULL,
	[AnnualBonusMonth]	smallint	DEFAULT(12)	NOT NULL,
);

GO

CREATE TRIGGER [TR_UPD_tPlanHRTariffDetail] ON [dbo].[tPlanHRTariffDetail] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanHRTariffDetail] SET [dbo].[tPlanHRTariffDetail].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanHRTariffDetail].[Id] END
