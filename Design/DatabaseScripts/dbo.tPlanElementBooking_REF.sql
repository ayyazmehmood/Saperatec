ALTER TABLE [dbo].[tPlanElementBooking] ADD CONSTRAINT [FK_tPlanElementBooking_idPlanInstance]
FOREIGN Key([idPlanInstance])
REFERENCES [dbo].[tPlanElementInstance] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

ALTER TABLE [dbo].[tPlanElementBooking] ADD CONSTRAINT [FK_tPlanElementBooking_idAccountDebit]
FOREIGN Key([idAccountDebit])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementBooking] ADD CONSTRAINT [FK_tPlanElementBooking_idAccountCredit]
FOREIGN Key([idAccountCredit])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementBooking] ADD CONSTRAINT [FK_tPlanElementBooking_idAllocationSchedule]
FOREIGN Key([idAllocationSchedule])
REFERENCES [dbo].[tPlanAllocationSchedule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementBooking] ADD CONSTRAINT [FK_tPlanElementBooking_idInflationRule]
FOREIGN Key([idInflationRule])
REFERENCES [dbo].[tPlanInflationRule] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementBooking] ADD CONSTRAINT [FK_tPlanElementBooking_idParPrice1]
FOREIGN Key([idParPrice1])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementBooking] ADD CONSTRAINT [FK_tPlanElementBooking_idParPrice2]
FOREIGN Key([idParPrice2])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElementBooking] ADD CONSTRAINT [FK_tPlanElementBooking_idParContingencyRate]
FOREIGN Key([idParContingencyRate])
REFERENCES [dbo].[tPlanParameter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

