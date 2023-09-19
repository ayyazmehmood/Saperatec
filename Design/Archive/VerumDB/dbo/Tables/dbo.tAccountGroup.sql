CREATE TABLE [dbo].[tAccountGroup] (
	[Id]		bigint	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	bigint	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idClient]		bigint	NOT NULL,
	[TitleLocal]	nvarchar(50)	NOT NULL,
	[TitleEnglish]	nvarchar(50)	NOT NULL,
CONSTRAINT [PK_dbo.tAccountGroup] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [dbo].[tAccountGroup] ADD CONSTRAINT [FK_tAccountGroup_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
CREATE NONCLUSTERED INDEX [IX_tAccountGroup_idClient] ON [dbo].[tAccountGroup]
(
	[idClient] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tAccountGroup] ON [dbo].[tAccountGroup] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tAccountGroup] SET [dbo].[tAccountGroup].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tAccountGroup].[Id] END