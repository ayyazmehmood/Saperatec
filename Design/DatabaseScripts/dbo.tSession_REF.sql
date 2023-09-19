ALTER TABLE [dbo].[tSession] ADD CONSTRAINT [FK_tSession_idUser]
FOREIGN Key([idUser])
REFERENCES [dbo].[tUser] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

ALTER TABLE [dbo].[tSession] ADD CONSTRAINT [FK_tSession_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

