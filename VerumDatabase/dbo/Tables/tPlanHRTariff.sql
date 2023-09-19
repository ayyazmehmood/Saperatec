CREATE TABLE [dbo].[tPlanHRTariff] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idPlan]		uniqueidentifier	NOT NULL,
	[TitleTariff]	nvarchar(50)	NOT NULL,
	[idAccountSalary]	uniqueidentifier	NOT NULL,
	[PayDay]		smallint	DEFAULT(28)	NOT NULL,
	[TariffDescription]	nvarchar(max)	NULL,
	[FlagShared]	bit	DEFAULT(1)	NOT NULL,
	[DateInflationBase]	datetime2	NULL,
);
GO
ALTER TABLE [dbo].[tPlanHRTariff] ADD CONSTRAINT [FK_tPlanHRTariff_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanHRTariff] ADD CONSTRAINT [FK_tPlanHRTariff_idAccountSalary]
FOREIGN Key([idAccountSalary])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tPlanHRTariff_TariffIndex] ON [dbo].[tPlanHRTariff]
(
	[idPlan] ASC,
	[TitleTariff] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanHRTariff_idAccountSalary] ON [dbo].[tPlanHRTariff]
(
	[idAccountSalary] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanHRTariff] ON [dbo].[tPlanHRTariff] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanHRTariff] SET [dbo].[tPlanHRTariff].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanHRTariff].[Id] END