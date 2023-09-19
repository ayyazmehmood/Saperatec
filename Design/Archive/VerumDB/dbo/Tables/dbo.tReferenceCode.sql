CREATE TABLE [dbo].[tReferenceCode] (
	[Id]		bigint	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	bigint	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idClient]		bigint	NOT NULL,
	[idReferenceGroup]	bigint	NOT NULL,
	[Code]			nvarchar(12)	NOT NULL,
	[Title]			nvarchar(50)	NOT NULL,
	[Comment]		nvarchar(max)	NOT NULL,
CONSTRAINT [PK_dbo.tReferenceCode] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [dbo].[tReferenceCode] ADD CONSTRAINT [FK_tReferenceCode_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tReferenceCode] ADD CONSTRAINT [FK_tReferenceCode_idReferenceGroup]
FOREIGN Key([idReferenceGroup])
REFERENCES [dbo].[tReferenceGroup] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tReferenceCode_Code] ON [dbo].[tReferenceCode]
(
	[idClient] ASC,
	[Code] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tReferenceCode] ON [dbo].[tReferenceCode] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tReferenceCode] SET [dbo].[tReferenceCode].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tReferenceCode].[Id] END