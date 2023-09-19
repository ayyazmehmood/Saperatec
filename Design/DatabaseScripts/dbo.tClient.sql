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

CREATE TRIGGER [TR_UPD_tClient] ON [dbo].[tClient] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tClient] SET [dbo].[tClient].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tClient].[Id] END
