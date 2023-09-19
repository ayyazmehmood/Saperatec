CREATE TABLE [dbo].[tPlanHRExpense] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idExpenseGroup]	uniqueidentifier	NOT NULL,
	[DateValidTo]	datetime2	NULL,
	[TitleExpense]	nvarchar(50)	NOT NULL,
	[idAccountExpense]	uniqueidentifier	NOT NULL,
	[idCostCenterFixed]	uniqueidentifier	NULL,
	[RatioToSalary]	float	DEFAULT(0)	NOT NULL,
	[ExpenseAmount]	float	DEFAULT(0)	NOT NULL,
	[SalaryCap]		float	DEFAULT(0)	NOT NULL,
	[DeductFromSalary]	float	DEFAULT(0)	NOT NULL,
	[ApplyToBonusMode]	smallint	DEFAULT(0)	NOT NULL,
	[Assumptions]	nvarchar(max)	NULL,
);

GO

CREATE TRIGGER [TR_UPD_tPlanHRExpense] ON [dbo].[tPlanHRExpense] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanHRExpense] SET [dbo].[tPlanHRExpense].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanHRExpense].[Id] END
