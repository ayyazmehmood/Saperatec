CREATE TABLE [dbo].[tTypeGroupDef] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[TypeGroupID]	nvarchar(25)	NOT NULL,
);
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tTypeGroupDef_TypeGroupID] ON [dbo].[tTypeGroupDef]
(
	[TypeGroupID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tTypeGroupDef] ON [dbo].[tTypeGroupDef] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tTypeGroupDef] SET [dbo].[tTypeGroupDef].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tTypeGroupDef].[Id] END