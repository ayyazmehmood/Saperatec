CREATE TABLE [dbo].[tPlanElement] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[idCostCenterPlanElement]	uniqueidentifier	NULL,
	[idCurrency]	uniqueidentifier	NULL,
	[TypePlanElement]	smallint	DEFAULT(0)	NOT NULL,
	[idPlanGroup]	uniqueidentifier	NULL,
	[TitlePlanElement]	nvarchar(50)	NOT NULL,
	[ReferenceIDPlanElement]	nvarchar(15)	NULL,
	[ElementFlagBaseline]	bit	DEFAULT(0)	NOT NULL,
	[PlanElementDescription]	nvarchar(max)	NULL,
);

GO

CREATE TRIGGER [TR_UPD_tPlanElement] ON [dbo].[tPlanElement] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanElement] SET [dbo].[tPlanElement].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanElement].[Id] END
