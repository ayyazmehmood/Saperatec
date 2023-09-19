CREATE TABLE [dbo].[tReferenceCode] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[idReferenceGroup]	uniqueidentifier	NOT NULL,
	[RefCode]		nvarchar(12)	NOT NULL,
	[TitleRefCode]	nvarchar(50)	NULL,
	[RefCodeComment]	nvarchar(max)	NULL,
	[FlagActive]	bit	DEFAULT(1)	NOT NULL,
	[TitleRefCodeEnglish]	nvarchar(50)	NULL,
);

GO

CREATE TRIGGER [TR_UPD_tReferenceCode] ON [dbo].[tReferenceCode] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tReferenceCode] SET [dbo].[tReferenceCode].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tReferenceCode].[Id] END
