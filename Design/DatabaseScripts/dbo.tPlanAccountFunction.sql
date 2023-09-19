CREATE TABLE [dbo].[tPlanAccountFunction] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[TypeAccountFunction]	int	NOT NULL,
	[idAccountPlanAccountFunction]	uniqueidentifier	NOT NULL,
);

GO

CREATE TRIGGER [TR_UPD_tPlanAccountFunction] ON [dbo].[tPlanAccountFunction] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanAccountFunction] SET [dbo].[tPlanAccountFunction].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanAccountFunction].[Id] END
