CREATE TABLE [dbo].[tUser] (
	[Id]		uniqueidentifier	NOT NULL PRIMARY KEY NONCLUSTERED,
	[IdMigrate]	uniqueidentifier	NULL,
	[DateCreated]	datetime2	DEFAULT (sysutcdatetime()) NOT NULL,
	[DateUpdated]	datetime2	NULL,
	[UserName]		nvarchar(255)	NOT NULL,
	[UserLogin]		nvarchar(30)	NOT NULL,
	[UserPasswordHash]	nvarchar(48)	NOT NULL,
	[idClientDefault]	uniqueidentifier	NOT NULL,
	[TypeUser]		smallint	DEFAULT(0)	NOT NULL,
	[DATEVImportFolder]	nvarchar(255)	NULL,
	[DataImportFolder]	nvarchar(255)	NULL,
);

GO

CREATE TRIGGER [TR_UPD_tUser] ON [dbo].[tUser] AFTER INSERT, UPDATE, DELETE AS BEGIN UPDATE [dbo].[tUser] SET [dbo].[tUser].[DateUpdated] = SYSUTCDATETIME() FROM INSERTED WHERE inserted.[Id] = [dbo].[tUser].[Id] END
