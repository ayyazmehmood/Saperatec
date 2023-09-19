ALTER TABLE [dbo].[tAccountMainGroup] ADD CONSTRAINT [FK_tAccountMainGroup_idAccountSection]
FOREIGN Key([idAccountSection])
REFERENCES [dbo].[tAccountSection] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

