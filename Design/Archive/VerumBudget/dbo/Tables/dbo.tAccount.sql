CREATE TABLE [dbo].[tAccount] (
	[Id]		int	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	int	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idClient]		int	NOT NULL,
	[idAccountGroup]	int	NULL,
	[idAccountReporting]	int	NULL,
	[AccountCode]	int	NOT NULL,
	[TypeAccount]	smallint	NOT NULL,
	[TitleLocalAccount]	nvarchar(50)	NOT NULL,
	[TitleEnglishAccount]	nvarchar(50)	NOT NULL,
	[FlagPlan]		bit	DEFAULT(0)	NOT NULL,
CONSTRAINT [PK_dbo.tAccount] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [dbo].[tAccount] ADD CONSTRAINT [FK_tAccount_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tAccount] ADD CONSTRAINT [FK_tAccount_idAccountGroup]
FOREIGN Key([idAccountGroup])
REFERENCES [dbo].[tAccountGroup] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tAccount] ADD CONSTRAINT [FK_tAccount_idAccountReporting]
FOREIGN Key([idAccountReporting])
REFERENCES [dbo].[tAccount] ([Id])
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