CREATE TABLE [dbo].[tSession] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idUser]		uniqueidentifier	NOT NULL,
	[idClient]		uniqueidentifier	NOT NULL,
);

GO

CREATE TRIGGER [TR_UPD_tSession] ON [dbo].[tSession] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tSession] SET [dbo].[tSession].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tSession].[Id] END
