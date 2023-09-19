CREATE TABLE [dbo].[tSession] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idUser]		uniqueidentifier	NOT NULL,
	[idClient]		uniqueidentifier	NOT NULL,
);
GO
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
CREATE TRIGGER [TR_UPD_tSession] ON [dbo].[tSession] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tSession] SET [dbo].[tSession].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tSession].[Id] END