﻿CREATE TABLE [dbo].[tPlanFunctionDef] (
	[Id]		int	IDENTITY(1,1) NOT NULL,
	[IdMigrate]	int	NULL,
	[DateCreated]	datetime	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime	NULL,
	[TitleFunctionDef]	nvarchar(15)	NOT NULL,
CONSTRAINT [PK_dbo.tPlanFunctionDef] PRIMARY KEY NONCLUSTERED ([Id] ASC)
);
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tPlanFunctionDef_TitleFunctionDef] ON [dbo].[tPlanFunctionDef]
(
	[TitleFunctionDef] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [TR_UPD_tPlanFunctionDef] ON [dbo].[tPlanFunctionDef] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tPlanFunctionDef] SET [dbo].[tPlanFunctionDef].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tPlanFunctionDef].[Id] END