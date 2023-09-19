CREATE TABLE [dbo].[tDepreciationRule] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[idAccountActivation]	uniqueidentifier	NOT NULL,
	[idAccountDepreciation]	uniqueidentifier	NULL,
	[TitleDepreciationRule]	nvarchar(50)	NOT NULL,
	[NumberOfPeriods]	int	NOT NULL,
	[PeriodInMonths]	int	DEFAULT(1)	NOT NULL,
	[TypeDepreciationRule]	smallint	NOT NULL,
);

GO

CREATE TRIGGER [TR_UPD_tDepreciationRule] ON [dbo].[tDepreciationRule] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tDepreciationRule] SET [dbo].[tDepreciationRule].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tDepreciationRule].[Id] END
