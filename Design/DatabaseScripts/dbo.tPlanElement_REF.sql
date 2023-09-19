ALTER TABLE [dbo].[tPlanElement] ADD CONSTRAINT [FK_tPlanElement_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

ALTER TABLE [dbo].[tPlanElement] ADD CONSTRAINT [FK_tPlanElement_idCostCenterPlanElement]
FOREIGN Key([idCostCenterPlanElement])
REFERENCES [dbo].[tCostCenter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElement] ADD CONSTRAINT [FK_tPlanElement_idCurrency]
FOREIGN Key([idCurrency])
REFERENCES [dbo].[tCurrency] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tPlanElement] ADD CONSTRAINT [FK_tPlanElement_idPlanGroup]
FOREIGN Key([idPlanGroup])
REFERENCES [dbo].[tPlanGroup] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

