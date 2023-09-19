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

