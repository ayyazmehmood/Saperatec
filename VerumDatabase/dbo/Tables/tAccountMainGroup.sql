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
ALTER TABLE [dbo].[tAccountMainGroup] ADD CONSTRAINT [FK_tAccountMainGroup_idAccountSection]
FOREIGN Key([idAccountSection])
REFERENCES [dbo].[tAccountSection] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tAccountMainGroup_MainGroupOrder] ON [dbo].[tAccountMainGroup]
(
	[idAccountSection] ASC,
	[MainGroupOrder] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tAccountMainGroup] ON [dbo].[tAccountMainGroup] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tAccountMainGroup] SET [dbo].[tAccountMainGroup].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tAccountMainGroup].[Id] END