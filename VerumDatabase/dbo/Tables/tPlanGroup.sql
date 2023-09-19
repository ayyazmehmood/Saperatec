CREATE TABLE [dbo].[tPlanGroup] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idClient]		uniqueidentifier	NOT NULL,
	[TitlePlanGroup]	nvarchar(30)	NOT NULL,
	[TitleEnglishPlanGroup]	nvarchar(30)	NULL,
	[DescriptionPlanGroup]	nvarchar(max)	NULL,
);
GO
ALTER TABLE [dbo].[tPlanGroup] ADD CONSTRAINT [FK_tPlanGroup_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
CREATE NONCLUSTERED INDEX [IX_tPlanGroup_idClient] ON [dbo].[tPlanGroup]
(
	[idClient] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanGroup] ON [dbo].[tPlanGroup] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanGroup] SET [dbo].[tPlanGroup].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanGroup].[Id] END