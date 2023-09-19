CREATE TABLE [dbo].[tAccountMainGroup] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[idAccountSection]	uniqueidentifier	NOT NULL,
	[TitleLocalMainGroup]	nvarchar(255)	NOT NULL,
	[TitleEnglishMainGroup]	nvarchar(255)	NULL,
	[MainGroupOrder]	int	NOT NULL,
);

GO

CREATE TRIGGER [TR_UPD_tAccountMainGroup] ON [dbo].[tAccountMainGroup] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tAccountMainGroup] SET [dbo].[tAccountMainGroup].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tAccountMainGroup].[Id] END
