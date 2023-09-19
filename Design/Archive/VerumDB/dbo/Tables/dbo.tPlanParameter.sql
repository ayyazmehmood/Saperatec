CREATE TABLE [dbo].[tPlanParameter] (
	[Id]		bigint	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	bigint	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[idPlan]		bigint	NOT NULL,
	[Type]			smallint	DEFAULT(0)	NOT NULL,
	[Title]			nvarchar(30)	NOT NULL,
	[ValueNum]		float	DEFAULT(0)	NOT NULL,
	[ValueDate]		datetime	NULL,
	[ValueText]		nvarchar(30)	NULL,
	[Unit]			nvarchar(15)	NULL,
	[Comment]		nvarchar(max)	NULL,
CONSTRAINT [PK_dbo.tPlanParameter] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
ALTER TABLE [dbo].[tPlanParameter] ADD CONSTRAINT [FK_tPlanParameter_idPlan]
FOREIGN Key([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tPlanParameter_PlanTitle] ON [dbo].[tPlanParameter]
(
	[idPlan] ASC,
	[Type] ASC,
	[Title] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanParameter] ON [dbo].[tPlanParameter] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanParameter] SET [dbo].[tPlanParameter].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanParameter].[Id] END