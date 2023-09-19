CREATE TABLE [dbo].[tReferenceGroup] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[TypeReferenceGroup]	nvarchar(1)	NOT NULL,
	[TitleReferenceGroup]	nvarchar(50)	NOT NULL,
	[BaseCode]		nvarchar(2)	NULL,
	[NextNum]		int	DEFAULT(0)	NOT NULL,
	[FlagAutoGen]	bit	DEFAULT(1)	NOT NULL,
	[AutoDigits]	smallint	DEFAULT(4)	NOT NULL,
);

GO

CREATE TRIGGER [TR_UPD_tReferenceGroup] ON [dbo].[tReferenceGroup] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tReferenceGroup] SET [dbo].[tReferenceGroup].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tReferenceGroup].[Id] END
