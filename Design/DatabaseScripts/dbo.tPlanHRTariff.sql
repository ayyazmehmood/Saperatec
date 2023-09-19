CREATE TABLE [dbo].[tPlanHRTariff] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idPlan]		uniqueidentifier	NOT NULL,
	[TitleTariff]	nvarchar(50)	NOT NULL,
	[idAccountSalary]	uniqueidentifier	NOT NULL,
	[PayDay]		smallint	DEFAULT(28)	NOT NULL,
	[TariffDescription]	nvarchar(max)	NULL,
	[FlagShared]	bit	DEFAULT(1)	NOT NULL,
	[DateInflationBase]	datetime2	NULL,
);

GO

CREATE TRIGGER [TR_UPD_tPlanHRTariff] ON [dbo].[tPlanHRTariff] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanHRTariff] SET [dbo].[tPlanHRTariff].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanHRTariff].[Id] END
