CREATE TABLE [dbo].[tTypeCodeDef] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idTypeGroupDef]	uniqueidentifier	NOT NULL,
	[TypeID]		nvarchar(25)	NOT NULL,
	[TypeCode]		smallint	NOT NULL,
);
GO
ALTER TABLE [dbo].[tTypeCodeDef] ADD CONSTRAINT [FK_tTypeCodeDef_idTypeGroupDef]
FOREIGN Key([idTypeGroupDef])
REFERENCES [dbo].[tTypeGroupDef] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tTypeCodeDef_TypeCodeDef] ON [dbo].[tTypeCodeDef]
(
	[TypeID] ASC,
	[TypeCode] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tTypeCodeDef] ON [dbo].[tTypeCodeDef] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tTypeCodeDef] SET [dbo].[tTypeCodeDef].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tTypeCodeDef].[Id] END