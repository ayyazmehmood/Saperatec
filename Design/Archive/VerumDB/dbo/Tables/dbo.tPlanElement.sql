CREATE TABLE [dbo].[tPlanElement] (
	[Id]		bigint	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	bigint	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idClient]		bigint	NOT NULL,
	[idCostCenter]	bigint	NOT NULL,
	[Type]			smallint	DEFAULT(0)	NOT NULL,
	[idPlanGroup]	bigint	NOT NULL,
	[Title]			nvarchar(50)	NOT NULL,
	[ReferenceID]	nvarchar(15)	NOT NULL,
	[FlagBaseline]	bit	DEFAULT(0)	NOT NULL,
	[Description]	nvarchar(max)	NULL,
CONSTRAINT [PK_dbo.tPlanElement] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [dbo].[tPlanElement] ADD CONSTRAINT [FK_tPlanElement_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanElement] ADD CONSTRAINT [FK_tPlanElement_idCostCenter]
FOREIGN Key([idCostCenter])
REFERENCES [dbo].[tCostCenter] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[tPlanElement] ADD CONSTRAINT [FK_tPlanElement_idPlanGroup]
FOREIGN Key([idPlanGroup])
REFERENCES [dbo].[tPlanGroup] ([Id])
ON UPDATE NO ACTION 
ON DELETE NO ACTION
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElement_idClient] ON [dbo].[tPlanElement]
(
	[idClient] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElement_idCostCenter] ON [dbo].[tPlanElement]
(
	[idCostCenter] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElement_idPlanGroup] ON [dbo].[tPlanElement]
(
	[idPlanGroup] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElement_ReferenceID] ON [dbo].[tPlanElement]
(
	[ReferenceID] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanElement] ON [dbo].[tPlanElement] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanElement] SET [dbo].[tPlanElement].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanElement].[Id] END