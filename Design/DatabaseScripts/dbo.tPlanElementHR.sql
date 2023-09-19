CREATE TABLE [dbo].[tPlanElementHR] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idPlanInstance]	uniqueidentifier	NOT NULL,
	[idInflationRule]	uniqueidentifier	NULL,
	[idTariff]		uniqueidentifier	NOT NULL,
	[idExpenseGroup]	uniqueidentifier	NOT NULL,
	[StaffName]		nvarchar(50)	NULL,
	[Department]	nvarchar(50)	NULL,
);

GO

CREATE TRIGGER [TR_UPD_tPlanElementHR] ON [dbo].[tPlanElementHR] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanElementHR] SET [dbo].[tPlanElementHR].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanElementHR].[Id] END
