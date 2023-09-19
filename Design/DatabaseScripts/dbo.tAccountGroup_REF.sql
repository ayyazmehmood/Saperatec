ALTER TABLE [dbo].[tAccountGroup] ADD CONSTRAINT [FK_tAccountGroup_idAccountMainGroup]
FOREIGN Key([idAccountMainGroup])
REFERENCES [dbo].[tAccountMainGroup] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

