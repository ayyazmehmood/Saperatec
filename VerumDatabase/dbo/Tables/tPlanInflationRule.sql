CREATE TABLE [dbo].[tPlanInflationRule] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idPlan]		uniqueidentifier	NOT NULL,
	[TitleInflationRule]	nvarchar(30)	NOT NULL,
	[InflationInterval]	smallint	DEFAULT(12)	NOT NULL,
	[InflationRateAnnual]	float	DEFAULT(0)	NOT NULL,
	[InflationRuleComment]	nvarchar(max)	NULL,
);
GO
ALTER TABLE [dbo].[tPlanInflationRule] ADD CONSTRAINT [FK_tPlanInflationRule_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
CREATE TRIGGER [TR_UPD_tPlanInflationRule] ON [dbo].[tPlanInflationRule] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanInflationRule] SET [dbo].[tPlanInflationRule].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanInflationRule].[Id] END