CREATE TABLE [dbo].[tPlanGroup] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[TitlePlanGroup]	nvarchar(30)	NOT NULL,
	[TitleEnglishPlanGroup]	nvarchar(30)	NULL,
	[DescriptionPlanGroup]	nvarchar(max)	NULL,
);

GO

CREATE TRIGGER [TR_UPD_tPlanGroup] ON [dbo].[tPlanGroup] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanGroup] SET [dbo].[tPlanGroup].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanGroup].[Id] END
