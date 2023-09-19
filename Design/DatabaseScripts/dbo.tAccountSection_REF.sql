ALTER TABLE [dbo].[tAccountSection] ADD CONSTRAINT [FK_tAccountSection_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

