CREATE TABLE [dbo].[tReferenceGroup] (
	[Id]		int	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	int	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idClient]		int	NOT NULL,
	[TypeReferenceGroup]	nvarchar(1)	NOT NULL,
	[TitleReferenceGroup]	nvarchar(50)	NOT NULL,
	[BaseCode]		nvarchar(2)	NOT NULL,
	[NextNum]		int	DEFAULT(0)	NOT NULL,
	[FlagAutoGen]	bit	DEFAULT(1)	NOT NULL,
	[AutoDigits]	smallint	DEFAULT(4)	NOT NULL,
CONSTRAINT [PK_dbo.tReferenceGroup] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [dbo].[tReferenceGroup] ADD CONSTRAINT [FK_tReferenceGroup_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tReferenceGroup_Code] ON [dbo].[tReferenceGroup]
(
	[idClient] ASC,
	[TypeReferenceGroup] ASC,
	[BaseCode] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tReferenceGroup] ON [dbo].[tReferenceGroup] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tReferenceGroup] SET [dbo].[tReferenceGroup].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tReferenceGroup].[Id] END