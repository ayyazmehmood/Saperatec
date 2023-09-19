CREATE TABLE [dbo].[tCostCenter] (
	[Id]		int	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	int	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idClient]		int	NOT NULL,
	[CostCenterCode]	nvarchar(12)	NOT NULL,
	[TitleCostCenter]	nvarchar(255)	NOT NULL,
	[FlagProfitCenter]	bit	NOT NULL,
CONSTRAINT [PK_dbo.tCostCenter] PRIMARY KEY NONCLUSTERED ([Id] ASC)
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