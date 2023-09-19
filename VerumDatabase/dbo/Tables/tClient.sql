CREATE TABLE [dbo].[tClient] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[TitleClient]	nvarchar(30)	NOT NULL,
	[idCurrencyClient]	uniqueidentifier	NOT NULL,
	[FlagTemplate]	bit	DEFAULT(0)	NOT NULL,
	[StartOfBusinessYear]	int	DEFAULT(1)	NOT NULL,
	[DATEVClientNumber]	int	NULL,
	[idReferenceGroupDefault]	uniqueidentifier	NULL,
);
GO
ALTER TABLE [dbo].[tClient] ADD CONSTRAINT [FK_tClient_idCurrencyClient]
FOREIGN Key([idCurrencyClient])
REFERENCES [dbo].[tCurrency] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tClient] ADD CONSTRAINT [FK_tClient_idReferenceGroupDefault]
FOREIGN Key([idReferenceGroupDefault])
REFERENCES [dbo].[tReferenceGroup] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tClient_idCurrencyClient] ON [dbo].[tClient]
(
	[idCurrencyClient] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tClient] ON [dbo].[tClient] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tClient] SET [dbo].[tClient].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tClient].[Id] END