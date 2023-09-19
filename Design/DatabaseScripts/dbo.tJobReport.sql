CREATE TABLE [dbo].[tJobReport] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[idUser]		uniqueidentifier	NULL,
	[TypeJob]		smallint	NOT NULL,
	[DateJobStart]	datetime2	NOT NULL,
	[DateJobEnd]	datetime2	NULL,
	[TypeJobSuccess]	smallint	NOT NULL,
);

GO

CREATE TRIGGER [TR_UPD_tJobReport] ON [dbo].[tJobReport] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tJobReport] SET [dbo].[tJobReport].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tJobReport].[Id] END
