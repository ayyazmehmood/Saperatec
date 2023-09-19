CREATE TABLE [dbo].[tCurrency] (
	[Id]		bigint	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	bigint	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[Code]			nvarchar(3)	NOT NULL,
	[Title]			nvarchar(30)	NOT NULL,
CONSTRAINT [PK_dbo.tCurrency] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
CREATE TRIGGER [TR_UPD_tCurrency] ON [dbo].[tCurrency] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tCurrency] SET [dbo].[tCurrency].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tCurrency].[Id] END