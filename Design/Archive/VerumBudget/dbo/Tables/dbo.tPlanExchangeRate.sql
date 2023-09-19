﻿CREATE TABLE [dbo].[tPlanExchangeRate] (
	[Id]		int	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	int	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idPlan]		int	NOT NULL,
	[TitlePlanXRate]	nvarchar(30)	NOT NULL,
	[idCurrencyExchangeRate]	int	NOT NULL,
	[RatePerClientCurrency]	float	NOT NULL,
CONSTRAINT [PK_dbo.tPlanExchangeRate] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [dbo].[tPlanExchangeRate] ADD CONSTRAINT [FK_tPlanExchangeRate_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanExchangeRate] ADD CONSTRAINT [FK_tPlanExchangeRate_idCurrencyExchangeRate]
FOREIGN Key([idCurrencyExchangeRate])
REFERENCES [dbo].[tCurrency] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tPlanExchangeRate_idPlan] ON [dbo].[tPlanExchangeRate]
(
	[idPlan] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tPlanExchangeRate_idCurrencyExchangeRate] ON [dbo].[tPlanExchangeRate]
(
	[idCurrencyExchangeRate] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanExchangeRate] ON [dbo].[tPlanExchangeRate] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanExchangeRate] SET [dbo].[tPlanExchangeRate].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanExchangeRate].[Id] END