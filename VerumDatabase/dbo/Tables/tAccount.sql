CREATE TABLE [dbo].[tAccount] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[idAccountGroup]	uniqueidentifier	NULL,
	[idAccountReporting]	uniqueidentifier	NULL,
	[AccountCode]	int	NOT NULL,
	[TypeAccount]	smallint	DEFAULT(0)	NOT NULL,
	[TitleLocalAccount]	nvarchar(255)	NOT NULL,
	[TitleEnglishAccount]	nvarchar(255)	NULL,
	[FlagPlan]		bit	DEFAULT(0)	NOT NULL,
	[idAccountSection]	uniqueidentifier	NULL,
	[idAccountMainGroup]	uniqueidentifier	NULL,
);
GO
ALTER TABLE [dbo].[tAccount] ADD CONSTRAINT [FK_tAccount_idAccountGroup]
FOREIGN Key([idAccountGroup])
REFERENCES [dbo].[tAccountGroup] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tAccount] ADD CONSTRAINT [FK_tAccount_idAccountReporting]
FOREIGN Key([idAccountReporting])
REFERENCES [dbo].[tAccount] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tAccount] ADD CONSTRAINT [FK_tAccount_idAccountSection]
FOREIGN Key([idAccountSection])
REFERENCES [dbo].[tAccountSection] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tAccount] ADD CONSTRAINT [FK_tAccount_idAccountMainGroup]
FOREIGN Key([idAccountMainGroup])
REFERENCES [dbo].[tAccountMainGroup] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tAccount_Code] ON [dbo].[tAccount]
(
	[idClient] ASC,
	[AccountCode] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tAccount_idAccountGroup] ON [dbo].[tAccount]
(
	[idAccountGroup] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tAccount_idAccountReporting] ON [dbo].[tAccount]
(
	[idAccountReporting] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tAccount] ON [dbo].[tAccount] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tAccount] SET [dbo].[tAccount].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tAccount].[Id] END