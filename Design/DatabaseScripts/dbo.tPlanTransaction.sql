CREATE TABLE [dbo].[tPlanTransaction] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idPlan]		uniqueidentifier	NOT NULL,
	[idBookTransaction]	uniqueidentifier	NOT NULL,
);

GO

CREATE TRIGGER [TR_UPD_tPlanTransaction] ON [dbo].[tPlanTransaction] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanTransaction] SET [dbo].[tPlanTransaction].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanTransaction].[Id] END
