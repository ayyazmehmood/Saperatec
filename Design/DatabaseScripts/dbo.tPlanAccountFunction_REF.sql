ALTER TABLE [dbo].[tPlanAccountFunction] ADD CONSTRAINT [FK_tPlanAccountFunction_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

ALTER TABLE [dbo].[tPlanAccountFunction] ADD CONSTRAINT [FK_tPlanAccountFunction_idAccountPlanAccountFunction]
FOREIGN Key([idAccountPlanAccountFunction])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

