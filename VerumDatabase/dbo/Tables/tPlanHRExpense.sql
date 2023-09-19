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
ALTER TABLE [dbo].[tPlanHRExpense] ADD CONSTRAINT [FK_tPlanHRExpense_idExpenseGroup]
FOREIGN Key([idExpenseGroup])
REFERENCES [dbo].[tPlanHRExpenseGroup] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanHRExpense] ADD CONSTRAINT [FK_tPlanHRExpense_idAccountExpense]
FOREIGN Key([idAccountExpense])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanHRExpense] ADD CONSTRAINT [FK_tPlanHRExpense_idCostCenterFixed]
FOREIGN Key([idCostCenterFixed])
REFERENCES [dbo].[tCostCenter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tPlanHRExpense_idAccountExpense] ON [dbo].[tPlanHRExpense]
(
	[idAccountExpense] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanHRExpense] ON [dbo].[tPlanHRExpense] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanHRExpense] SET [dbo].[tPlanHRExpense].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanHRExpense].[Id] END