CREATE TABLE [dbo].[tPlanParameter] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idPlan]		uniqueidentifier	NOT NULL,
	[TypePlanParameter]	smallint	DEFAULT(0)	NOT NULL,
	[TitlePlanParameter]	nvarchar(30)	NOT NULL,
	[ValueNum]		float	DEFAULT(0)	NOT NULL,
	[ValueDate]		datetime2	NULL,
	[ValueText]		nvarchar(30)	NULL,
	[UnitParameter]	nvarchar(15)	NULL,
	[PlanParameterComment]	nvarchar(max)	NULL,
);

GO

CREATE TRIGGER [TR_UPD_tPlanParameter] ON [dbo].[tPlanParameter] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanParameter] SET [dbo].[tPlanParameter].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanParameter].[Id] END
