ALTER TABLE [dbo].[tReferenceCode] ADD CONSTRAINT [FK_tReferenceCode_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tReferenceCode] ADD CONSTRAINT [FK_tReferenceCode_idReferenceGroup]
FOREIGN Key([idReferenceGroup])
REFERENCES [dbo].[tReferenceGroup] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

