CREATE TABLE [dbo].[tTypeGroupDef] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[TypeGroupID]	nvarchar(25)	NOT NULL,
);

GO

CREATE TRIGGER [TR_UPD_tTypeGroupDef] ON [dbo].[tTypeGroupDef] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tTypeGroupDef] SET [dbo].[tTypeGroupDef].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tTypeGroupDef].[Id] END
