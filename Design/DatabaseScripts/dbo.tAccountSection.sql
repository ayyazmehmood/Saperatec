CREATE TABLE [dbo].[tAccountSection] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[TitleLocalSection]	nvarchar(255)	NOT NULL,
	[TitleEnglishSection]	nvarchar(255)	NULL,
	[TypeAccount]	smallint	DEFAULT(0)	NOT NULL,
	[SectionOrder]	int	NOT NULL,
);

GO

CREATE TRIGGER [TR_UPD_tAccountSection] ON [dbo].[tAccountSection] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tAccountSection] SET [dbo].[tAccountSection].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tAccountSection].[Id] END
