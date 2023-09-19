ALTER TABLE [dbo].[tUser] ADD CONSTRAINT [FK_tUser_idClientDefault]
FOREIGN Key([idClientDefault])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

