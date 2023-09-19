CREATE TABLE [dbo].[tPlanHRExpenseGroup] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idPlan]		uniqueidentifier	NOT NULL,
	[TitleExpenseGroup]	nvarchar(50)	NOT NULL,
	[ExpenseGroupDescription]	nvarchar(max)	NULL,
	[DateInflationBase]	datetime2	NULL,
);

GO

CREATE TRIGGER [TR_UPD_tPlanHRExpenseGroup] ON [dbo].[tPlanHRExpenseGroup] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanHRExpenseGroup] SET [dbo].[tPlanHRExpenseGroup].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanHRExpenseGroup].[Id] END
