ALTER TABLE [dbo].[tBookRecord] ADD CONSTRAINT [FK_tBookRecord_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tBookRecord] ADD CONSTRAINT [FK_tBookRecord_idAccountDebit]
FOREIGN Key([idAccountDebit])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tBookRecord] ADD CONSTRAINT [FK_tBookRecord_idAccountCredit]
FOREIGN Key([idAccountCredit])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tBookRecord] ADD CONSTRAINT [FK_tBookRecord_idCostCenterBookRecord]
FOREIGN Key([idCostCenterBookRecord])
REFERENCES [dbo].[tCostCenter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tBookRecord] ADD CONSTRAINT [FK_tBookRecord_idBookingRun]
FOREIGN Key([idBookingRun])
REFERENCES [dbo].[tBookingRun] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

ALTER TABLE [dbo].[tBookRecord] ADD CONSTRAINT [FK_tBookRecord_idPlanElementInstance]
FOREIGN Key([idPlanElementInstance])
REFERENCES [dbo].[tPlanElementInstance] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

