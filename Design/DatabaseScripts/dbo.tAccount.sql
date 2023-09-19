CREATE TABLE [dbo].[tAccount] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[idAccountGroup]	uniqueidentifier	NULL,
	[idAccountReporting]	uniqueidentifier	NULL,
	[AccountCode]	int	NOT NULL,
	[TypeAccount]	smallint	DEFAULT(0)	NOT NULL,
	[TitleLocalAccount]	nvarchar(255)	NOT NULL,
	[TitleEnglishAccount]	nvarchar(255)	NULL,
	[FlagPlan]		bit	DEFAULT(0)	NOT NULL,
	[idAccountSection]	uniqueidentifier	NULL,
	[idAccountMainGroup]	uniqueidentifier	NULL,
);

GO

CREATE TRIGGER [TR_UPD_tAccount] ON [dbo].[tAccount] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tAccount] SET [dbo].[tAccount].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tAccount].[Id] END
