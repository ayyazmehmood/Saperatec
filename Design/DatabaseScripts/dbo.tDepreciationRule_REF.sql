ALTER TABLE [dbo].[tDepreciationRule] ADD CONSTRAINT [FK_tDepreciationRule_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

ALTER TABLE [dbo].[tDepreciationRule] ADD CONSTRAINT [FK_tDepreciationRule_idAccountActivation]
FOREIGN Key([idAccountActivation])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tDepreciationRule] ADD CONSTRAINT [FK_tDepreciationRule_idAccountDepreciation]
FOREIGN Key([idAccountDepreciation])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

