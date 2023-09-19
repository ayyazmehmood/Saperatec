ALTER TABLE [dbo].[tReferenceGroup] ADD CONSTRAINT [FK_tReferenceGroup_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

