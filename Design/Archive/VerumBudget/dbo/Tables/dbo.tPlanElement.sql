CREATE TABLE [dbo].[tPlanElement] (
	[Id]		int	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	int	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idClient]		int	NOT NULL,
	[idCostCenterPlanElement]	int	NOT NULL,
	[TypePlanElement]	smallint	DEFAULT(0)	NOT NULL,
	[idPlanGroup]	int	NOT NULL,
	[TitlePlanElement]	nvarchar(50)	NOT NULL,
	[ReferenceIDPlanElement]	nvarchar(15)	NOT NULL,
	[ElementFlagBaseline]	bit	DEFAULT(0)	NOT NULL,
	[PlanElementDescription]	nvarchar(max)	NULL,
CONSTRAINT [PK_dbo.tPlanElement] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [dbo].[tPlanElement] ADD CONSTRAINT [FK_tPlanElement_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanElement] ADD CONSTRAINT [FK_tPlanElement_idCostCenterPlanElement]
FOREIGN Key([idCostCenterPlanElement])
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
CREATE NONCLUSTERED INDEX [IX_tPlanElement_idCostCenterPlanElement] ON [dbo].[tPlanElement]
(
	[idCostCenterPlanElement] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElement_idPlanGroup] ON [dbo].[tPlanElement]
(
	[idPlanGroup] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tPlanElement_ReferenceIDPlanElement] ON [dbo].[tPlanElement]
(
	[ReferenceIDPlanElement] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanElement] ON [dbo].[tPlanElement] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanElement] SET [dbo].[tPlanElement].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanElement].[Id] END