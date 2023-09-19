CREATE TABLE [dbo].[tCostCenter] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[CostCenterCode]	nvarchar(12)	NOT NULL,
	[TitleCostCenter]	nvarchar(50)	NOT NULL,
	[TitleEnglishCostCenter]	nvarchar(50)	NULL,
	[FlagProfitCenter]	bit	DEFAULT(0)	NOT NULL,
	[DescriptionCostCenter]	nvarchar(max)	NULL,
);

GO

CREATE TRIGGER [TR_UPD_tCostCenter] ON [dbo].[tCostCenter] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tCostCenter] SET [dbo].[tCostCenter].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tCostCenter].[Id] END
