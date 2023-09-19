CREATE TABLE [dbo].[tAccountGroup] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[idAccountMainGroup]	uniqueidentifier	NULL,
	[TitleLocalAccountGroup]	nvarchar(255)	NOT NULL,
	[TitleEnglishAccountGroup]	nvarchar(255)	NULL,
	[AccountGroupOrder]	int	DEFAULT(0)	NOT NULL,
	[AccountCodeFrom]	int	DEFAULT(0)	NOT NULL,
	[AccountCodeTo]	int	DEFAULT(0)	NOT NULL,
	[idAccountReportingDefault]	uniqueidentifier	NULL,
	[TypeAccountDefault]	smallint	DEFAULT(0)	NOT NULL,
);

GO

CREATE TRIGGER [TR_UPD_tAccountGroup] ON [dbo].[tAccountGroup] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tAccountGroup] SET [dbo].[tAccountGroup].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tAccountGroup].[Id] END
