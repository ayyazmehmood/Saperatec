ALTER TABLE [dbo].[tBookTransaction] ADD CONSTRAINT [FK_tBookTransaction_idBookingRecord]
FOREIGN Key([idBookingRecord])
REFERENCES [dbo].[tBookRecord] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

ALTER TABLE [dbo].[tBookTransaction] ADD CONSTRAINT [FK_tBookTransaction_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tBookTransaction] ADD CONSTRAINT [FK_tBookTransaction_idPlanElement]
FOREIGN Key([idPlanElement])
REFERENCES [dbo].[tPlanElement] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tBookTransaction] ADD CONSTRAINT [FK_tBookTransaction_idAccountReport]
FOREIGN Key([idAccountReport])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tBookTransaction] ADD CONSTRAINT [FK_tBookTransaction_idAccountBooking]
FOREIGN Key([idAccountBooking])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tBookTransaction] ADD CONSTRAINT [FK_tBookTransaction_idCostCenter]
FOREIGN Key([idCostCenter])
REFERENCES [dbo].[tCostCenter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

