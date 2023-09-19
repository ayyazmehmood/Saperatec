CREATE TABLE [dbo].[tClient] (
	[Id]		bigint	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	bigint	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[Title]			nvarchar(30)	NOT NULL,
	[idCurrency]	bigint	NOT NULL,
	[FlagTemplate]	bit	DEFAULT(0)	NOT NULL,
	[StartOfBusinessYear]	int	DEFAULT(1)	NOT NULL,
CONSTRAINT [PK_dbo.tClient] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [dbo].[tClient] ADD CONSTRAINT [FK_tClient_idCurrency]
FOREIGN Key([idCurrency])
REFERENCES [dbo].[tCurrency] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tClient_idCurrency] ON [dbo].[tClient]
(
	[idCurrency] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tClient] ON [dbo].[tClient] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tClient] SET [dbo].[tClient].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tClient].[Id] END