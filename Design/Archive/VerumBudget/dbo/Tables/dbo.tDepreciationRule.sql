CREATE TABLE [dbo].[tDepreciationRule] (
	[Id]		int	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	int	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idClient]		int	NOT NULL,
	[idAccountDepreciation]	int	NOT NULL,
	[TitleDepreciationRule]	nvarchar(50)	NOT NULL,
	[NumberOfPeriods]	int	NOT NULL,
	[PeriodInMonths]	int	DEFAULT(1)	NOT NULL,
	[TypeDepreciationRule]	smallint	NOT NULL,
CONSTRAINT [PK_dbo.tDepreciationRule] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [dbo].[tDepreciationRule] ADD CONSTRAINT [FK_tDepreciationRule_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tDepreciationRule] ADD CONSTRAINT [FK_tDepreciationRule_idAccountDepreciation]
FOREIGN Key([idAccountDepreciation])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tDepreciationRule_idClient] ON [dbo].[tDepreciationRule]
(
	[idClient] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tDepreciationRule_idAccountDepreciation] ON [dbo].[tDepreciationRule]
(
	[idAccountDepreciation] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tDepreciationRule] ON [dbo].[tDepreciationRule] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tDepreciationRule] SET [dbo].[tDepreciationRule].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tDepreciationRule].[Id] END