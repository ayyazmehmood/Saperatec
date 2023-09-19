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
ALTER TABLE [dbo].[tAccountSection] ADD CONSTRAINT [FK_tAccountSection_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tAccountSection_SectionOrder] ON [dbo].[tAccountSection]
(
	[TypeAccount] ASC,
	[SectionOrder] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tAccountSection] ON [dbo].[tAccountSection] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tAccountSection] SET [dbo].[tAccountSection].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tAccountSection].[Id] END