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
ALTER TABLE [dbo].[tAccountGroup] ADD CONSTRAINT [FK_tAccountGroup_idAccountMainGroup]
FOREIGN Key([idAccountMainGroup])
REFERENCES [dbo].[tAccountMainGroup] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
CREATE NONCLUSTERED INDEX [IX_tAccountGroup_idClient] ON [dbo].[tAccountGroup]
(
	[idClient] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tAccountGroup] ON [dbo].[tAccountGroup] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tAccountGroup] SET [dbo].[tAccountGroup].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tAccountGroup].[Id] END