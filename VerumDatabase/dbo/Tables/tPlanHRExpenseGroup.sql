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
ALTER TABLE [dbo].[tPlanHRExpenseGroup] ADD CONSTRAINT [FK_tPlanHRExpenseGroup_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tPlanHRExpenseGroup_ExpenseGroupIndex] ON [dbo].[tPlanHRExpenseGroup]
(
	[idPlan] ASC,
	[TitleExpenseGroup] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanHRExpenseGroup] ON [dbo].[tPlanHRExpenseGroup] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanHRExpenseGroup] SET [dbo].[tPlanHRExpenseGroup].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanHRExpenseGroup].[Id] END