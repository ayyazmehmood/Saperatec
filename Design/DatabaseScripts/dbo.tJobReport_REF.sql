ALTER TABLE [dbo].[tJobReport] ADD CONSTRAINT [FK_tJobReport_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

ALTER TABLE [dbo].[tJobReport] ADD CONSTRAINT [FK_tJobReport_idUser]
FOREIGN Key([idUser])
REFERENCES [dbo].[tUser] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

