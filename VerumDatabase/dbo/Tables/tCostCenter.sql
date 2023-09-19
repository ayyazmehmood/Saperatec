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
ALTER TABLE [dbo].[tCostCenter] ADD CONSTRAINT [FK_tCostCenter_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tCostCenter_Code] ON [dbo].[tCostCenter]
(
	[idClient] ASC,
	[CostCenterCode] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tCostCenter] ON [dbo].[tCostCenter] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tCostCenter] SET [dbo].[tCostCenter].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tCostCenter].[Id] END