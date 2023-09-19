CREATE TABLE [dbo].[tPlan] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[idPlanBase]	uniqueidentifier	NULL,
	[TitlePlan]		nvarchar(30)	NOT NULL,
	[DateValidFrom]	datetime2	NOT NULL,
	[DateValidTo]	datetime2	NOT NULL,
	[ApprovedTo]	datetime2	NULL,
	[PlanFlagBaseline]	bit	DEFAULT(0)	NOT NULL,
	[TypeStatus]	smallint	DEFAULT(3)	NOT NULL,
);

GO

CREATE TRIGGER [TR_UPD_tPlan] ON [dbo].[tPlan] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlan] SET [dbo].[tPlan].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlan].[Id] END
