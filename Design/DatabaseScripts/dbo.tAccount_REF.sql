ALTER TABLE [dbo].[tAccount] ADD CONSTRAINT [FK_tAccount_idAccountGroup]
FOREIGN Key([idAccountGroup])
REFERENCES [dbo].[tAccountGroup] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

ALTER TABLE [dbo].[tAccount] ADD CONSTRAINT [FK_tAccount_idAccountReporting]
FOREIGN Key([idAccountReporting])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tAccount] ADD CONSTRAINT [FK_tAccount_idAccountSection]
FOREIGN Key([idAccountSection])
REFERENCES [dbo].[tAccountSection] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

ALTER TABLE [dbo].[tAccount] ADD CONSTRAINT [FK_tAccount_idAccountMainGroup]
FOREIGN Key([idAccountMainGroup])
REFERENCES [dbo].[tAccountMainGroup] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION 

GO

