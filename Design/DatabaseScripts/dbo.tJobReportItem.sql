CREATE TABLE [dbo].[tJobReportItem] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[idJobReport]	uniqueidentifier	NOT NULL,
	[Timestamp]		datetime2	NOT NULL,
	[TypeJobSuccess]	smallint	NOT NULL,
	[ResultCode]	int	NOT NULL,
	[ObjectTitle]	nvarchar(255)	NULL,
	[ContextInfo]	nvarchar(255)	NULL,
	[Message]		nvarchar(255)	NULL,
);

GO

CREATE TRIGGER [TR_UPD_tJobReportItem] ON [dbo].[tJobReportItem] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tJobReportItem] SET [dbo].[tJobReportItem].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tJobReportItem].[Id] END
