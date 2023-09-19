CREATE TABLE [dbo].[tReferenceCode] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[idReferenceGroup]	uniqueidentifier	NOT NULL,
	[RefCode]		nvarchar(12)	NOT NULL,
	[TitleRefCode]	nvarchar(50)	NULL,
	[RefCodeComment]	nvarchar(max)	NULL,
	[FlagActive]	bit	DEFAULT(1)	NOT NULL,
);
GO
ALTER TABLE [dbo].[tReferenceCode] ADD CONSTRAINT [FK_tReferenceCode_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tReferenceCode] ADD CONSTRAINT [FK_tReferenceCode_idReferenceGroup]
FOREIGN Key([idReferenceGroup])
REFERENCES [dbo].[tReferenceGroup] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tReferenceCode_Code] ON [dbo].[tReferenceCode]
(
	[idClient] ASC,
	[RefCode] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tReferenceCode_idReferenceGroup] ON [dbo].[tReferenceCode]
(
	[idReferenceGroup] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tReferenceCode] ON [dbo].[tReferenceCode] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tReferenceCode] SET [dbo].[tReferenceCode].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tReferenceCode].[Id] END