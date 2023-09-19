CREATE TABLE [dbo].[tVATRule] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[idAccountVATInput]	uniqueidentifier	NOT NULL,
	[idAccountVATOutput]	uniqueidentifier	NOT NULL,
	[idAccountVATBalance]	uniqueidentifier	NULL,
	[VATRuleCode]	nvarchar(5)	NULL,
	[TitleVATRule]	nvarchar(50)	NOT NULL,
	[RateCurrent]	float	NOT NULL,
	[SettlementTerm]	int	NOT NULL,
	[DateRateChange]	datetime2	NULL,
	[RateFuture]	float	NULL,
	[FlagReverseCharge]	bit	DEFAULT(0)	NOT NULL,
);

GO

CREATE TRIGGER [TR_UPD_tVATRule] ON [dbo].[tVATRule] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tVATRule] SET [dbo].[tVATRule].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tVATRule].[Id] END
