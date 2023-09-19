CREATE TABLE [dbo].[tPlanElementInstance] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idPlanElement]	uniqueidentifier	NOT NULL,
	[idPlan]		uniqueidentifier	NOT NULL,
	[FlagUpdate]	bit	DEFAULT(0)	NOT NULL,
	[FlagBaseline]	bit	DEFAULT(0)	NOT NULL,
	[FlagDateOffset]	bit	DEFAULT(1)	NOT NULL,
	[DueDateYear]	int	DEFAULT(0)	NOT NULL,
	[DueDateMonth]	int	DEFAULT(0)	NOT NULL,
	[DueDateDay]	int	DEFAULT(0)	NOT NULL,
	[UntilDateYear]	int	NULL,
	[UntilDateMonth]	int	NULL,
	[UntilDateDay]	int	NULL,
	[idParTriggerDueDate]	uniqueidentifier	NULL,
	[Assumptions]	nvarchar(max)	NULL,
	[Revisions]		nvarchar(max)	NULL,
);

GO

CREATE TRIGGER [TR_UPD_tPlanElementInstance] ON [dbo].[tPlanElementInstance] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanElementInstance] SET [dbo].[tPlanElementInstance].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanElementInstance].[Id] END
