USE [master]
GO
/****** Object:  Database [verum_Test]    Script Date: 07-Feb-24 10:16:18 AM ******/
CREATE DATABASE [verum_Test]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'verum_Test_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\verum_Test.mdf' , SIZE = 17408KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'verum_Test_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\verum_Test.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [verum_Test] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [verum_Test].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [verum_Test] SET ANSI_NULL_DEFAULT ON 
GO
ALTER DATABASE [verum_Test] SET ANSI_NULLS ON 
GO
ALTER DATABASE [verum_Test] SET ANSI_PADDING ON 
GO
ALTER DATABASE [verum_Test] SET ANSI_WARNINGS ON 
GO
ALTER DATABASE [verum_Test] SET ARITHABORT ON 
GO
ALTER DATABASE [verum_Test] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [verum_Test] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [verum_Test] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [verum_Test] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [verum_Test] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [verum_Test] SET CONCAT_NULL_YIELDS_NULL ON 
GO
ALTER DATABASE [verum_Test] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [verum_Test] SET QUOTED_IDENTIFIER ON 
GO
ALTER DATABASE [verum_Test] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [verum_Test] SET  ENABLE_BROKER 
GO
ALTER DATABASE [verum_Test] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [verum_Test] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [verum_Test] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [verum_Test] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [verum_Test] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [verum_Test] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [verum_Test] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [verum_Test] SET RECOVERY FULL 
GO
ALTER DATABASE [verum_Test] SET  MULTI_USER 
GO
ALTER DATABASE [verum_Test] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [verum_Test] SET DB_CHAINING OFF 
GO
ALTER DATABASE [verum_Test] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [verum_Test] SET TARGET_RECOVERY_TIME = 120 SECONDS 
GO
ALTER DATABASE [verum_Test] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [verum_Test] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'verum_Test', N'ON'
GO
ALTER DATABASE [verum_Test] SET QUERY_STORE = ON
GO
ALTER DATABASE [verum_Test] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = ALL, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [verum_Test]
GO
USE [verum_Test]
GO
/****** Object:  DatabaseScopedCredential [https://sqlva2ttlgydeeaw7i.blob.core.windows.net/sqldbauditlogs]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE DATABASE SCOPED CREDENTIAL [https://sqlva2ttlgydeeaw7i.blob.core.windows.net/sqldbauditlogs] WITH IDENTITY = N'SHARED ACCESS SIGNATURE'
GO
/****** Object:  User [tlitka@saperatec.de]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE USER [tlitka@saperatec.de] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ffriedrich@saperatec.de]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE USER [ffriedrich@saperatec.de] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [bwindus@saperatec.de]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE USER [bwindus@saperatec.de] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [amehmood@saperatec.de]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE USER [amehmood@saperatec.de] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [tlitka@saperatec.de]
GO
ALTER ROLE [db_owner] ADD MEMBER [ffriedrich@saperatec.de]
GO
ALTER ROLE [db_owner] ADD MEMBER [amehmood@saperatec.de]
GO
ALTER ROLE [db_datareader] ADD MEMBER [amehmood@saperatec.de]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [amehmood@saperatec.de]
GO
/****** Object:  Table [dbo].[tAccount]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tAccount](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[idAccountGroup] [uniqueidentifier] NULL,
	[idAccountReporting] [uniqueidentifier] NULL,
	[AccountCode] [int] NOT NULL,
	[TypeAccount] [smallint] NOT NULL,
	[TitleLocalAccount] [nvarchar](255) NOT NULL,
	[TitleEnglishAccount] [nvarchar](255) NULL,
	[FlagPlan] [bit] NOT NULL,
	[idAccountSection] [uniqueidentifier] NULL,
	[idAccountMainGroup] [uniqueidentifier] NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tAccountGroup]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tAccountGroup](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[idAccountMainGroup] [uniqueidentifier] NULL,
	[TitleLocalAccountGroup] [nvarchar](255) NOT NULL,
	[TitleEnglishAccountGroup] [nvarchar](255) NULL,
	[AccountGroupOrder] [int] NOT NULL,
	[AccountCodeFrom] [int] NOT NULL,
	[AccountCodeTo] [int] NOT NULL,
	[idAccountReportingDefault] [uniqueidentifier] NULL,
	[TypeAccountDefault] [smallint] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tAccountMainGroup]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tAccountMainGroup](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[idAccountSection] [uniqueidentifier] NOT NULL,
	[TitleLocalMainGroup] [nvarchar](255) NOT NULL,
	[TitleEnglishMainGroup] [nvarchar](255) NULL,
	[MainGroupOrder] [int] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tAccountSection]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tAccountSection](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[TitleLocalSection] [nvarchar](255) NOT NULL,
	[TitleEnglishSection] [nvarchar](255) NULL,
	[TypeAccount] [smallint] NOT NULL,
	[SectionOrder] [int] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[repAccountsWithSections]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[repAccountsWithSections]
AS
SELECT        dbo.tAccount.AccountCode AS Konto, dbo.tAccount.TitleLocalAccount AS Bezeichnung, dbo.tAccount.TypeAccount AS Typ, dbo.tAccountSection.SectionOrder AS [Sektion Lfd], 
                         dbo.tAccountSection.TitleLocalSection AS [Sektion Titel], dbo.tAccountMainGroup.MainGroupOrder AS [Hauptgruppe Lfd], dbo.tAccountMainGroup.TitleLocalMainGroup AS [Hauptgruppe Titel], 
                         dbo.tAccountGroup.AccountGroupOrder AS [Gruppe Lfd], dbo.tAccountGroup.TitleLocalAccountGroup AS [Gruppe Titel], dbo.tAccountGroup.AccountCodeFrom AS [Bereich Beginn], 
                         dbo.tAccountGroup.AccountCodeTo AS [Bereich Ende]
FROM            dbo.tAccount INNER JOIN
                         dbo.tAccountMainGroup ON dbo.tAccount.idAccountMainGroup = dbo.tAccountMainGroup.Id INNER JOIN
                         dbo.tAccountSection ON dbo.tAccount.idAccountSection = dbo.tAccountSection.Id INNER JOIN
                         dbo.tAccountGroup ON dbo.tAccount.idAccountGroup = dbo.tAccountGroup.Id
GO
/****** Object:  Table [dbo].[tCostCenter]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tCostCenter](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[CostCenterCode] [nvarchar](12) NOT NULL,
	[TitleCostCenter] [nvarchar](50) NOT NULL,
	[TitleEnglishCostCenter] [nvarchar](50) NULL,
	[FlagProfitCenter] [bit] NOT NULL,
	[DescriptionCostCenter] [nvarchar](max) NULL,
	[IdMigrate] [uniqueidentifier] NULL,
	[idBudgetResponsible] [uniqueidentifier] NULL,
	[idExecutiveApprover] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tPlan]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlan](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[idPlanBase] [uniqueidentifier] NULL,
	[TitlePlan] [nvarchar](30) NOT NULL,
	[DateValidFrom] [datetime2](7) NOT NULL,
	[DateValidTo] [datetime2](7) NOT NULL,
	[ApprovedTo] [datetime2](7) NULL,
	[PlanFlagBaseline] [bit] NOT NULL,
	[TypeStatus] [smallint] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tPlanElement]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlanElement](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[idCostCenterPlanElement] [uniqueidentifier] NULL,
	[idCurrency] [uniqueidentifier] NULL,
	[TypePlanElement] [smallint] NOT NULL,
	[idPlanGroup] [uniqueidentifier] NULL,
	[TitlePlanElement] [nvarchar](50) NOT NULL,
	[ReferenceIDPlanElement] [nvarchar](15) NULL,
	[ElementFlagBaseline] [bit] NOT NULL,
	[PlanElementDescription] [nvarchar](max) NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tPlanElementInstance]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlanElementInstance](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idPlanElement] [uniqueidentifier] NOT NULL,
	[idPlan] [uniqueidentifier] NOT NULL,
	[FlagUpdate] [bit] NOT NULL,
	[FlagBaseline] [bit] NOT NULL,
	[FlagDateOffset] [bit] NOT NULL,
	[DueDateYear] [int] NOT NULL,
	[DueDateMonth] [int] NOT NULL,
	[DueDateDay] [int] NOT NULL,
	[UntilDateYear] [int] NULL,
	[UntilDateMonth] [int] NULL,
	[UntilDateDay] [int] NULL,
	[idParTriggerDueDate] [uniqueidentifier] NULL,
	[Assumptions] [nvarchar](max) NULL,
	[Revisions] [nvarchar](max) NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[repElementsByPlan]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[repElementsByPlan]
AS
SELECT        p.TitlePlan, e.TitlePlanElement, c.CostCenterCode, e.ReferenceIDPlanElement, i.UntilDateYear, i.UntilDateMonth, i.UntilDateDay, i.DueDateYear, i.DueDateMonth, i.DueDateDay, i.FlagDateOffset, e.TypePlanElement, 
                         p.TypeStatus AS PlanTypeStatus, p.DateValidFrom AS PlanValidFrom, p.DateValidTo AS PlanValidTo, p.ApprovedTo AS PlanApprovedTo, i.FlagUpdate, p.PlanFlagBaseline, e.ElementFlagBaseline, 
                         i.FlagBaseline AS InstanceFlagBaseline, e.DateCreated AS ElementCreated, e.DateUpdated AS ElementUpdated, i.DateCreated AS InstanceCreated, i.DateUpdated AS InstanceUpdated, i.idPlan, i.idPlanElement, 
                         i.Id AS idInstance
FROM            dbo.tPlanElementInstance AS i INNER JOIN
                         dbo.tPlanElement AS e ON i.idPlanElement = e.Id INNER JOIN
                         dbo.tPlan AS p ON i.idPlan = p.Id INNER JOIN
                         dbo.tCostCenter AS c ON e.idCostCenterPlanElement = c.Id
GO
/****** Object:  Table [dbo].[tReferenceCode]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tReferenceCode](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[idReferenceGroup] [uniqueidentifier] NOT NULL,
	[RefCode] [nvarchar](12) NOT NULL,
	[TitleRefCode] [nvarchar](50) NULL,
	[RefCodeComment] [nvarchar](max) NULL,
	[IdMigrate] [uniqueidentifier] NULL,
	[FlagActive] [bit] NOT NULL,
	[TitleRefCodeEnglish] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tBookTransaction]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tBookTransaction](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idBookingRecord] [uniqueidentifier] NOT NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[idPlan] [uniqueidentifier] NULL,
	[idPlanElement] [uniqueidentifier] NULL,
	[idAccountReport] [uniqueidentifier] NOT NULL,
	[idAccountBooking] [uniqueidentifier] NOT NULL,
	[idCostCenter] [uniqueidentifier] NULL,
	[AccountCodeReport] [int] NULL,
	[CostCenterCode] [nvarchar](12) NULL,
	[TypeBookRecord] [smallint] NULL,
	[FlagAccountOpening] [bit] NOT NULL,
	[BookingDate] [datetime2](7) NULL,
	[MonthIndex] [int] NOT NULL,
	[AmountDebit] [float] NOT NULL,
	[AmountCredit] [float] NOT NULL,
	[ReviewComment] [nvarchar](max) NULL,
	[FlagForecast] [smallint] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL,
	[ReferenceIDBookTransaction] [nvarchar](15) NULL,
	[FlagBaseline] [smallint] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[repFinancialReportByRefID]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[repFinancialReportByRefID]
AS
SELECT        f.idClient, f.RefID, r.TitleRefCode, f.CostCenterCode, a.AccountCode, a.TitleLocalAccount AS AccountTitle, (f.MonthIndex - 1) / 12 AS Year, (f.MonthIndex - 1) % 12 + 1 AS Month, f.Actual, f.Baseline, f.Budget, f.Forecast
FROM            (SELECT        idClient, RefID, CostCenterCode, idAccountReport, MonthIndex, SUM(Actual) AS Actual, SUM(Baseline) AS Baseline, SUM(Budget) AS Budget, SUM(Forecast) AS Forecast
                          FROM            (SELECT        idClient, ReferenceIDBookTransaction AS RefID, CostCenterCode, idAccountReport, MonthIndex, SUM(AmountCredit - AmountDebit) AS Actual, 0 AS Baseline, 0 AS Budget, 0 AS Forecast
                                                    FROM            dbo.tBookTransaction AS t
                                                    GROUP BY idClient, ReferenceIDBookTransaction, CostCenterCode, idAccountReport, MonthIndex, TypeBookRecord, FlagAccountOpening
                                                    HAVING         (TypeBookRecord = 0) AND (FlagAccountOpening = 0)
                                                    UNION
                                                    SELECT        idClient, ReferenceIDBookTransaction AS RefID, CostCenterCode, idAccountReport, MonthIndex, 0 AS Actual, SUM(AmountCredit - AmountDebit) AS Baseline, 0 AS Budget, 0 AS Forecast
                                                    FROM            dbo.tBookTransaction AS t
                                                    GROUP BY idClient, ReferenceIDBookTransaction, CostCenterCode, idAccountReport, MonthIndex, FlagBaseline, FlagAccountOpening
                                                    HAVING        (FlagBaseline = 1) AND (FlagAccountOpening = 0)
                                                    UNION
                                                    SELECT        idClient, ReferenceIDBookTransaction AS RefID, CostCenterCode, idAccountReport, MonthIndex, 0 AS Actual, 0 AS Baseline, SUM(AmountCredit - AmountDebit) AS Budget, 0 AS Forecast
                                                    FROM            dbo.tBookTransaction AS t
                                                    GROUP BY idClient, ReferenceIDBookTransaction, CostCenterCode, idAccountReport, MonthIndex, TypeBookRecord, FlagAccountOpening
                                                    HAVING        (TypeBookRecord = 1) AND (FlagAccountOpening = 0)
                                                    UNION
                                                    SELECT        idClient, ReferenceIDBookTransaction AS RefID, CostCenterCode, idAccountReport, MonthIndex, 0 AS Actual, 0 AS Baseline, 0 AS Budget, SUM(AmountCredit - AmountDebit) AS Forecast
                                                    FROM            dbo.tBookTransaction AS t
                                                    GROUP BY idClient, ReferenceIDBookTransaction, CostCenterCode, idAccountReport, MonthIndex, FlagForecast, FlagAccountOpening
                                                    HAVING        (FlagForecast = 1) AND (FlagAccountOpening = 0)) AS u
                          GROUP BY idClient, RefID, CostCenterCode, idAccountReport, MonthIndex) AS f INNER JOIN
                         dbo.tAccount AS a ON f.idAccountReport = a.Id LEFT OUTER JOIN
                         dbo.tReferenceCode AS r ON r.idClient = f.idClient AND r.RefCode = f.RefID
GO
/****** Object:  Table [dbo].[tBookRecord]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tBookRecord](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[FlagOutdated] [bit] NOT NULL,
	[DateOutdated] [datetime2](7) NULL,
	[TypeBookRecord] [smallint] NOT NULL,
	[FlagAccountOpening] [bit] NOT NULL,
	[idAccountDebit] [uniqueidentifier] NOT NULL,
	[idAccountCredit] [uniqueidentifier] NOT NULL,
	[idCostCenterBookRecord] [uniqueidentifier] NULL,
	[idBookingRun] [uniqueidentifier] NULL,
	[BookingRunCode] [nvarchar](30) NULL,
	[BookingSequenceNum] [int] NULL,
	[AccountCodeDebit] [int] NOT NULL,
	[AccountCodeCredit] [int] NOT NULL,
	[DATEVBUCode] [smallint] NOT NULL,
	[idPlanElementInstance] [uniqueidentifier] NULL,
	[TitleBookRecord] [nvarchar](255) NULL,
	[BookingDate] [datetime2](7) NOT NULL,
	[Amount] [float] NOT NULL,
	[BookingDocument] [nvarchar](50) NULL,
	[ReferenceIDBookRecord] [nvarchar](15) NULL,
	[BookRecordComment] [nvarchar](max) NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[repFinancialReportByRefID2]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[repFinancialReportByRefID2]
AS
SELECT   CASE WHEN dbo.tBookTransaction.TypeBookRecord = 0 THEN 'verum_TestBuchung' WHEN dbo.tBookTransaction.TypeBookRecord = 1 THEN 'verum_TestBudget' WHEN dbo.tBookTransaction.TypeBookRecord
                          = 2 THEN 'verum_TestPlan' ELSE 'verum_TestHistorical' END AS Belegart, dbo.tBookTransaction.FlagForecast, dbo.tBookTransaction.CostCenterCode AS Kostenstelle, 
                         dbo.tBookTransaction.ReferenceIDBookTransaction AS Buchungsschlüssel, dbo.tReferenceCode.TitleRefCode AS Buchungsschlüssel_Name, 
                         dbo.tBookTransaction.AccountCodeReport AS Sachkontonr, dbo.tAccount.TitleLocalAccount AS Sachkonto_Name, DATEFROMPARTS(YEAR(dbo.tBookTransaction.BookingDate), 
                         MONTH(dbo.tBookTransaction.BookingDate), 1) AS Buchungsdatum, SUM(dbo.tBookTransaction.AmountCredit - dbo.tBookTransaction.AmountDebit) AS Wert
FROM         dbo.tBookTransaction INNER JOIN
                         dbo.tBookRecord ON dbo.tBookTransaction.idBookingRecord = dbo.tBookRecord.Id INNER JOIN
                         dbo.tAccount ON dbo.tBookTransaction.idAccountReport = dbo.tAccount.Id LEFT OUTER JOIN
                         dbo.tReferenceCode ON dbo.tBookTransaction.ReferenceIDBookTransaction = dbo.tReferenceCode.RefCode
WHERE     (dbo.tBookTransaction.FlagForecast = 1) AND (dbo.tBookTransaction.FlagAccountOpening = 0) OR
                         (dbo.tBookTransaction.TypeBookRecord = 1) AND (dbo.tBookTransaction.FlagAccountOpening = 0) OR
                         (dbo.tBookTransaction.FlagBaseline = 1) AND (dbo.tBookTransaction.FlagAccountOpening = 0)
GROUP BY CASE WHEN dbo.tBookTransaction.TypeBookRecord = 0 THEN 'verum_TestBuchung' WHEN dbo.tBookTransaction.TypeBookRecord = 1 THEN 'verum_TestBudget' WHEN dbo.tBookTransaction.TypeBookRecord
                          = 2 THEN 'verum_TestPlan' ELSE 'verum_TestHistorical' END, dbo.tBookTransaction.CostCenterCode, dbo.tBookTransaction.ReferenceIDBookTransaction, 
                         dbo.tBookTransaction.AccountCodeReport, dbo.tAccount.TitleLocalAccount, dbo.tReferenceCode.TitleRefCode, DATEFROMPARTS(YEAR(dbo.tBookTransaction.BookingDate), 
                         MONTH(dbo.tBookTransaction.BookingDate), 1), dbo.tBookTransaction.FlagForecast
GO
/****** Object:  View [dbo].[repPlanElementInstanceOrigin]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[repPlanElementInstanceOrigin]
AS
SELECT        i.Id AS InstanceId, e.TitlePlanElement, i.DateCreated, i.DateUpdated, p0.TitlePlan AS InstancePlan, p.TitlePlan AS OriginalPlan, i.Assumptions, i.Revisions
FROM            dbo.tPlanElementInstance AS i LEFT OUTER JOIN
                         dbo.tPlanElementInstance AS o ON i.IdMigrate = o.Id INNER JOIN
                         dbo.tPlan AS p0 ON i.idPlan = p0.Id INNER JOIN
                         dbo.tPlan AS p ON o.idPlan = p.Id INNER JOIN
                         dbo.tPlanElement AS e ON i.idPlanElement = e.Id
GO
/****** Object:  Table [dbo].[tReferenceGroup]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tReferenceGroup](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[TypeReferenceGroup] [nvarchar](1) NOT NULL,
	[TitleReferenceGroup] [nvarchar](50) NOT NULL,
	[BaseCode] [nvarchar](2) NULL,
	[NextNum] [int] NOT NULL,
	[FlagAutoGen] [bit] NOT NULL,
	[AutoDigits] [smallint] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[repReferenceCodes]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[repReferenceCodes]
AS
SELECT   dbo.tReferenceCode.RefCode, dbo.tReferenceCode.TitleRefCode, dbo.tReferenceCode.TitleRefCodeEnglish, dbo.tReferenceGroup.TitleReferenceGroup, 
                         dbo.tReferenceCode.RefCodeComment, dbo.tReferenceCode.FlagActive, dbo.tReferenceCode.Id, dbo.tReferenceCode.idClient, dbo.tReferenceCode.idReferenceGroup
FROM         dbo.tReferenceCode INNER JOIN
                         dbo.tReferenceGroup ON dbo.tReferenceCode.idReferenceGroup = dbo.tReferenceGroup.Id
GO
/****** Object:  View [dbo].[repTransactionDetail]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[repTransactionDetail]
AS
SELECT        dbo.tBookTransaction.Id, 
                         CASE WHEN dbo.tBookTransaction.TypeBookRecord = 0 THEN 'Actual' WHEN dbo.tBookTransaction.TypeBookRecord = 1 THEN 'Budget' WHEN dbo.tBookTransaction.TypeBookRecord = 2 THEN 'Plan' ELSE 'Historical' END AS ReportType,
                          dbo.tBookTransaction.FlagForecast, dbo.tBookTransaction.FlagAccountOpening, dbo.tBookTransaction.BookingDate, YEAR(dbo.tBookTransaction.BookingDate) AS Year, 
                         CASE WHEN dbo.tBookTransaction.FlagAccountOpening = 0 THEN MONTH(dbo.tBookTransaction.BookingDate) ELSE 0 END AS Month, dbo.tBookTransaction.AccountCodeReport AS AccountCode, 
                         dbo.tAccount.TitleLocalAccount AS AccountTitle, { fn CONCAT(FORMAT(dbo.tBookTransaction.AccountCodeReport, '0000'), { fn CONCAT(' ', dbo.tAccount.TitleLocalAccount) }) } AS Account, 
                         { fn CONCAT(FORMAT(AccountBooking.AccountCode, '0000'), { fn CONCAT(' ', AccountBooking.TitleLocalAccount) }) } AS AccountBooking, dbo.tBookTransaction.CostCenterCode, dbo.tCostCenter.TitleCostCenter, 
                         dbo.tBookTransaction.AmountDebit, dbo.tBookTransaction.AmountCredit, dbo.tBookTransaction.AmountCredit - dbo.tBookTransaction.AmountDebit AS AmountTotal, dbo.tBookRecord.TitleBookRecord, 
                         dbo.tBookRecord.BookingDocument, dbo.tBookRecord.ReferenceIDBookRecord AS [BS Code], dbo.tBookRecord.BookRecordComment, dbo.tBookRecord.BookingRunCode, dbo.tBookRecord.BookingSequenceNum, 
                         dbo.tBookRecord.AccountCodeDebit, dbo.tBookRecord.AccountCodeCredit, dbo.tBookRecord.DATEVBUCode, dbo.tAccountSection.SectionOrder, dbo.tAccountSection.TitleLocalSection, dbo.tAccountMainGroup.MainGroupOrder, 
                         dbo.tAccountMainGroup.TitleLocalMainGroup, dbo.tAccountGroup.AccountGroupOrder, dbo.tAccountGroup.TitleLocalAccountGroup, dbo.tBookTransaction.ReviewComment, dbo.tBookTransaction.idClient, 
                         dbo.tBookTransaction.idPlan, dbo.tBookRecord.idPlanElementInstance, dbo.tAccount.TypeAccount, dbo.tReferenceCode.TitleRefCode AS [BS Title], dbo.tBookTransaction.FlagBaseline
FROM            dbo.tBookTransaction INNER JOIN
                         dbo.tAccount ON dbo.tBookTransaction.idAccountReport = dbo.tAccount.Id INNER JOIN
                         dbo.tAccountGroup ON dbo.tAccount.idAccountGroup = dbo.tAccountGroup.Id INNER JOIN
                         dbo.tBookRecord ON dbo.tBookTransaction.idBookingRecord = dbo.tBookRecord.Id INNER JOIN
                         dbo.tAccount AS AccountBooking ON dbo.tBookTransaction.idAccountBooking = AccountBooking.Id INNER JOIN
                         dbo.tAccountMainGroup ON dbo.tAccountGroup.idAccountMainGroup = dbo.tAccountMainGroup.Id INNER JOIN
                         dbo.tAccountSection ON dbo.tAccountMainGroup.idAccountSection = dbo.tAccountSection.Id LEFT OUTER JOIN
                         dbo.tReferenceCode ON dbo.tBookTransaction.ReferenceIDBookTransaction = dbo.tReferenceCode.RefCode LEFT OUTER JOIN
                         dbo.tCostCenter ON dbo.tBookTransaction.idCostCenter = dbo.tCostCenter.Id
WHERE        (dbo.tBookTransaction.FlagForecast = 1) AND (YEAR(dbo.tBookTransaction.BookingDate) >= 2022) OR
                         (dbo.tBookTransaction.TypeBookRecord = 1) OR
                         (dbo.tBookTransaction.TypeBookRecord = 0) OR
                         (dbo.tBookTransaction.FlagBaseline = 1)
GO
/****** Object:  View [dbo].[repTransactionGroupedByAccount]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[repTransactionGroupedByAccount]
AS
SELECT        CASE WHEN dbo.tAccount.TypeAccount = 0 THEN 'GuV' WHEN dbo.tAccount.TypeAccount = 1 THEN 'Aktiva' WHEN dbo.tAccount.TypeAccount = 2 THEN 'Passiva' ELSE 'Sonstige' END AS Report, 
                         dbo.tAccountSection.SectionOrder, dbo.tAccountSection.TitleLocalSection, dbo.tAccountMainGroup.MainGroupOrder, dbo.tAccountMainGroup.TitleLocalMainGroup, dbo.tAccountGroup.AccountGroupOrder, 
                         dbo.tAccountGroup.TitleLocalAccountGroup, dbo.tBookTransaction.AccountCodeReport, dbo.tAccount.TitleLocalAccount, YEAR(dbo.tBookTransaction.BookingDate) AS Year, 
                         CASE WHEN dbo.tBookTransaction.FlagAccountOpening = 0 THEN MONTH(dbo.tBookTransaction.BookingDate) ELSE 0 END AS Month, 
                         CASE WHEN dbo.tBookTransaction.TypeBookRecord = 0 THEN 'Actual' WHEN dbo.tBookTransaction.TypeBookRecord = 1 THEN 'Budget' WHEN dbo.tBookTransaction.TypeBookRecord = 2 THEN 'Plan' ELSE 'Historical' END AS ReportType,
                          dbo.tBookTransaction.FlagForecast, SUM(dbo.tBookTransaction.AmountDebit) AS AmountDebitTotal, SUM(dbo.tBookTransaction.AmountCredit) AS AmountCreditTotal, 
                         SUM(dbo.tBookTransaction.AmountCredit - dbo.tBookTransaction.AmountDebit) AS AmountTotal, dbo.tBookTransaction.idClient
FROM            dbo.tAccountSection INNER JOIN
                         dbo.tAccount ON dbo.tAccountSection.Id = dbo.tAccount.idAccountSection INNER JOIN
                         dbo.tAccountMainGroup ON dbo.tAccount.idAccountMainGroup = dbo.tAccountMainGroup.Id INNER JOIN
                         dbo.tAccountGroup ON dbo.tAccount.idAccountGroup = dbo.tAccountGroup.Id INNER JOIN
                         dbo.tBookTransaction ON dbo.tAccount.Id = dbo.tBookTransaction.idAccountReport
WHERE        (dbo.tBookTransaction.FlagForecast = 1) OR
                         (dbo.tBookTransaction.TypeBookRecord = 0) OR
                         (dbo.tBookTransaction.TypeBookRecord = 1)
GROUP BY dbo.tBookTransaction.TypeBookRecord, YEAR(dbo.tBookTransaction.BookingDate), MONTH(dbo.tBookTransaction.BookingDate), dbo.tBookTransaction.AccountCodeReport, dbo.tBookTransaction.FlagAccountOpening, 
                         dbo.tAccountSection.TitleLocalSection, dbo.tAccountMainGroup.TitleLocalMainGroup, dbo.tAccount.TitleLocalAccount, dbo.tAccountSection.SectionOrder, dbo.tAccountMainGroup.MainGroupOrder, 
                         dbo.tAccountGroup.AccountGroupOrder, dbo.tAccountGroup.TitleLocalAccountGroup, dbo.tBookTransaction.idClient, dbo.tAccount.TypeAccount, dbo.tBookTransaction.FlagForecast
GO
/****** Object:  View [dbo].[repTransactionGroupedByCostCenter]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[repTransactionGroupedByCostCenter]
AS
SELECT        dbo.tBookTransaction.idClient, dbo.tBookTransaction.TypeBookRecord, dbo.tBookTransaction.FlagForecast, YEAR(dbo.tBookTransaction.BookingDate) AS Year, MONTH(dbo.tBookTransaction.BookingDate) AS Month, 
                         dbo.tBookTransaction.CostCenterCode, dbo.tBookTransaction.AccountCodeReport, dbo.tBookTransaction.FlagAccountOpening, SUM(dbo.tBookTransaction.AmountDebit) AS AmountDebitTotal, 
                         SUM(dbo.tBookTransaction.AmountCredit) AS AmountCreditTotal, dbo.tAccount.TypeAccount, dbo.tAccountSection.TitleLocalSection, dbo.tAccountMainGroup.TitleLocalMainGroup, dbo.tAccountGroup.TitleLocalAccountGroup, 
                         dbo.tAccount.TitleLocalAccount, dbo.tAccountSection.SectionOrder, dbo.tAccountMainGroup.MainGroupOrder, dbo.tAccountGroup.AccountGroupOrder
FROM            dbo.tAccountSection INNER JOIN
                         dbo.tAccount ON dbo.tAccountSection.Id = dbo.tAccount.idAccountSection INNER JOIN
                         dbo.tAccountMainGroup ON dbo.tAccount.idAccountMainGroup = dbo.tAccountMainGroup.Id INNER JOIN
                         dbo.tAccountGroup ON dbo.tAccount.idAccountGroup = dbo.tAccountGroup.Id INNER JOIN
                         dbo.tBookTransaction ON dbo.tAccount.Id = dbo.tBookTransaction.idAccountReport
WHERE        (dbo.tBookTransaction.FlagForecast = 1) OR
                         (dbo.tBookTransaction.TypeBookRecord = 0) OR
                         (dbo.tBookTransaction.TypeBookRecord = 1)
GROUP BY dbo.tBookTransaction.TypeBookRecord, YEAR(dbo.tBookTransaction.BookingDate), MONTH(dbo.tBookTransaction.BookingDate), dbo.tBookTransaction.CostCenterCode, dbo.tBookTransaction.AccountCodeReport, 
                         dbo.tBookTransaction.FlagAccountOpening, dbo.tAccountSection.TitleLocalSection, dbo.tAccountMainGroup.TitleLocalMainGroup, dbo.tAccount.TitleLocalAccount, dbo.tAccount.TypeAccount, dbo.tAccountSection.SectionOrder, 
                         dbo.tAccountMainGroup.MainGroupOrder, dbo.tAccountGroup.AccountGroupOrder, dbo.tAccountGroup.TitleLocalAccountGroup, dbo.tBookTransaction.idClient, dbo.tBookTransaction.FlagForecast
GO
/****** Object:  View [dbo].[vAccountAll]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vAccountAll]
AS
SELECT        dbo.tAccount.idClient, dbo.tAccountGroup.TitleLocalAccountGroup AS [Group], dbo.tAccount.AccountCode AS Code, dbo.tAccount.TitleLocalAccount AS [Title local], dbo.tAccount.TitleEnglishAccount AS [Title english], 
                         dbo.tAccount.TypeAccount AS Type, AccountReporting.AccountCode AS [Report Account], dbo.tAccount.FlagPlan AS Planning, dbo.tAccount.Id
FROM            dbo.tAccount LEFT OUTER JOIN
                         dbo.tAccountGroup ON dbo.tAccount.idAccountGroup = dbo.tAccountGroup.Id LEFT OUTER JOIN
                         dbo.tAccount AS AccountReporting ON dbo.tAccount.idAccountReporting = AccountReporting.Id
GO
/****** Object:  View [dbo].[vAccountGroup]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vAccountGroup]
AS
SELECT        dbo.tAccountGroup.idClient, dbo.tAccountMainGroup.TitleLocalMainGroup AS [Title Main Group], dbo.tAccountGroup.TitleLocalAccountGroup AS [Title Local], dbo.tAccountGroup.TitleEnglishAccountGroup AS [Title English], 
                         dbo.tAccountGroup.AccountGroupOrder AS [Account Group Order], dbo.tAccountGroup.AccountCodeFrom AS [Code From], dbo.tAccountGroup.AccountCodeTo AS [Code To], dbo.tAccount.AccountCode AS [Default Reporting Account], 
                         dbo.tAccountGroup.TypeAccountDefault AS [Default Type], dbo.tAccountGroup.Id
FROM            dbo.tAccountGroup INNER JOIN
                         dbo.tAccountMainGroup ON dbo.tAccountGroup.idAccountMainGroup = dbo.tAccountMainGroup.Id LEFT OUTER JOIN
                         dbo.tAccount ON dbo.tAccountGroup.idAccountReportingDefault = dbo.tAccount.Id
GO
/****** Object:  View [dbo].[vAccountMainGroup]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vAccountMainGroup]
AS
SELECT        dbo.tAccountMainGroup.idClient, dbo.tAccountSection.TitleLocalSection AS [Title Section], dbo.tAccountMainGroup.TitleLocalMainGroup AS [Title Local], dbo.tAccountMainGroup.TitleEnglishMainGroup AS [Title English], 
                         dbo.tAccountMainGroup.MainGroupOrder AS [Main Group Order], dbo.tAccountMainGroup.Id
FROM            dbo.tAccountMainGroup INNER JOIN
                         dbo.tAccountSection ON dbo.tAccountMainGroup.idAccountSection = dbo.tAccountSection.Id
GO
/****** Object:  View [dbo].[vAccountPlanning]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vAccountPlanning]
AS
SELECT dbo.tAccount.idClient, dbo.tAccountGroup.TitleLocalAccountGroup AS [Group], dbo.tAccount.AccountCode AS Code, dbo.tAccount.TitleLocalAccount AS [Title local], dbo.tAccount.TitleEnglishAccount AS [Title english], 
                  dbo.tAccount.TypeAccount AS Type, AccountReporting.AccountCode AS [Report Account], dbo.tAccount.FlagPlan AS Planning, dbo.tAccount.Id
FROM     dbo.tAccount LEFT OUTER JOIN
                  dbo.tAccountGroup ON dbo.tAccount.idAccountGroup = dbo.tAccountGroup.Id LEFT OUTER JOIN
                  dbo.tAccount AS AccountReporting ON dbo.tAccount.idAccountReporting = AccountReporting.Id
WHERE  (dbo.tAccount.FlagPlan = 1)
GO
/****** Object:  View [dbo].[vAccountSection]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vAccountSection]
AS
SELECT        idClient, TitleLocalSection AS [Title Local], TitleEnglishSection AS [Title English], TypeAccount AS [Type Account], SectionOrder AS [Section Order], Id
FROM            dbo.tAccountSection
GO
/****** Object:  Table [dbo].[tClient]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tClient](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[TitleClient] [nvarchar](30) NOT NULL,
	[idCurrencyClient] [uniqueidentifier] NOT NULL,
	[FlagTemplate] [bit] NOT NULL,
	[StartOfBusinessYear] [int] NOT NULL,
	[DATEVClientNumber] [int] NULL,
	[IdMigrate] [uniqueidentifier] NULL,
	[idReferenceGroupDefault] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vBookRecord]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vBookRecord]
AS
SELECT        TOP (100) PERCENT dbo.tBookRecord.idClient, dbo.tPlanElement.TitlePlanElement, dbo.tBookRecord.BookingDate, tAccountDebit.AccountCode AS AccountCodeDebit, tAccountDebit.TitleLocalAccount AS AccountTitleDebit, 
                         tAccountCredit.AccountCode AS AccountCodeCredit, tAccountCredit.TitleLocalAccount AS AccountTitleCredit, dbo.tBookRecord.Amount, dbo.tBookRecord.TitleBookRecord, dbo.tCostCenter.CostCenterCode, 
                         dbo.tCostCenter.TitleCostCenter, dbo.tBookRecord.TypeBookRecord, dbo.tBookRecord.BookingDocument, dbo.tBookRecord.ReferenceIDBookRecord, dbo.tBookRecord.BookRecordComment, dbo.tBookRecord.Id
FROM            dbo.tPlanElementInstance RIGHT OUTER JOIN
                         dbo.tPlanElement ON dbo.tPlanElementInstance.idPlanElement = dbo.tPlanElement.Id RIGHT OUTER JOIN
                         dbo.tBookRecord INNER JOIN
                         dbo.tClient ON dbo.tBookRecord.idClient = dbo.tClient.Id INNER JOIN
                         dbo.tAccount AS tAccountCredit ON dbo.tBookRecord.idAccountCredit = tAccountCredit.Id INNER JOIN
                         dbo.tAccount AS tAccountDebit ON dbo.tBookRecord.idAccountDebit = tAccountDebit.Id INNER JOIN
                         dbo.tCostCenter ON dbo.tBookRecord.idCostCenterBookRecord = dbo.tCostCenter.Id ON dbo.tPlanElementInstance.Id = dbo.tBookRecord.idPlanElementInstance
ORDER BY dbo.tPlanElement.TitlePlanElement, dbo.tBookRecord.BookingDate, AccountCodeDebit, AccountCodeCredit
GO
/****** Object:  View [dbo].[vBookTransaction]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vBookTransaction]
AS
SELECT        dbo.tBookTransaction.BookingDate AS [Booking Date], dbo.tBookTransaction.AccountCodeReport AS [Account Report Code], AccountReport.TitleLocalAccount AS [Account Report Title], 
                         AccountReport.TypeAccount AS [Type Account], dbo.tBookTransaction.FlagAccountOpening, dbo.tBookTransaction.CostCenterCode AS [Cost Center Code], dbo.tCostCenter.TitleCostCenter AS [Cost Center Title], 
                         dbo.tBookTransaction.AmountDebit AS [Amount Debit], dbo.tBookTransaction.AmountCredit AS [Amount Credit], dbo.tBookRecord.TitleBookRecord AS [Booking Title], dbo.tBookRecord.BookingDocument AS [Booking Document], 
                         dbo.tBookRecord.ReferenceIDBookRecord AS [Booking Reference], dbo.tBookRecord.BookRecordComment AS [Booking Comment], dbo.tBookTransaction.TypeBookRecord AS [Type Booking Record], 
                         dbo.tPlanElement.TitlePlanElement AS [Plan Element Title], AccountBooking.AccountCode AS [Account Booking Code], AccountBooking.TitleLocalAccount AS [Account Booking Title], 
                         dbo.tBookRecord.AccountCodeDebit AS [Booking Account Debit], dbo.tBookRecord.AccountCodeCredit AS [Booking Account Credit], dbo.tBookRecord.BookingRunCode AS [Booking Run Code], 
                         dbo.tBookRecord.BookingSequenceNum AS [Booking Sequence No], dbo.tBookRecord.DATEVBUCode AS [DATEV BU Code], dbo.tBookTransaction.MonthIndex AS [Month Index], dbo.tBookTransaction.Id, 
                         dbo.tBookTransaction.idClient, dbo.tBookTransaction.idPlan
FROM            dbo.tBookTransaction INNER JOIN
                         dbo.tAccount AS AccountReport ON dbo.tBookTransaction.idAccountReport = AccountReport.Id INNER JOIN
                         dbo.tBookRecord ON dbo.tBookTransaction.idBookingRecord = dbo.tBookRecord.Id INNER JOIN
                         dbo.tAccount AS AccountBooking ON dbo.tBookTransaction.idAccountBooking = AccountBooking.Id LEFT OUTER JOIN
                         dbo.tPlanElement ON dbo.tBookTransaction.idPlanElement = dbo.tPlanElement.Id LEFT OUTER JOIN
                         dbo.tCostCenter ON dbo.tBookTransaction.idCostCenter = dbo.tCostCenter.Id
GO
/****** Object:  Table [dbo].[tCurrency]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tCurrency](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[CurrencyCode] [nvarchar](3) NOT NULL,
	[TitleCurrency] [nvarchar](30) NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vClient]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vClient]
AS
SELECT        dbo.tClient.TitleClient AS Title, dbo.tCurrency.CurrencyCode AS [Currency Code], dbo.tClient.FlagTemplate AS [Flag Template], dbo.tClient.StartOfBusinessYear AS [Start of Business Year], dbo.tClient.DATEVClientNumber, 
                         dbo.tClient.Id
FROM            dbo.tClient INNER JOIN
                         dbo.tCurrency ON dbo.tClient.idCurrencyClient = dbo.tCurrency.Id
GO
/****** Object:  View [dbo].[vCostCenter]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCostCenter]
AS
SELECT idClient, CostCenterCode AS Code, TitleCostCenter AS [Title Local], TitleEnglishCostCenter AS [Title English], FlagProfitCenter AS [Flag Profit Center], DescriptionCostCenter AS Description, Id
FROM     dbo.tCostCenter
GO
/****** Object:  View [dbo].[vCurrency]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCurrency]
AS
SELECT CurrencyCode AS Code, TitleCurrency AS Title, Id
FROM     dbo.tCurrency
GO
/****** Object:  Table [dbo].[tCurrencyExchangeRate]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tCurrencyExchangeRate](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[idPlan] [uniqueidentifier] NULL,
	[idCurrencyExchangeRate] [uniqueidentifier] NOT NULL,
	[DateExchangeRate] [datetime2](7) NOT NULL,
	[RatePerClientCurrency] [float] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vCurrencyExchangeRate]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCurrencyExchangeRate]
AS
SELECT        dbo.tCurrencyExchangeRate.idClient, dbo.tCurrency.CurrencyCode AS [Currency Code], dbo.tCurrencyExchangeRate.DateExchangeRate AS Date, dbo.tCurrencyExchangeRate.RatePerClientCurrency AS Rate, 
                         dbo.tPlan.TitlePlan AS [Plan Title], dbo.tCurrency.TitleCurrency AS [Currency Title], dbo.tCurrencyExchangeRate.Id, dbo.tCurrencyExchangeRate.idPlan
FROM            dbo.tCurrencyExchangeRate INNER JOIN
                         dbo.tCurrency ON dbo.tCurrencyExchangeRate.idCurrencyExchangeRate = dbo.tCurrency.Id LEFT OUTER JOIN
                         dbo.tPlan ON dbo.tCurrencyExchangeRate.idPlan = dbo.tPlan.Id
GO
/****** Object:  Table [dbo].[tDepreciationRule]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tDepreciationRule](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[idAccountActivation] [uniqueidentifier] NOT NULL,
	[idAccountDepreciation] [uniqueidentifier] NULL,
	[TitleDepreciationRule] [nvarchar](50) NOT NULL,
	[NumberOfPeriods] [int] NOT NULL,
	[PeriodInMonths] [int] NOT NULL,
	[TypeDepreciationRule] [smallint] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vDepreciationRule]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDepreciationRule]
AS
SELECT   dbo.tDepreciationRule.idClient, dbo.tDepreciationRule.TitleDepreciationRule AS Title, dbo.tDepreciationRule.TypeDepreciationRule AS Type, AccountActivation.AccountCode AS [Account Activation], AccountDepreciation.AccountCode AS [Account Depreciation], dbo.tDepreciationRule.NumberOfPeriods AS Periods, 
             dbo.tDepreciationRule.PeriodInMonths AS [Months per Period], dbo.tDepreciationRule.Id
FROM     dbo.tDepreciationRule LEFT OUTER JOIN
             dbo.tAccount AS AccountActivation ON dbo.tDepreciationRule.idAccountActivation = AccountActivation.Id LEFT OUTER JOIN
             dbo.tAccount AS AccountDepreciation ON dbo.tDepreciationRule.idAccountDepreciation = AccountDepreciation.Id
GO
/****** Object:  Table [dbo].[tUser]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tUser](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[UserName] [nvarchar](255) NOT NULL,
	[UserLogin] [nvarchar](30) NOT NULL,
	[UserPasswordHash] [nvarchar](48) NOT NULL,
	[idClientDefault] [uniqueidentifier] NOT NULL,
	[TypeUser] [smallint] NOT NULL,
	[DATEVImportFolder] [nvarchar](255) NULL,
	[DataImportFolder] [nvarchar](255) NULL,
	[IdMigrate] [uniqueidentifier] NULL,
	[ApprovalLimit] [int] NULL,
	[UserCode] [varchar](3) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tJobReport]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tJobReport](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[idUser] [uniqueidentifier] NULL,
	[TypeJob] [smallint] NOT NULL,
	[DateJobStart] [datetime2](7) NOT NULL,
	[DateJobEnd] [datetime2](7) NULL,
	[TypeJobSuccess] [smallint] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tJobReportItem]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tJobReportItem](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idJobReport] [uniqueidentifier] NOT NULL,
	[Timestamp] [datetime2](7) NOT NULL,
	[TypeJobSuccess] [smallint] NOT NULL,
	[ResultCode] [int] NOT NULL,
	[ObjectTitle] [nvarchar](255) NULL,
	[ContextInfo] [nvarchar](255) NULL,
	[Message] [nvarchar](255) NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vJobReport]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vJobReport]
AS
SELECT        dbo.tUser.UserName AS [User Name], dbo.tClient.TitleClient AS [Client Name], dbo.tJobReport.DateJobStart AS [Job Start Time], dbo.tJobReport.DateJobEnd AS [Job End Time], dbo.tJobReport.TypeJob AS [Type of Job], 
                         dbo.tJobReport.TypeJobSuccess AS [Job Success], dbo.tJobReportItem.Timestamp AS [Item Timestamp], dbo.tJobReportItem.TypeJobSuccess AS [Item Success], dbo.tJobReportItem.ResultCode AS [Item Result], 
                         dbo.tJobReportItem.ObjectTitle AS Object, dbo.tJobReportItem.ContextInfo AS Context, dbo.tJobReportItem.Message, dbo.tJobReport.idClient, dbo.tJobReport.idUser, dbo.tJobReportItem.idJobReport
FROM            dbo.tJobReport INNER JOIN
                         dbo.tJobReportItem ON dbo.tJobReport.Id = dbo.tJobReportItem.idJobReport INNER JOIN
                         dbo.tClient ON dbo.tJobReport.idClient = dbo.tClient.Id INNER JOIN
                         dbo.tUser ON dbo.tJobReport.idUser = dbo.tUser.Id
GO
/****** Object:  View [dbo].[vPlan]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlan]
AS
SELECT        dbo.tPlan.idClient, dbo.tPlan.TitlePlan AS Title, dbo.tPlan.DateValidFrom AS [Valid From], dbo.tPlan.DateValidTo AS [Valid To], dbo.tPlan.PlanFlagBaseline AS [Flag Baseline], dbo.tPlan.TypeStatus AS Status, 
                         Baseplan.TitlePlan AS [Title Base Plan], dbo.tPlan.Id
FROM            dbo.tPlan LEFT OUTER JOIN
                         dbo.tPlan AS Baseplan ON dbo.tPlan.idPlanBase = Baseplan.Id
GO
/****** Object:  Table [dbo].[tPlanAccountFunction]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlanAccountFunction](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[TypeAccountFunction] [int] NOT NULL,
	[idAccountPlanAccountFunction] [uniqueidentifier] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vPlanAccountFunction]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanAccountFunction]
AS
SELECT        dbo.tPlanAccountFunction.idClient, dbo.tPlanAccountFunction.TypeAccountFunction AS Type, dbo.tAccount.AccountCode AS [Account Code], dbo.tPlanAccountFunction.Id
FROM            dbo.tPlanAccountFunction INNER JOIN
                         dbo.tAccount ON dbo.tPlanAccountFunction.idAccountPlanAccountFunction = dbo.tAccount.Id
GO
/****** Object:  Table [dbo].[tPlanAllocationSchedule]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlanAllocationSchedule](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idPlan] [uniqueidentifier] NOT NULL,
	[TitleAllocationSchedule] [nvarchar](255) NOT NULL,
	[MonthsBetweenItems] [int] NOT NULL,
	[PerpetualRate] [float] NOT NULL,
	[FlagScheduleShared] [bit] NOT NULL,
	[FlagAbsoluteRates] [bit] NOT NULL,
	[AdvanceDelayPeriods] [int] NOT NULL,
	[FlagAuto] [bit] NOT NULL,
	[Period1] [smallint] NULL,
	[Rate1] [float] NULL,
	[Period2] [smallint] NULL,
	[Rate2] [float] NULL,
	[Period3] [smallint] NULL,
	[Rate3] [float] NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vPlanAllocationSchedule]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanAllocationSchedule]
AS
SELECT        idPlan, TitleAllocationSchedule AS Title, PerpetualRate AS [Perpetual Rate], FlagScheduleShared AS [Flag Shared], FlagAbsoluteRates AS [Flag Absolute Rates], AdvanceDelayPeriods AS [Advance Delay], 
                         MonthsBetweenItems AS [Months per Period], FlagAuto AS [Auto Generate], Period1 AS [Period 1], Rate1 AS [Rate 1], Period2 AS [Period 2], Rate2 AS [Rate 2], Period3 AS [Period 3], Rate3 AS [Rate 3], Id
FROM            dbo.tPlanAllocationSchedule
GO
/****** Object:  Table [dbo].[tPlanAllocationScheduleItems]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlanAllocationScheduleItems](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idPlanAllocationSchedule] [uniqueidentifier] NOT NULL,
	[OrderNum] [int] NOT NULL,
	[ItemRate] [float] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vPlanAllocationScheduleItems]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanAllocationScheduleItems]
AS
SELECT TOP (100) PERCENT dbo.tPlanAllocationSchedule.idPlan, dbo.tPlanAllocationSchedule.TitleAllocationSchedule, dbo.tPlanAllocationScheduleItems.OrderNum, dbo.tPlanAllocationScheduleItems.ItemRate, 
                  dbo.tPlanAllocationScheduleItems.Id
FROM     dbo.tPlanAllocationScheduleItems INNER JOIN
                  dbo.tPlanAllocationSchedule ON dbo.tPlanAllocationScheduleItems.idPlanAllocationSchedule = dbo.tPlanAllocationSchedule.Id
ORDER BY dbo.tPlanAllocationSchedule.TitleAllocationSchedule, dbo.tPlanAllocationScheduleItems.OrderNum
GO
/****** Object:  Table [dbo].[tTypeCodeDef]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tTypeCodeDef](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idTypeGroupDef] [uniqueidentifier] NOT NULL,
	[TypeID] [nvarchar](25) NOT NULL,
	[TypeCode] [smallint] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tPlanGroup]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlanGroup](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[TitlePlanGroup] [nvarchar](30) NOT NULL,
	[TitleEnglishPlanGroup] [nvarchar](30) NULL,
	[DescriptionPlanGroup] [nvarchar](max) NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vPlanElement]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanElement]
AS
SELECT        dbo.tPlanElement.idClient, dbo.tPlanElement.TypePlanElement, dbo.tPlanElement.TitlePlanElement, dbo.tCostCenter.CostCenterCode, dbo.tPlanElement.ReferenceIDPlanElement, dbo.tPlanGroup.TitlePlanGroup, 
                         dbo.tCurrency.CurrencyCode, dbo.tPlanElement.Id
FROM            dbo.tPlanElement LEFT OUTER JOIN
                         dbo.tTypeCodeDef ON dbo.tPlanElement.Id = dbo.tTypeCodeDef.Id LEFT OUTER JOIN
                         dbo.tCostCenter ON dbo.tPlanElement.idCostCenterPlanElement = dbo.tCostCenter.Id LEFT OUTER JOIN
                         dbo.tCurrency ON dbo.tPlanElement.idCurrency = dbo.tCurrency.Id LEFT OUTER JOIN
                         dbo.tPlanGroup ON dbo.tPlanElement.idPlanGroup = dbo.tPlanGroup.Id
GO
/****** Object:  Table [dbo].[tPlanInflationRule]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlanInflationRule](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idPlan] [uniqueidentifier] NOT NULL,
	[TitleInflationRule] [nvarchar](30) NOT NULL,
	[InflationInterval] [smallint] NOT NULL,
	[InflationRateAnnual] [float] NOT NULL,
	[InflationRuleComment] [nvarchar](max) NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tPlanParameter]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlanParameter](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idPlan] [uniqueidentifier] NOT NULL,
	[TypePlanParameter] [smallint] NOT NULL,
	[TitlePlanParameter] [nvarchar](30) NOT NULL,
	[ValueNum] [float] NOT NULL,
	[ValueDate] [datetime2](7) NULL,
	[ValueText] [nvarchar](30) NULL,
	[UnitParameter] [nvarchar](15) NULL,
	[PlanParameterComment] [nvarchar](max) NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tPlanElementBooking]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlanElementBooking](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idPlanInstance] [uniqueidentifier] NOT NULL,
	[idAccountDebit] [uniqueidentifier] NOT NULL,
	[idAccountCredit] [uniqueidentifier] NOT NULL,
	[idAllocationSchedule] [uniqueidentifier] NULL,
	[TypeRepeat] [smallint] NOT NULL,
	[idInflationRule] [uniqueidentifier] NULL,
	[idParPrice1] [uniqueidentifier] NULL,
	[idParPrice2] [uniqueidentifier] NULL,
	[NumberOfUnits] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[PriceDate] [datetime2](7) NULL,
	[BudgetFixed] [float] NOT NULL,
	[idParContingencyRate] [uniqueidentifier] NULL,
	[FlagAccountOpening] [bit] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vPlanElementBooking]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanElementBooking]
AS
SELECT        dbo.tPlanElementInstance.idPlan, dbo.tPlan.TitlePlan, dbo.tPlanGroup.TitlePlanGroup AS [Plan Group], dbo.tPlanElement.TitlePlanElement AS Title, dbo.tCostCenter.CostCenterCode AS [Cost Center], 
                         dbo.tPlanElement.ReferenceIDPlanElement AS Reference, AccountDebit.AccountCode AS [Debit Account], AccountCredit.AccountCode AS [Credit Account], dbo.tPlanElementBooking.Price, dbo.tCurrency.CurrencyCode AS Currency, 
                         dbo.tPlanElementInstance.DueDateDay AS [Due Day], dbo.tPlanElementInstance.DueDateMonth AS [Due Month], dbo.tPlanElementInstance.DueDateYear AS [Due Year], dbo.tPlanElement.PlanElementDescription AS Description, 
                         dbo.tPlanElementInstance.FlagDateOffset AS [Due Offset], DueTrigger.TitlePlanParameter AS [Due Trigger], dbo.tPlanElementBooking.TypeRepeat AS Repeat, dbo.tPlanElementInstance.UntilDateDay AS [Until Day], 
                         dbo.tPlanElementInstance.UntilDateMonth AS [Until Month], dbo.tPlanElementInstance.UntilDateYear AS [Until Year], dbo.tPlanAllocationSchedule.TitleAllocationSchedule AS Schedule, 
                         dbo.tPlanElementBooking.NumberOfUnits AS Units, PricePar1.TitlePlanParameter AS [Price Par 1], PricePar2.TitlePlanParameter AS [Price Par 2], ContingencyPar.TitlePlanParameter AS [Contingency Rule], 
                         dbo.tPlanInflationRule.TitleInflationRule AS [Inflation Rule], dbo.tPlanElementBooking.PriceDate AS [Price Date], dbo.tPlanElementBooking.FlagAccountOpening AS [Flag Account Opening], dbo.tPlanElementInstance.Assumptions, 
                         dbo.tPlanElementInstance.Revisions, dbo.tPlanElementBooking.Id
FROM            dbo.tPlanGroup RIGHT OUTER JOIN
                         dbo.tPlanParameter AS PricePar2 RIGHT OUTER JOIN
                         dbo.tPlanInflationRule RIGHT OUTER JOIN
                         dbo.tPlanParameter AS PricePar1 RIGHT OUTER JOIN
                         dbo.tPlanElement INNER JOIN
                         dbo.tPlanElementInstance ON dbo.tPlanElement.Id = dbo.tPlanElementInstance.idPlanElement INNER JOIN
                         dbo.tPlanElementBooking ON dbo.tPlanElementInstance.Id = dbo.tPlanElementBooking.idPlanInstance LEFT OUTER JOIN
                         dbo.tPlan ON dbo.tPlanElementInstance.idPlan = dbo.tPlan.Id ON PricePar1.Id = dbo.tPlanElementBooking.idParPrice1 ON dbo.tPlanInflationRule.Id = dbo.tPlanElementBooking.idInflationRule ON 
                         PricePar2.Id = dbo.tPlanElementBooking.idParPrice2 LEFT OUTER JOIN
                         dbo.tPlanAllocationSchedule ON dbo.tPlanElementBooking.idAllocationSchedule = dbo.tPlanAllocationSchedule.Id LEFT OUTER JOIN
                         dbo.tPlanParameter AS ContingencyPar ON dbo.tPlanElementBooking.idParContingencyRate = ContingencyPar.Id LEFT OUTER JOIN
                         dbo.tPlanParameter AS DueTrigger ON dbo.tPlanElementInstance.idParTriggerDueDate = DueTrigger.Id LEFT OUTER JOIN
                         dbo.tCostCenter ON dbo.tPlanElement.idCostCenterPlanElement = dbo.tCostCenter.Id LEFT OUTER JOIN
                         dbo.tAccount AS AccountDebit ON dbo.tPlanElementBooking.idAccountDebit = AccountDebit.Id LEFT OUTER JOIN
                         dbo.tAccount AS AccountCredit ON dbo.tPlanElementBooking.idAccountCredit = AccountCredit.Id ON dbo.tPlanGroup.Id = dbo.tPlanElement.idPlanGroup LEFT OUTER JOIN
                         dbo.tCurrency ON dbo.tPlanElement.idCurrency = dbo.tCurrency.Id LEFT OUTER JOIN
                         dbo.tReferenceCode ON dbo.tPlanElement.ReferenceIDPlanElement = dbo.tReferenceCode.RefCode
GO
/****** Object:  Table [dbo].[tVATRule]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tVATRule](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[idAccountVATInput] [uniqueidentifier] NOT NULL,
	[idAccountVATOutput] [uniqueidentifier] NOT NULL,
	[idAccountVATBalance] [uniqueidentifier] NULL,
	[VATRuleCode] [nvarchar](5) NULL,
	[TitleVATRule] [nvarchar](50) NOT NULL,
	[RateCurrent] [float] NOT NULL,
	[SettlementTerm] [int] NOT NULL,
	[DateRateChange] [datetime2](7) NULL,
	[RateFuture] [float] NULL,
	[FlagReverseCharge] [bit] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tPlanElementContract]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlanElementContract](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idPlanInstance] [uniqueidentifier] NOT NULL,
	[idAccountMain] [uniqueidentifier] NOT NULL,
	[idAllocationSchedule] [uniqueidentifier] NULL,
	[TypeRepeat] [smallint] NOT NULL,
	[idAccountAdvance] [uniqueidentifier] NULL,
	[idParTriggerAdvance] [uniqueidentifier] NULL,
	[AdvanceDelay] [int] NOT NULL,
	[idDepreciationRule] [uniqueidentifier] NULL,
	[idDepreciationTrigger] [uniqueidentifier] NULL,
	[DepreciationStartDay] [int] NULL,
	[DepreciationStartMonth] [int] NULL,
	[DepreciationStartYear] [int] NULL,
	[DepreciationDelay] [int] NOT NULL,
	[idVATRule] [uniqueidentifier] NULL,
	[idInflationRule] [uniqueidentifier] NULL,
	[idParPrice1] [uniqueidentifier] NULL,
	[idParPrice2] [uniqueidentifier] NULL,
	[PaymentTerm] [int] NOT NULL,
	[NumberOfUnits] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[PriceDate] [datetime2](7) NULL,
	[BudgetFixed] [float] NOT NULL,
	[idParContingencyRate] [uniqueidentifier] NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vPlanElementContract]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanElementContract]
AS
SELECT        dbo.tPlanElementInstance.idPlan, dbo.tPlan.TitlePlan, dbo.tPlanGroup.TitlePlanGroup AS [Plan Group], dbo.tPlanElement.TitlePlanElement AS Title, dbo.tPlanElement.TypePlanElement AS Type, 
                         dbo.tCostCenter.CostCenterCode AS [Cost Center], dbo.tPlanElement.ReferenceIDPlanElement AS Reference, AccountMain.AccountCode AS Account, dbo.tPlanElementContract.Price, dbo.tCurrency.CurrencyCode AS Currency, 
                         dbo.tPlanElementInstance.DueDateDay AS [Due Day], dbo.tPlanElementInstance.DueDateMonth AS [Due Month], dbo.tPlanElementInstance.DueDateYear AS [Due Year], dbo.tPlanElement.PlanElementDescription AS Description, 
                         dbo.tPlanElementInstance.FlagDateOffset AS [Due Offset], DueTrigger.TitlePlanParameter AS [Due Trigger], dbo.tPlanElementContract.TypeRepeat AS Repeat, dbo.tPlanElementInstance.UntilDateDay AS [Until Day], 
                         dbo.tPlanElementInstance.UntilDateMonth AS [Until Month], dbo.tPlanElementInstance.UntilDateYear AS [Until Year], dbo.tPlanAllocationSchedule.TitleAllocationSchedule AS Schedule, dbo.tVATRule.VATRuleCode AS [VAT Rule], 
                         dbo.tPlanElementContract.PaymentTerm AS [Payment Term], dbo.tPlanElementContract.AdvanceDelay AS [Advance Delay], AccountAdvance.AccountCode AS [Advance Account], 
                         AdvanceTrigger.TitlePlanParameter AS [Advance Trigger], dbo.tDepreciationRule.TitleDepreciationRule AS [Depreciation Rule], dbo.tPlanElementContract.DepreciationStartDay AS [Depreciation Start Day], 
                         dbo.tPlanElementContract.DepreciationStartMonth AS [Depreciation Start Month], dbo.tPlanElementContract.DepreciationStartYear AS [Depreciation Start Year], 
                         dbo.tPlanElementContract.DepreciationDelay AS [Depreciation Delay], DepreciationTrigger.TitlePlanParameter AS [Depreciation Trigger], dbo.tPlanElementContract.NumberOfUnits AS Units, 
                         PricePar1.TitlePlanParameter AS [Price Par 1], PricePar2.TitlePlanParameter AS [Price Par 2], ContingencyPar.TitlePlanParameter AS [Contingency Rule], dbo.tPlanInflationRule.TitleInflationRule AS [Inflation Rule], 
                         dbo.tPlanElementContract.PriceDate AS [Price Date], dbo.tPlanElementInstance.Assumptions, dbo.tPlanElementInstance.Revisions, dbo.tPlanElementContract.Id
FROM            dbo.tReferenceCode RIGHT OUTER JOIN
                         dbo.tCostCenter RIGHT OUTER JOIN
                         dbo.tPlan INNER JOIN
                         dbo.tPlanElement INNER JOIN
                         dbo.tPlanElementInstance ON dbo.tPlanElement.Id = dbo.tPlanElementInstance.idPlanElement INNER JOIN
                         dbo.tPlanGroup ON dbo.tPlanElement.idPlanGroup = dbo.tPlanGroup.Id ON dbo.tPlan.Id = dbo.tPlanElementInstance.idPlan ON dbo.tCostCenter.Id = dbo.tPlanElement.idCostCenterPlanElement LEFT OUTER JOIN
                         dbo.tCurrency ON dbo.tPlanElement.idCurrency = dbo.tCurrency.Id ON dbo.tReferenceCode.RefCode = dbo.tPlanElement.ReferenceIDPlanElement FULL OUTER JOIN
                         dbo.tPlanParameter AS DueTrigger ON dbo.tPlanElementInstance.idParTriggerDueDate = DueTrigger.Id FULL OUTER JOIN
                         dbo.tPlanParameter AS ContingencyPar FULL OUTER JOIN
                         dbo.tPlanParameter AS AdvanceTrigger FULL OUTER JOIN
                         dbo.tPlanParameter AS DepreciationTrigger FULL OUTER JOIN
                         dbo.tAccount AS AccountMain INNER JOIN
                         dbo.tPlanElementContract ON AccountMain.Id = dbo.tPlanElementContract.idAccountMain LEFT OUTER JOIN
                         dbo.tAccount AS AccountAdvance ON dbo.tPlanElementContract.idAccountAdvance = AccountAdvance.Id LEFT OUTER JOIN
                         dbo.tVATRule ON dbo.tPlanElementContract.idVATRule = dbo.tVATRule.Id LEFT OUTER JOIN
                         dbo.tDepreciationRule ON dbo.tPlanElementContract.idDepreciationRule = dbo.tDepreciationRule.Id FULL OUTER JOIN
                         dbo.tPlanInflationRule ON dbo.tPlanElementContract.idInflationRule = dbo.tPlanInflationRule.Id FULL OUTER JOIN
                         dbo.tPlanParameter AS PricePar2 ON dbo.tPlanElementContract.idParPrice2 = PricePar2.Id ON DepreciationTrigger.Id = dbo.tPlanElementContract.idDepreciationTrigger ON 
                         AdvanceTrigger.Id = dbo.tPlanElementContract.idParTriggerAdvance FULL OUTER JOIN
                         dbo.tPlanParameter AS PricePar1 ON dbo.tPlanElementContract.idParPrice1 = PricePar1.Id ON ContingencyPar.Id = dbo.tPlanElementContract.idParContingencyRate FULL OUTER JOIN
                         dbo.tPlanAllocationSchedule ON dbo.tPlanElementContract.idAllocationSchedule = dbo.tPlanAllocationSchedule.Id ON dbo.tPlanElementInstance.Id = dbo.tPlanElementContract.idPlanInstance
GO
/****** Object:  Table [dbo].[tPlanElementHR]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlanElementHR](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idPlanInstance] [uniqueidentifier] NOT NULL,
	[idInflationRule] [uniqueidentifier] NULL,
	[idTariff] [uniqueidentifier] NOT NULL,
	[idExpenseGroup] [uniqueidentifier] NOT NULL,
	[StaffName] [nvarchar](50) NULL,
	[Department] [nvarchar](50) NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tPlanHRExpenseGroup]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlanHRExpenseGroup](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idPlan] [uniqueidentifier] NOT NULL,
	[TitleExpenseGroup] [nvarchar](50) NOT NULL,
	[ExpenseGroupDescription] [nvarchar](max) NULL,
	[DateInflationBase] [datetime2](7) NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tPlanHRTariff]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlanHRTariff](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idPlan] [uniqueidentifier] NOT NULL,
	[TitleTariff] [nvarchar](50) NOT NULL,
	[idAccountSalary] [uniqueidentifier] NOT NULL,
	[PayDay] [smallint] NOT NULL,
	[TariffDescription] [nvarchar](max) NULL,
	[FlagShared] [bit] NOT NULL,
	[DateInflationBase] [datetime2](7) NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vPlanElementHR]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanElementHR]
AS
SELECT        dbo.tPlanElementInstance.idPlan, dbo.tPlanGroup.TitlePlanGroup AS [Plan Group], dbo.tPlanElement.TitlePlanElement AS Title, dbo.tPlanElementHR.StaffName AS [Staff Name], dbo.tPlanElementHR.Department, 
                         dbo.tCostCenter.CostCenterCode AS [Cost Center], dbo.tPlanElement.ReferenceIDPlanElement AS Reference, dbo.tPlanElementInstance.DueDateDay AS [Due Day], dbo.tPlanElementInstance.DueDateMonth AS [Due Month], 
                         dbo.tPlanElementInstance.DueDateYear AS [Due Year], dbo.tPlanElement.PlanElementDescription AS Description, dbo.tPlanElementInstance.FlagDateOffset AS [Due Offset], DueTrigger.TitlePlanParameter AS [Due Trigger], 
                         dbo.tPlanElementInstance.UntilDateDay AS [Until Day], dbo.tPlanElementInstance.UntilDateMonth AS [Until Month], dbo.tPlanElementInstance.UntilDateYear AS [Until Year], dbo.tPlanHRTariff.TitleTariff AS Tariff, 
                         dbo.tPlanHRExpenseGroup.TitleExpenseGroup AS [Expense Group], dbo.tPlanInflationRule.TitleInflationRule AS [Inflation Rule], dbo.tCurrency.CurrencyCode AS Currency, dbo.tPlanElementInstance.Assumptions, 
                         dbo.tPlanElementInstance.Revisions, dbo.tPlanElementHR.Id
FROM            dbo.tCostCenter INNER JOIN
                         dbo.tPlanElement INNER JOIN
                         dbo.tPlanElementInstance ON dbo.tPlanElement.Id = dbo.tPlanElementInstance.idPlanElement INNER JOIN
                         dbo.tPlanGroup ON dbo.tPlanElement.idPlanGroup = dbo.tPlanGroup.Id ON dbo.tCostCenter.Id = dbo.tPlanElement.idCostCenterPlanElement RIGHT OUTER JOIN
                         dbo.tPlanHRExpenseGroup INNER JOIN
                         dbo.tPlanElementHR INNER JOIN
                         dbo.tPlanHRTariff ON dbo.tPlanElementHR.idTariff = dbo.tPlanHRTariff.Id ON dbo.tPlanHRExpenseGroup.Id = dbo.tPlanElementHR.idExpenseGroup ON 
                         dbo.tPlanElementInstance.Id = dbo.tPlanElementHR.idPlanInstance LEFT OUTER JOIN
                         dbo.tPlanInflationRule ON dbo.tPlanElementHR.idInflationRule = dbo.tPlanInflationRule.Id LEFT OUTER JOIN
                         dbo.tPlanParameter AS DueTrigger ON dbo.tPlanElementInstance.idParTriggerDueDate = DueTrigger.Id LEFT OUTER JOIN
                         dbo.tReferenceCode ON dbo.tPlanElement.ReferenceIDPlanElement = dbo.tReferenceCode.RefCode LEFT OUTER JOIN
                         dbo.tCurrency ON dbo.tPlanElement.idCurrency = dbo.tCurrency.Id
GO
/****** Object:  View [dbo].[vPlanElementInstances]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanElementInstances]
AS
SELECT        dbo.tPlanElementInstance.Id, dbo.tPlanElementInstance.DateUpdated, dbo.tPlanElement.idClient, dbo.tPlanElementInstance.idPlan, dbo.tPlanElementInstance.idPlanElement, dbo.tPlanElement.idCostCenterPlanElement, 
                         dbo.tPlanElement.idCurrency, dbo.tPlanElement.TypePlanElement, dbo.tPlanElement.idPlanGroup, dbo.tCostCenter.CostCenterCode, dbo.tPlanGroup.TitlePlanGroup, dbo.tPlanElement.TitlePlanElement, 
                         dbo.tPlanElement.ReferenceIDPlanElement, dbo.tPlanElement.ElementFlagBaseline, dbo.tPlanElement.PlanElementDescription, dbo.tPlanElementInstance.FlagUpdate, dbo.tPlanElementInstance.FlagBaseline, 
                         dbo.tPlanElementInstance.FlagDateOffset, dbo.tPlanElementInstance.DueDateYear, dbo.tPlanElementInstance.DueDateMonth, dbo.tPlanElementInstance.DueDateDay, dbo.tPlanElementInstance.UntilDateYear, 
                         dbo.tPlanElementInstance.UntilDateMonth, dbo.tPlanElementInstance.UntilDateDay, dbo.tPlanElementInstance.idParTriggerDueDate, dbo.tPlanElementInstance.Assumptions, dbo.tPlanElementInstance.Revisions
FROM            dbo.tPlanElement INNER JOIN
                         dbo.tPlanElementInstance ON dbo.tPlanElement.Id = dbo.tPlanElementInstance.idPlanElement LEFT OUTER JOIN
                         dbo.tPlanGroup ON dbo.tPlanElement.idPlanGroup = dbo.tPlanGroup.Id LEFT OUTER JOIN
                         dbo.tCostCenter ON dbo.tPlanElement.idCostCenterPlanElement = dbo.tCostCenter.Id
GO
/****** Object:  View [dbo].[vPlanGroup]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanGroup]
AS
SELECT idClient, TitlePlanGroup AS [Title Local], TitleEnglishPlanGroup AS [Title English], DescriptionPlanGroup AS Description, Id
FROM     dbo.tPlanGroup
GO
/****** Object:  Table [dbo].[tPlanHRExpense]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlanHRExpense](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idExpenseGroup] [uniqueidentifier] NOT NULL,
	[DateValidTo] [datetime2](7) NULL,
	[TitleExpense] [nvarchar](50) NOT NULL,
	[idAccountExpense] [uniqueidentifier] NOT NULL,
	[idCostCenterFixed] [uniqueidentifier] NULL,
	[RatioToSalary] [float] NOT NULL,
	[ExpenseAmount] [float] NOT NULL,
	[SalaryCap] [float] NOT NULL,
	[DeductFromSalary] [float] NOT NULL,
	[ApplyToBonusMode] [smallint] NOT NULL,
	[Assumptions] [nvarchar](max) NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vPlanHRExpense]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanHRExpense]
AS
SELECT        dbo.tPlanHRExpenseGroup.idPlan, dbo.tPlanHRExpenseGroup.TitleExpenseGroup AS [Group Title], dbo.tPlanHRExpense.TitleExpense AS [Expense Title], dbo.tPlanHRExpense.DateValidTo AS [Valid To], 
                         dbo.tAccount.AccountCode AS [Account Code], dbo.tCostCenter.CostCenterCode AS [Fixed Cost Center Code], dbo.tPlanHRExpense.RatioToSalary AS [Ratio to Salary], dbo.tPlanHRExpense.ExpenseAmount AS [Expense Amount], 
                         dbo.tPlanHRExpense.SalaryCap AS [Salary Cap], dbo.tPlanHRExpense.DeductFromSalary AS [Deduct from Salary], dbo.tPlanHRExpense.ApplyToBonusMode AS [Bonus Mode], dbo.tPlanHRExpense.Assumptions, 
                         dbo.tPlanHRExpense.Id
FROM            dbo.tPlanHRExpense INNER JOIN
                         dbo.tPlanHRExpenseGroup ON dbo.tPlanHRExpense.idExpenseGroup = dbo.tPlanHRExpenseGroup.Id INNER JOIN
                         dbo.tAccount ON dbo.tPlanHRExpense.idAccountExpense = dbo.tAccount.Id LEFT OUTER JOIN
                         dbo.tCostCenter ON dbo.tPlanHRExpense.idCostCenterFixed = dbo.tCostCenter.Id
GO
/****** Object:  View [dbo].[vPlanHRExpenseGroup]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanHRExpenseGroup]
AS
SELECT        idPlan, TitleExpenseGroup AS Title, ExpenseGroupDescription AS Description, DateInflationBase AS [Inflation Date], Id
FROM            dbo.tPlanHRExpenseGroup
GO
/****** Object:  View [dbo].[vPlanHRTariff]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanHRTariff]
AS
SELECT        dbo.tPlanHRTariff.idPlan, dbo.tPlanHRTariff.TitleTariff AS Title, dbo.tAccount.AccountCode AS [Account Code], dbo.tPlanHRTariff.PayDay AS [Pay Day], dbo.tPlanHRTariff.DateInflationBase AS [Inflation Date], 
                         dbo.tPlanHRTariff.FlagShared AS [Flag Shared], dbo.tPlanHRTariff.TariffDescription AS Description, dbo.tPlanHRTariff.Id
FROM            dbo.tPlanHRTariff INNER JOIN
                         dbo.tAccount ON dbo.tPlanHRTariff.idAccountSalary = dbo.tAccount.Id
GO
/****** Object:  Table [dbo].[tPlanHRTariffDetail]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlanHRTariffDetail](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idTariff] [uniqueidentifier] NOT NULL,
	[DateValidTo] [datetime2](7) NULL,
	[WorkTimeWeekly] [smallint] NOT NULL,
	[FTEFactor] [float] NOT NULL,
	[RatioShiftNight] [float] NOT NULL,
	[RatioShiftSpecial] [float] NOT NULL,
	[RatioOvertime] [float] NOT NULL,
	[AnnualLeave] [smallint] NOT NULL,
	[StandardHolidays] [smallint] NOT NULL,
	[BaseSalaryMonthly] [float] NOT NULL,
	[RateShiftNight] [float] NOT NULL,
	[RateShiftSpecial] [float] NOT NULL,
	[RateOvertime] [float] NOT NULL,
	[RateAnnualBonus] [float] NULL,
	[AnnualBonusMonth] [smallint] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vPlanHRTariffDetail]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanHRTariffDetail]
AS
SELECT        dbo.tPlanHRTariff.idPlan, dbo.tPlanHRTariff.TitleTariff AS [Tariff Title], dbo.tPlanHRTariffDetail.DateValidTo AS [Valid To], dbo.tPlanHRTariffDetail.WorkTimeWeekly AS [Work Hours per Week], 
                         dbo.tPlanHRTariffDetail.FTEFactor AS [FTE Factor], dbo.tPlanHRTariffDetail.RatioShiftNight AS [Ratio Night Shift], dbo.tPlanHRTariffDetail.RatioShiftSpecial AS [Ratio Special Shift], 
                         dbo.tPlanHRTariffDetail.RatioOvertime AS [Ratio Overtime], dbo.tPlanHRTariffDetail.AnnualLeave AS [Annual Days Leave], dbo.tPlanHRTariffDetail.StandardHolidays AS [Annual Holidays], 
                         dbo.tPlanHRTariffDetail.BaseSalaryMonthly AS [Base Salary per Month], dbo.tPlanHRTariffDetail.RateShiftNight AS [Rate Add Night Shift], dbo.tPlanHRTariffDetail.RateShiftSpecial AS [Rate Add Special Shift], 
                         dbo.tPlanHRTariffDetail.RateOvertime AS [Rate Overtime], dbo.tPlanHRTariffDetail.RateAnnualBonus AS [Rate Annual Bonus], dbo.tPlanHRTariffDetail.AnnualBonusMonth AS [Bonus Month], dbo.tPlanHRTariffDetail.Id
FROM            dbo.tPlanHRTariffDetail INNER JOIN
                         dbo.tPlanHRTariff ON dbo.tPlanHRTariffDetail.idTariff = dbo.tPlanHRTariff.Id
GO
/****** Object:  View [dbo].[vPlanInflationRule]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanInflationRule]
AS
SELECT idPlan, TitleInflationRule AS Title, InflationInterval AS [Interval in Months], InflationRateAnnual AS [Rate Annual], InflationRuleComment AS Description, Id
FROM     dbo.tPlanInflationRule
GO
/****** Object:  View [dbo].[vPlanParameterContingency]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanParameterContingency]
AS
SELECT idPlan, TypePlanParameter, TitlePlanParameter AS Title, ValueNum AS Rate, PlanParameterComment AS Description, Id
FROM     dbo.tPlanParameter
WHERE  (TypePlanParameter = 20)
GO
/****** Object:  View [dbo].[vPlanParameterDate]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanParameterDate]
AS
SELECT idPlan, TitlePlanParameter AS Title, ValueDate AS Date, PlanParameterComment AS Description, Id
FROM     dbo.tPlanParameter
WHERE  (TypePlanParameter = 10)
GO
/****** Object:  View [dbo].[vPlanParameterPriceFactor]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPlanParameterPriceFactor]
AS
SELECT idPlan, TitlePlanParameter AS Title, ValueNum AS Value, PlanParameterComment AS Description, Id
FROM     dbo.tPlanParameter
WHERE  (TypePlanParameter = 0)
GO
/****** Object:  View [dbo].[vReferenceCode]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vReferenceCode]
AS
SELECT        dbo.tReferenceCode.idClient, dbo.tReferenceGroup.TitleReferenceGroup AS [Group], dbo.tReferenceCode.RefCode AS Code, dbo.tReferenceCode.TitleRefCode AS Title, dbo.tReferenceCode.RefCodeComment AS Description, 
                         dbo.tReferenceCode.FlagActive, dbo.tReferenceCode.Id
FROM            dbo.tReferenceCode INNER JOIN
                         dbo.tReferenceGroup ON dbo.tReferenceCode.idReferenceGroup = dbo.tReferenceGroup.Id
GO
/****** Object:  View [dbo].[vReferenceGroup]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vReferenceGroup]
AS
SELECT        idClient, TitleReferenceGroup AS Title, TypeReferenceGroup AS Type, BaseCode AS [Base Code], NextNum AS [Next Num], FlagAutoGen AS [Flag Auto], AutoDigits AS [Auto Digits], Id
FROM            dbo.tReferenceGroup
GO
/****** Object:  Table [dbo].[tTypeGroupDef]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tTypeGroupDef](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[TypeGroupID] [nvarchar](25) NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vTypeCodeDef]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vTypeCodeDef]
AS
SELECT        dbo.tTypeGroupDef.TypeGroupID AS [Group ID], dbo.tTypeCodeDef.TypeID AS [Type ID], dbo.tTypeCodeDef.TypeCode AS [Type Code], dbo.tTypeCodeDef.Id
FROM            dbo.tTypeCodeDef INNER JOIN
                         dbo.tTypeGroupDef ON dbo.tTypeCodeDef.idTypeGroupDef = dbo.tTypeGroupDef.Id
GO
/****** Object:  View [dbo].[vTypeGroupDef]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vTypeGroupDef]
AS
SELECT        TypeGroupID, Id
FROM            dbo.tTypeGroupDef
GO
/****** Object:  View [dbo].[vUser]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vUser]
AS
SELECT        dbo.tUser.UserName AS [User Name], dbo.tUser.UserLogin AS [User Login], dbo.tUser.UserPasswordHash AS [User Password Hash], dbo.tClient.TitleClient AS [Client Title], dbo.tUser.TypeUser AS [User Type], 
                         dbo.tUser.DATEVImportFolder, dbo.tUser.DataImportFolder, dbo.tUser.idClientDefault, dbo.tUser.Id
FROM            dbo.tUser INNER JOIN
                         dbo.tClient ON dbo.tUser.idClientDefault = dbo.tClient.Id
GO
/****** Object:  View [dbo].[vVATRule]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vVATRule]
AS
SELECT dbo.tVATRule.idClient, dbo.tVATRule.VATRuleCode AS Code, dbo.tVATRule.TitleVATRule AS Title, AccountVATInput.AccountCode AS [Account VAT In], AccountVATOutput.AccountCode AS [Account VAT Out], 
                  AccountVATBalance.AccountCode AS [Account VAT Settlement], dbo.tVATRule.Id, dbo.tVATRule.RateCurrent AS [Rate Current], dbo.tVATRule.SettlementTerm AS [Settlement Term], 
                  dbo.tVATRule.DateRateChange AS [Date Rate Change], dbo.tVATRule.RateFuture AS [Rate Future], dbo.tVATRule.FlagReverseCharge AS [Flag Reverse Charge]
FROM     dbo.tVATRule LEFT OUTER JOIN
                  dbo.tAccount AS AccountVATInput ON dbo.tVATRule.idAccountVATInput = AccountVATInput.Id LEFT OUTER JOIN
                  dbo.tAccount AS AccountVATOutput ON dbo.tVATRule.idAccountVATOutput = AccountVATOutput.Id LEFT OUTER JOIN
                  dbo.tAccount AS AccountVATBalance ON dbo.tVATRule.idAccountVATBalance = AccountVATBalance.Id
GO
/****** Object:  View [dbo].[repFinancialReportForecast]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[repFinancialReportForecast]
AS
SELECT        TypeAccount, SectionOrder, MainGroupOrder, AccountGroupOrder, TitleLocalSection, TitleLocalMainGroup, TitleLocalAccountGroup, CostCenterCode, Year, CASE WHEN CostCenterCode = NULL 
                         THEN 'Admin' WHEN CostCenterCode = 'C1000' THEN 'Admin' WHEN CostCenterCode = 'C1500' THEN 'Admin' WHEN CostCenterCode = 'C4000' THEN 'Admin' WHEN CostCenterCode = 'C2000' THEN 'Engineering' WHEN CostCenterCode
                          = 'P0001' THEN 'Engineering' ELSE 'R&D' END AS Bereich, SUM(AmountCreditTotal - AmountDebitTotal) AS AmountTotal
FROM            dbo.repTransactionGroupedByCostCenter
WHERE        (FlagForecast = 1) AND (FlagAccountOpening = 0)
GROUP BY TypeAccount, SectionOrder, MainGroupOrder, AccountGroupOrder, TitleLocalSection, TitleLocalMainGroup, TitleLocalAccountGroup, CostCenterCode, Year
GO
/****** Object:  Table [dbo].[tApproval]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tApproval](
	[Id] [uniqueidentifier] NOT NULL,
	[ApproverOneEmail] [nvarchar](100) NULL,
	[ApproverOneStatus] [nvarchar](7) NULL,
	[ApproverOneNote] [text] NULL,
	[ApproverOneTime] [nvarchar](20) NULL,
	[ApproverTwoEmail] [nvarchar](100) NULL,
	[ApproverTwoStatus] [nvarchar](7) NULL,
	[ApproverTwoNote] [text] NULL,
	[ApproverTwoTime] [nvarchar](20) NULL,
	[ApproverThreeEmail] [nvarchar](100) NULL,
	[ApproverThreeStatus] [nvarchar](7) NULL,
	[ApproverThreeNote] [text] NULL,
	[ApproverThreeTime] [nvarchar](20) NULL,
	[ApproverItemLink] [text] NULL,
	[DocumentNumber] [nvarchar](15) NULL,
	[ApprovalAmount] [float] NULL,
	[ApprovalDate] [nvarchar](20) NULL,
	[ApprovalFinal] [nvarchar](7) NULL,
	[ApproverOneRequestDate] [nvarchar](20) NULL,
	[ApproverTwoRequestDate] [nvarchar](20) NULL,
	[ApproverThreeRequestDate] [nvarchar](20) NULL,
	[ApprovalSourceSystem] [nvarchar](50) NULL,
	[ApprovalObject] [nvarchar](50) NULL,
	[idSellerPurchaser] [uniqueidentifier] NULL,
	[idBudgetResponsible] [uniqueidentifier] NULL,
	[idExecutiveApprover] [uniqueidentifier] NULL,
	[CostCenterCode] [nvarchar](12) NULL,
	[RefCode] [nvarchar](12) NULL,
	[DateCreated] [datetime2](7) NULL,
	[DateUpdated] [datetime2](7) NULL,
	[IdMigration] [uniqueidentifier] NULL,
	[IdMigrate] [uniqueidentifier] NULL,
	[IdClient] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tBusinessCentralApproval] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tApproval_Temp]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tApproval_Temp](
	[Id] [uniqueidentifier] NOT NULL,
	[ApproverOneEmail] [nvarchar](100) NULL,
	[ApproverOneStatus] [nvarchar](7) NULL,
	[ApproverOneNote] [text] NULL,
	[ApproverOneTime] [nvarchar](20) NULL,
	[ApproverTwoEmail] [nvarchar](100) NULL,
	[ApproverTwoStatus] [nvarchar](7) NULL,
	[ApproverTwoNote] [text] NULL,
	[ApproverTwoTime] [nvarchar](20) NULL,
	[ApproverThreeEmail] [nvarchar](100) NULL,
	[ApproverThreeStatus] [nvarchar](7) NULL,
	[ApproverThreeNote] [text] NULL,
	[ApproverThreeTime] [nvarchar](20) NULL,
	[ApproverItemLink] [text] NULL,
	[DocumentNumber] [nvarchar](15) NULL,
	[ApprovalAmount] [float] NULL,
	[ApprovalDate] [nvarchar](20) NULL,
	[ApprovalFinal] [nvarchar](7) NULL,
	[ApproverOneRequestDate] [nvarchar](20) NULL,
	[ApproverTwoRequestDate] [nvarchar](20) NULL,
	[ApproverThreeRequestDate] [nvarchar](20) NULL,
	[ApprovalSourceSystem] [nvarchar](50) NULL,
	[ApprovalObject] [nvarchar](50) NULL,
	[idSellerPurchaser] [uniqueidentifier] NULL,
	[idBudgetResponsible] [uniqueidentifier] NULL,
	[idExecutiveApprover] [uniqueidentifier] NULL,
	[CostCenterCode] [nvarchar](12) NULL,
	[RefCode] [nvarchar](12) NULL,
	[DateCreated] [datetime2](7) NULL,
	[DateUpdated] [datetime2](7) NULL,
	[IdMigration] [uniqueidentifier] NULL,
	[IdMigrate] [uniqueidentifier] NULL,
	[IdClient] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tBusinessCentralApproval_Temp] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tAuthority]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tAuthority](
	[Id] [uniqueidentifier] NOT NULL,
	[idUser] [uniqueidentifier] NOT NULL,
	[ApprovalLimit] [int] NULL,
	[CostCenter] [nvarchar](7) NULL,
	[RefCode] [nvarchar](12) NULL,
	[UserRole] [smallint] NULL,
	[IdMigrate] [uniqueidentifier] NULL,
	[IdClient] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tBookingRun]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tBookingRun](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[BookingRunCode] [nvarchar](30) NOT NULL,
	[PeriodYear] [int] NOT NULL,
	[PeriodMonth] [smallint] NOT NULL,
	[SerialNum] [nvarchar](10) NOT NULL,
	[VersionCode] [smallint] NOT NULL,
	[StatusPreliminary] [bit] NOT NULL,
	[BookingRunTitle] [nvarchar](100) NULL,
	[ImportFileName] [nvarchar](255) NOT NULL,
	[ImportFileDate] [datetime2](7) NOT NULL,
	[ImportedDate] [datetime2](7) NOT NULL,
	[RecordsImported] [int] NOT NULL,
	[RecordsOmitted] [int] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tPlanTransaction]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPlanTransaction](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idPlan] [uniqueidentifier] NOT NULL,
	[idBookTransaction] [uniqueidentifier] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tSession]    Script Date: 07-Feb-24 10:16:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tSession](
	[Id] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateUpdated] [datetime2](7) NULL,
	[idUser] [uniqueidentifier] NOT NULL,
	[idClient] [uniqueidentifier] NOT NULL,
	[IdMigrate] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'02d95236-a5b4-477b-8b5f-0191b124bc2b', N'nseifert@saperatec.de', N'Approve', NULL, N'2023-11-14T08:35:23Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-14T16:10:05Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgAzADM%3d', N'ERV23-1633', 37.38, N'2023-11-14T16:10:05Z', N'Yes', N'2023-11-14T08:33:10Z', N'2023-11-14T08:35:28Z', NULL, N'Business Central', N'Purchase Invoice', N'05042b18-5709-4b63-b502-93a6b72da5c2', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'C4000', N'C4000202', CAST(N'2023-11-14T08:33:08.0000000' AS DateTime2), CAST(N'2023-11-14T16:10:11.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'41e24851-9ea7-4cdd-9d88-02534a5a24ff', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-09T12:57:32Z', N'skernbaum@saperatec.de', N'Approve', NULL, N'2023-11-10T12:31:32Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA2ADE%3d', N'ERV23-1661', 100, N'2023-11-10T12:31:32Z', N'Yes', N'2023-11-09T12:38:07Z', N'2023-11-09T12:57:35Z', NULL, N'Business Central', N'Purchase Invoice', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', NULL, N'C1500', N'C1500204', CAST(N'2023-11-09T12:38:05.0000000' AS DateTime2), CAST(N'2023-11-10T12:31:34.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'5fbcaa87-5fa5-4cc1-b40c-030b17c95b42', N'rrothkamm@saperatec.de', N'Approve', NULL, N'2023-11-10T10:46:44Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-12T19:58:00Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA0ADk%3d', N'ERV23-1649', 52.94, N'2023-11-12T19:58:00Z', N'Yes', N'2023-11-09T09:05:57Z', N'2023-11-10T10:46:47Z', NULL, N'Business Central', N'Purchase Invoice', N'750c0eb3-6462-40e1-85dc-f38d6448a65c', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'C1000', N'C1000301', CAST(N'2023-11-09T09:05:54.0000000' AS DateTime2), CAST(N'2023-11-12T19:58:01.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'2a37e810-6188-485e-a02f-058bcf93f719', N'bwindus@saperatec.de', N'Approve', NULL, N'2023-11-14T08:45:45Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA3ADg%3d', N'ERV23-1678', 686.95, N'2023-11-14T08:45:45Z', N'Yes', N'2023-11-14T08:29:35Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'5715eaa3-a0e2-48ca-bf81-82636a806399', NULL, NULL, N'C1000', N'C1000225', CAST(N'2023-11-14T08:29:34.0000000' AS DateTime2), CAST(N'2023-11-14T08:45:48.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'16c920dd-cc3f-44fd-ac03-08ad126674ba', N'nseifert@saperatec.de', N'Approve', NULL, N'2023-11-15T07:42:44Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA5ADM%3d', N'ERV23-1693', 34.18, N'2023-11-15T07:42:44Z', N'Yes', N'2023-11-15T07:40:34Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'05042b18-5709-4b63-b502-93a6b72da5c2', NULL, NULL, N'C1000', N'C1000205', CAST(N'2023-11-15T07:40:24.0000000' AS DateTime2), CAST(N'2023-11-15T07:42:46.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'c49ba81a-8095-4808-83e3-098bcebcfa7a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ERV23-1566', 18803.17, NULL, N'Pending', NULL, NULL, NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', NULL, NULL, N'P0001', N'P0001N04', CAST(N'2023-11-09T08:08:55.0000000' AS DateTime2), CAST(N'2023-11-09T08:08:55.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'f17993a9-4340-463c-820b-0bbc72f62b10', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-15T13:57:00Z', N'lstock@saperatec.de', N'Approve', NULL, N'2023-11-15T18:25:46Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=50&bookmark=37%3bJgAAAACLAQAAAAJ7%2f0UAQgBTADIAMwAtADAAMQA4ADY%3d', N'EBS23-0186', 1397.5, N'2023-11-15T18:25:46Z', N'Yes', N'2023-11-14T08:45:45Z', N'2023-11-15T13:57:02Z', NULL, N'Business Central', N'Purchase Order', N'b5572063-6304-482c-8f38-2ba978188d7c', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', NULL, N'C5000', N'C5000300', CAST(N'2023-11-14T08:45:42.0000000' AS DateTime2), CAST(N'2023-11-15T18:25:48.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'1e9bc2e5-a1b3-46cc-ac74-0db39b9890e9', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-15T13:56:23Z', N'lstock@saperatec.de', N'Approve', NULL, N'2023-11-15T18:26:06Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA5ADg%3d', N'ERV23-1698', 2418, N'2023-11-15T18:26:06Z', N'Yes', N'2023-11-15T12:43:30Z', N'2023-11-15T13:56:27Z', NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', NULL, N'C5000', N'C5000300', CAST(N'2023-11-15T12:43:25.0000000' AS DateTime2), CAST(N'2023-11-15T18:26:10.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'ea63f1d5-c3e3-4467-83b1-12048abbd878', N'lstock@saperatec.de', N'Approve', NULL, N'2023-11-13T14:17:32Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-14T16:10:39Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA3ADE%3d', N'ERV23-1671', 15.12, N'2023-11-14T16:10:39Z', N'Yes', N'2023-11-13T13:11:29Z', N'2023-11-13T14:17:36Z', NULL, N'Business Central', N'Purchase Invoice', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'C1000', N'C1000301', CAST(N'2023-11-13T13:11:24.0000000' AS DateTime2), CAST(N'2023-11-14T16:10:54.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'49f73237-f93c-4bc3-9932-1757ed7c0d97', N'rrothkamm@saperatec.de', N'Approve', NULL, N'2023-11-10T10:58:46Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-12T19:57:51Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgAzADg%3d', N'ERV23-1638', 15.95, N'2023-11-12T19:57:51Z', N'Yes', N'2023-11-10T10:58:29Z', N'2023-11-10T10:58:49Z', NULL, N'Business Central', N'Purchase Invoice', N'750c0eb3-6462-40e1-85dc-f38d6448a65c', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'C1000', N'C1000223', CAST(N'2023-11-10T10:58:28.0000000' AS DateTime2), CAST(N'2023-11-12T19:57:52.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'72091af9-60f8-45e2-a84b-176753fbd23c', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-10T11:20:43Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=50&bookmark=37%3bJgAAAACLAQAAAAJ7%2f0UAQgBTADIAMwAtADAAMQA4ADI%3d', N'EBS23-0182', 967.1, N'2023-11-10T11:20:43Z', N'Yes', N'2023-11-10T10:51:17Z', NULL, NULL, N'Business Central', N'Purchase Order', N'b5572063-6304-482c-8f38-2ba978188d7c', NULL, NULL, N'C5000', N'C5000350', CAST(N'2023-11-10T10:51:16.0000000' AS DateTime2), CAST(N'2023-11-10T11:20:45.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'5dbb372e-d3c1-4d64-9208-255c89117fca', N'rrothkamm@saperatec.de', N'Approve', NULL, N'2023-11-10T10:45:32Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-12T19:58:16Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA1ADQ%3d', N'ERV23-1654', 18.38, N'2023-11-12T19:58:16Z', N'Yes', N'2023-11-09T12:06:53Z', N'2023-11-10T10:45:37Z', NULL, N'Business Central', N'Purchase Invoice', N'750c0eb3-6462-40e1-85dc-f38d6448a65c', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'C1000', N'C1000301', CAST(N'2023-11-09T12:06:51.0000000' AS DateTime2), CAST(N'2023-11-12T19:58:17.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'3f3de181-f480-4f79-bf7e-286d578de384', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-10T07:11:18Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-10T07:11:18Z', N'skernbaum@saperatec.de', N'Approve', NULL, N'2023-11-10T12:28:44Z', N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANQA1ADc%3d', N'ERV23-1557', 160000, N'2023-11-10T12:28:44Z', N'Yes', N'2023-11-09T14:03:46Z', N'2023-11-10T07:11:23Z', NULL, N'Business Central', N'Purchase Invoice', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'P0021', N'P0021203', CAST(N'2023-11-09T14:03:37.0000000' AS DateTime2), CAST(N'2023-11-10T12:28:46.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'2937e387-f1eb-4398-a48b-2e8bb9711b65', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-09T08:04:07Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-09T08:04:07Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANQA1ADc%3d', N'ERV23-1557', 160000, N'2023-11-09T08:04:07Z', N'Pending', N'2023-11-09T08:03:30Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, NULL, N'P0021', N'P0021203', CAST(N'2023-11-09T08:03:20.0000000' AS DateTime2), CAST(N'2023-11-09T08:04:11.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'd7e8c8e9-b504-4f7e-bf88-30ffa3950974', N'lstock@saperatec.de', N'Approve', NULL, N'2023-11-13T14:17:46Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA2ADk%3d', N'ERV23-1669', 1377.62, N'2023-11-13T14:17:46Z', N'Yes', N'2023-11-13T12:30:45Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', NULL, NULL, N'P0001', N'P0001P07', CAST(N'2023-11-13T12:30:40.0000000' AS DateTime2), CAST(N'2023-11-13T14:17:47.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'c8fdbd71-9ca7-4fc4-be36-398b5e428f50', N'nseifert@saperatec.de', N'Approve', NULL, N'2023-11-09T10:55:46Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA1ADY%3d', N'ERV23-1656', 10.22, N'2023-11-09T10:55:46Z', N'Yes', N'2023-11-09T10:53:08Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'05042b18-5709-4b63-b502-93a6b72da5c2', NULL, NULL, N'C1000', N'C1000205', CAST(N'2023-11-09T10:53:04.0000000' AS DateTime2), CAST(N'2023-11-09T10:55:48.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'bf6cd06f-0b92-49eb-a2e0-3fbddc12befa', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-10T12:29:36Z', N'lstock@saperatec.de', N'Approve', NULL, N'2023-11-13T11:03:20Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-14T16:10:57Z', N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=50&bookmark=37%3bJgAAAACLAQAAAAJ7%2f0UAQgBTADIAMwAtADAAMQA2ADA%3d', N'EBS23-0160', 22350, N'2023-11-14T16:10:57Z', N'Yes', N'2023-11-10T11:32:39Z', N'2023-11-10T12:29:39Z', N'2023-11-13T11:03:27Z', N'Business Central', N'Purchase Order', N'b5572063-6304-482c-8f38-2ba978188d7c', N'154e58cd-8c39-4620-a48b-88bc02966835', N'f1b06869-f152-464c-8cac-3414a7cf55fa', N'C5000', N'C5000300', CAST(N'2023-11-10T11:32:36.0000000' AS DateTime2), CAST(N'2023-11-14T16:11:06.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'47d4c77d-d708-42c6-ad3b-40f0518cfeab', N'cfriedrich@saperatec.de', N'Approve', NULL, N'2023-11-15T13:15:17Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA5ADQ%3d', N'ERV23-1694', 10.88, N'2023-11-15T13:15:17Z', N'Yes', N'2023-11-15T13:04:18Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'23659c75-6839-4a6f-8e61-5fd9699b2a72', NULL, NULL, N'C1000', N'C1000205', CAST(N'2023-11-15T13:04:16.0000000' AS DateTime2), CAST(N'2023-11-15T13:15:19.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'71344a7f-a47a-427f-a925-44da137f8da1', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-10T12:30:04Z', N'lstock@saperatec.de', N'Approve', NULL, N'2023-11-13T11:04:13Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA1ADM%3d', N'ERV23-1653', 6298.78, N'2023-11-13T11:04:13Z', N'Yes', N'2023-11-10T11:39:35Z', N'2023-11-10T12:30:08Z', NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', NULL, N'C5000', N'C5000500', CAST(N'2023-11-10T11:39:33.0000000' AS DateTime2), CAST(N'2023-11-13T11:04:16.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'7d976683-6ff4-4422-b49c-44facccbd821', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'EBS23-0179', 2418, NULL, N'Pending', NULL, NULL, NULL, N'Business Central', N'Purchase Order', N'b5572063-6304-482c-8f38-2ba978188d7c', NULL, NULL, N'C5000', N'C5000300', CAST(N'2023-11-09T06:31:48.0000000' AS DateTime2), CAST(N'2023-11-09T06:31:48.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'7d976783-6ff4-4322-b49c-44fadccbd821', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ERV23-1562', 22668, NULL, N'Pending', NULL, NULL, NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', NULL, NULL, N'P0001', N'P0001A04', CAST(N'2023-11-09T07:33:38.0000000' AS DateTime2), CAST(N'2023-11-09T07:33:38.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'f297b470-5915-4446-a8ca-461254101b54', N'rrothkamm@saperatec.de', N'Approve', NULL, N'2023-11-10T10:46:03Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-12T19:58:07Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA1ADE%3d', N'ERV23-1651', 15.12, N'2023-11-12T19:58:07Z', N'Yes', N'2023-11-09T10:16:36Z', N'2023-11-10T10:46:07Z', NULL, N'Business Central', N'Purchase Invoice', N'750c0eb3-6462-40e1-85dc-f38d6448a65c', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'C1000', N'C1000301', CAST(N'2023-11-09T10:16:34.0000000' AS DateTime2), CAST(N'2023-11-12T19:58:09.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'f10a5901-d114-46e9-bb9f-468e5898a7e3', N'nseifert@saperatec.de', N'Approve', NULL, N'2023-11-15T09:22:58Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA3ADk%3d', N'ERV23-1679', 15.14, N'2023-11-15T09:22:58Z', N'Yes', N'2023-11-15T08:20:14Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'05042b18-5709-4b63-b502-93a6b72da5c2', NULL, NULL, N'C1000', N'C1000205', CAST(N'2023-11-15T08:20:12.0000000' AS DateTime2), CAST(N'2023-11-15T09:23:00.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'7514acba-3826-4d69-8ec2-46eab513fc92', N'lstock@saperatec.de', N'Approve', NULL, N'2023-11-09T15:59:50Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA2ADM%3d', N'ERV23-1663', 1500, N'2023-11-09T15:59:50Z', N'Yes', N'2023-11-09T13:11:05Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', NULL, NULL, N'P0001', N'P0001B09', CAST(N'2023-11-09T13:11:02.0000000' AS DateTime2), CAST(N'2023-11-09T15:59:51.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'ed4a3e8d-7d43-45ad-b16e-49bf4dd833d8', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-10T09:13:37Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA2ADY%3d', N'ERV23-1666', 252, N'2023-11-10T09:13:37Z', N'Yes', N'2023-11-10T09:09:47Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', NULL, NULL, N'P0001', N'P0001B11', CAST(N'2023-11-10T09:09:45.0000000' AS DateTime2), CAST(N'2023-11-10T09:13:40.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'54731094-6300-4a71-a4ff-4a4b4e1c1b36', N'nseifert@saperatec.de', N'Approve', NULL, N'2023-11-15T06:21:05Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA5ADE%3d', N'ERV23-1691', 10.9, N'2023-11-15T06:21:05Z', N'Yes', N'2023-11-14T14:51:20Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'05042b18-5709-4b63-b502-93a6b72da5c2', NULL, NULL, N'C1000', N'C1000223', CAST(N'2023-11-14T14:51:15.0000000' AS DateTime2), CAST(N'2023-11-15T06:21:07.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'6e4b9f5b-abad-4425-aa58-4aaf0ea17eb1', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-15T13:57:08Z', N'lstock@saperatec.de', N'Approve', NULL, N'2023-11-15T18:25:04Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=50&bookmark=37%3bJgAAAACLAQAAAAJ7%2f0UAQgBTADIAMwAtADAAMQAzADg%3d', N'EBS23-0138', 11817.68, N'2023-11-15T18:25:04Z', N'Yes', N'2023-11-13T13:46:20Z', N'2023-11-15T13:57:11Z', NULL, N'Business Central', N'Purchase Order', N'b5572063-6304-482c-8f38-2ba978188d7c', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', NULL, N'P0001', N'P0001N10', CAST(N'2023-11-13T13:46:17.0000000' AS DateTime2), CAST(N'2023-11-15T18:25:12.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'bfb6d65e-1e09-4739-86b7-4dbc204ff62e', N'nseifert@saperatec.de', N'Approve', NULL, N'2023-11-13T14:02:26Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA3ADQ%3d', N'ERV23-1674', 31.01, N'2023-11-13T14:02:26Z', N'Yes', N'2023-11-13T13:58:53Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'05042b18-5709-4b63-b502-93a6b72da5c2', NULL, NULL, N'C1000', N'C1000223', CAST(N'2023-11-13T13:58:50.0000000' AS DateTime2), CAST(N'2023-11-13T14:02:28.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'6490198b-b02b-4048-ba00-508ca5a803ff', N'lstock@saperatec.de', N'Approve', NULL, N'2023-11-14T12:25:03Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-14T16:09:10Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA3ADk%3d', N'ERV23-1679', 15.62, N'2023-11-14T16:09:10Z', N'Yes', N'2023-11-14T08:12:00Z', N'2023-11-14T12:25:06Z', NULL, N'Business Central', N'Purchase Invoice', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'C1000', N'C1000205', CAST(N'2023-11-14T08:11:57.0000000' AS DateTime2), CAST(N'2023-11-14T16:09:19.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'3b177503-9cf3-48f8-a1e7-50fc56c568c4', N'rrothkamm@saperatec.de', N'Approve', NULL, N'2023-11-10T10:59:24Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-12T19:57:34Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA1ADQ%3d', N'ERV23-1654', 18.38, N'2023-11-12T19:57:34Z', N'Yes', N'2023-11-10T10:59:03Z', N'2023-11-10T10:59:27Z', NULL, N'Business Central', N'Purchase Invoice', N'750c0eb3-6462-40e1-85dc-f38d6448a65c', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'C1000', N'C1000301', CAST(N'2023-11-10T10:59:01.0000000' AS DateTime2), CAST(N'2023-11-12T19:57:36.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'737b5f9f-f835-4464-b827-543311ee7ad5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ERV23-1664', 59.31, NULL, N'Pending', NULL, NULL, NULL, N'Business Central', N'Purchase Invoice', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', NULL, NULL, N'C3100', N'C3100230', CAST(N'2023-11-14T08:35:58.0000000' AS DateTime2), CAST(N'2023-11-14T08:35:58.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'ae4f2074-3435-40f8-9f8c-5c54cc0155c1', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-10T09:22:11Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgAzADk%3d', N'ERV23-1639', 280.83, N'2023-11-10T09:22:11Z', N'Yes', N'2023-11-10T08:03:54Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', NULL, NULL, N'P0001', N'P0001B08', CAST(N'2023-11-10T08:03:52.0000000' AS DateTime2), CAST(N'2023-11-10T09:22:15.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'c42c2340-d376-4a1d-bab1-5ca46c29034b', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'EBS23-0115', 3800, NULL, N'Pending', NULL, NULL, NULL, N'Business Central', N'Purchase Order', N'b5572063-6304-482c-8f38-2ba978188d7c', NULL, NULL, N'P0001', N'P0001P01', CAST(N'2023-11-09T08:53:04.0000000' AS DateTime2), CAST(N'2023-11-09T08:53:04.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'100382d6-60cb-4672-b735-5ece7177b95e', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-15T13:56:17Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=50&bookmark=37%3bJgAAAACLAQAAAAJ7%2f0UAQgBTADIAMwAtADAAMQA3ADY%3d', N'EBS23-0176', 457.6, N'2023-11-15T13:56:17Z', N'Yes', N'2023-11-15T13:27:51Z', NULL, NULL, N'Business Central', N'Purchase Order', N'b5572063-6304-482c-8f38-2ba978188d7c', NULL, NULL, N'P0001', N'P0001V03', CAST(N'2023-11-15T13:27:48.0000000' AS DateTime2), CAST(N'2023-11-15T13:56:21.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'0f6e001c-2fa7-4ed2-aa7f-646361e5f2cb', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ERV23-1588', 8335.2, NULL, N'Pending', NULL, NULL, NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', NULL, NULL, N'C5000', N'C5000300', CAST(N'2023-11-09T07:58:03.0000000' AS DateTime2), CAST(N'2023-11-09T07:58:03.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'f43cde4e-e0b7-4aa9-b7dd-659690e79fa7', N'rrothkamm@saperatec.de', N'Approve', NULL, N'2023-11-10T10:58:54Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-12T19:57:43Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA0ADk%3d', N'ERV23-1649', 52.94, N'2023-11-12T19:57:43Z', N'Yes', N'2023-11-10T10:58:41Z', N'2023-11-10T10:58:56Z', NULL, N'Business Central', N'Purchase Invoice', N'750c0eb3-6462-40e1-85dc-f38d6448a65c', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'C1000', N'C1000301', CAST(N'2023-11-10T10:58:39.0000000' AS DateTime2), CAST(N'2023-11-12T19:57:44.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'aed2f873-e8de-494a-bb7a-6a6098d52dcb', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-09T14:54:56Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-10T07:11:03Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA2ADA%3d', N'ERV23-1660', 20.22, N'2023-11-10T07:11:03Z', N'Yes', N'2023-11-09T14:29:40Z', N'2023-11-09T14:55:00Z', NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'C1000', N'C1000205', CAST(N'2023-11-09T14:29:38.0000000' AS DateTime2), CAST(N'2023-11-10T07:11:05.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'881dc7be-e60d-41c6-a26a-6adb0cc19835', N'nseifert@saperatec.de', N'Approve', NULL, N'2023-11-10T05:40:44Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA1ADk%3d', N'ERV23-1659', 44.05, N'2023-11-10T05:40:44Z', N'Yes', N'2023-11-09T14:29:44Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'05042b18-5709-4b63-b502-93a6b72da5c2', NULL, NULL, N'C1000', N'C1000223', CAST(N'2023-11-09T14:29:43.0000000' AS DateTime2), CAST(N'2023-11-10T05:40:46.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'17358d39-aaf1-4c1b-a02a-6d999e26fbd9', N'rrothkamm@saperatec.de', N'Reject', NULL, N'2023-11-14T07:54:39Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA3ADE%3d', N'ERV23-1671', 15.12, N'2023-11-14T07:54:39Z', N'Pending', N'2023-11-13T12:56:37Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'750c0eb3-6462-40e1-85dc-f38d6448a65c', NULL, NULL, N'C1000', N'C1000301', CAST(N'2023-11-13T12:56:35.0000000' AS DateTime2), CAST(N'2023-11-14T07:54:42.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'007436be-42ce-4d47-89aa-7133c913593a', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-09T13:52:15Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA2ADI%3d', N'ERV23-1662', 10.92, N'2023-11-09T13:52:15Z', N'Yes', N'2023-11-09T12:46:50Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', NULL, NULL, N'C5000', N'C5000600', CAST(N'2023-11-09T12:46:49.0000000' AS DateTime2), CAST(N'2023-11-09T13:52:16.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'ab52f776-8ba4-419d-af96-739cd9d73d48', N'skernbaum@saperatec.de', N'Approve', NULL, N'2023-11-10T12:30:16Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=50&bookmark=37%3bJgAAAACLAQAAAAJ7%2f0UAQgBTADIAMwAtADAAMQA5ADE%3d', N'EBS23-0191', 5356, N'2023-11-10T12:30:16Z', N'Yes', N'2023-11-10T10:49:20Z', NULL, NULL, N'Business Central', N'Purchase Order', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', NULL, NULL, N'P0011', N'P0011301', CAST(N'2023-11-10T10:49:19.0000000' AS DateTime2), CAST(N'2023-11-10T12:30:19.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'049cecf5-38af-4b87-a59c-74d54bbe7174', N'dmeisel@saperatec.de', N'Approve', NULL, N'2023-11-14T11:10:36Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA2ADU%3d', N'ERV23-1665', 298.89, N'2023-11-14T11:10:36Z', N'Yes', N'2023-11-14T09:45:30Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', NULL, NULL, N'C3100', N'C3100301', CAST(N'2023-11-14T09:45:27.0000000' AS DateTime2), CAST(N'2023-11-14T11:10:38.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'7f64b85b-49de-4119-95b0-7bbb13002158', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-15T13:58:38Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA3ADA%3d', N'ERV23-1670', 82.4, N'2023-11-15T13:58:38Z', N'Yes', N'2023-11-13T12:37:44Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', NULL, NULL, N'P0001', N'P0001B11', CAST(N'2023-11-13T12:37:41.0000000' AS DateTime2), CAST(N'2023-11-15T13:58:39.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'5a0dd937-1eaf-4875-8b9e-7e0e73300604', N'bwindus@saperatec.de', N'Approve', NULL, N'2023-11-09T12:16:47Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA1ADg%3d', N'ERV23-1658', 50, N'2023-11-09T12:16:47Z', N'Yes', N'2023-11-09T12:11:12Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'5715eaa3-a0e2-48ca-bf81-82636a806399', NULL, NULL, N'C1000', N'C1000002', CAST(N'2023-11-09T12:11:10.0000000' AS DateTime2), CAST(N'2023-11-09T12:16:49.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'5a89e675-99ec-4555-a42a-8091d72e1bc2', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-15T13:56:33Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA5ADU%3d', N'ERV23-1695', 44.9, N'2023-11-15T13:56:33Z', N'Yes', N'2023-11-15T09:01:18Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', NULL, NULL, N'C5000', N'C5000600', CAST(N'2023-11-15T09:01:12.0000000' AS DateTime2), CAST(N'2023-11-15T13:56:35.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'32359b29-0568-4bab-91da-87ed9457449f', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ERV23-1650', 30.49, NULL, N'Pending', NULL, NULL, NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', NULL, NULL, N'C1000', N'C1000205', CAST(N'2023-11-09T08:57:16.0000000' AS DateTime2), CAST(N'2023-11-09T08:57:16.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'd59b2f10-6dec-4141-ba26-8816073a0fa0', N'bwindus@saperatec.de', N'Reject', N'Buchungstext anpassen auf Oktober', N'2023-11-14T08:03:02Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA3ADg%3d', N'ERV23-1678', 686.95, N'2023-11-14T08:03:02Z', N'No', N'2023-11-14T07:59:11Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'5715eaa3-a0e2-48ca-bf81-82636a806399', NULL, NULL, N'C1000', N'C1000225', CAST(N'2023-11-14T07:59:10.0000000' AS DateTime2), CAST(N'2023-11-14T08:03:04.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'bde0d14b-6ed9-4add-9d34-8cd4043b277c', N'nseifert@saperatec.de', N'Approve', NULL, N'2023-11-14T09:57:03Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA4ADc%3d', N'ERV23-1687', 49.71, N'2023-11-14T09:57:03Z', N'Yes', N'2023-11-14T09:23:29Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'05042b18-5709-4b63-b502-93a6b72da5c2', NULL, NULL, N'C1000', N'C1000225', CAST(N'2023-11-14T09:23:27.0000000' AS DateTime2), CAST(N'2023-11-14T09:57:06.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'fcb32cd9-3895-4340-9103-944e199daf55', N'nseifert@saperatec.de', N'Approve', NULL, N'2023-11-15T09:23:02Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA3ADU%3d', N'ERV23-1675', 173.2, N'2023-11-15T09:23:02Z', N'Yes', N'2023-11-15T08:29:18Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'05042b18-5709-4b63-b502-93a6b72da5c2', NULL, NULL, N'C1000', N'C1000301', CAST(N'2023-11-15T08:29:16.0000000' AS DateTime2), CAST(N'2023-11-15T09:23:03.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'2827de5d-14f1-4d5c-9c88-95eadcc79ff2', N'fwegert@saperatec.de', N'Approve', N'Ich erteile die FG!', N'2023-11-21T20:31:10Z', N'lstock@saperatec.de', N'Approve', NULL, N'2023-11-22T06:35:28Z', N'skernbaum@saperatec.de', N'Approve', NULL, N'2023-11-22T06:49:14Z', N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=50&bookmark=37%3bJgAAAACLAQAAAAJ7%2f0UAQgBTADIAMQAtADAAMAA2ADM%3d', N'EBS21-0063', 646376.61, N'2023-11-22T06:49:14Z', N'Yes', N'2023-11-13T12:53:12Z', N'2023-11-21T20:31:15Z', N'2023-11-22T06:35:34Z', N'Business Central', N'Purchase Order', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'154e58cd-8c39-4620-a48b-88bc02966835', N'df9c0a42-323d-4e0d-b29c-54ae4b56a81e', N'P0001', N'P0001A09', CAST(N'2023-11-13T12:53:01.0000000' AS DateTime2), CAST(N'2023-11-22T06:49:15.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'b0471af6-fb0a-4884-ab0c-98fa7ce7e567', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-10T07:11:12Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgAwADQ%3d', N'ERV23-1604', 1321.6, N'2023-11-10T07:11:12Z', N'Yes', N'2023-11-09T14:03:58Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, NULL, N'C1000', N'C1000227', CAST(N'2023-11-09T14:03:55.0000000' AS DateTime2), CAST(N'2023-11-10T07:11:13.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'99ed66ad-d2e7-4b76-96c2-9b46f2498d36', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-15T09:31:41Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA5ADY%3d', N'ERV23-1696', 51.42, N'2023-11-15T09:31:41Z', N'Yes', N'2023-11-15T09:11:30Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, NULL, N'C1000', N'C1000202', CAST(N'2023-11-15T09:11:26.0000000' AS DateTime2), CAST(N'2023-11-15T09:31:42.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'fdf09d79-2e89-4115-93c7-9c47cbda3fd9', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-09T13:53:54Z', N'lstock@saperatec.de', N'Approve', NULL, N'2023-11-09T15:58:42Z', N'skernbaum@saperatec.de', N'Approve', NULL, N'2023-11-10T12:29:41Z', N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANQA2ADI%3d', N'ERV23-1562', 22668, N'2023-11-10T12:29:41Z', N'Yes', N'2023-11-09T09:25:17Z', N'2023-11-09T13:53:58Z', N'2023-11-09T15:58:46Z', N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', N'154e58cd-8c39-4620-a48b-88bc02966835', N'df9c0a42-323d-4e0d-b29c-54ae4b56a81e', N'P0001', N'P0001A04', CAST(N'2023-11-09T09:25:12.0000000' AS DateTime2), CAST(N'2023-11-10T12:29:43.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'd70a8687-a3f9-4810-a065-9d71aa133112', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-09T13:50:29Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-10T07:11:45Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA1ADU%3d', N'ERV23-1655', 57.46, N'2023-11-10T07:11:45Z', N'Yes', N'2023-11-09T10:37:52Z', N'2023-11-09T13:50:34Z', NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'C1000', N'C1000205', CAST(N'2023-11-09T10:37:50.0000000' AS DateTime2), CAST(N'2023-11-10T07:11:47.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'ff5b34a7-c7b7-4430-ad76-9f8fe57ff142', N'cfriedrich@saperatec.de', N'Approve', NULL, N'2023-11-09T12:00:09Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA1ADc%3d', N'ERV23-1657', 41.7, N'2023-11-09T12:00:09Z', N'Yes', N'2023-11-09T11:59:55Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'23659c75-6839-4a6f-8e61-5fd9699b2a72', NULL, NULL, N'C1000', N'C1000223', CAST(N'2023-11-09T11:59:53.0000000' AS DateTime2), CAST(N'2023-11-09T12:00:15.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'10ddf1f1-1150-40fe-a58d-a08b9b2a2745', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-15T13:58:43Z', N'lstock@saperatec.de', N'Approve', NULL, N'2023-11-15T16:35:08Z', N'skernbaum@saperatec.de', N'Approve', NULL, N'2023-11-16T08:58:28Z', N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=50&bookmark=37%3bJgAAAACLAQAAAAJ7%2f0UAQgBTADIAMgAtADAAMAAzADk%3d', N'EBS22-0039', 103664.8, N'2023-11-16T08:58:28Z', N'Yes', N'2023-11-13T11:50:30Z', N'2023-11-15T13:58:46Z', N'2023-11-15T16:35:14Z', N'Business Central', N'Purchase Order', N'b5572063-6304-482c-8f38-2ba978188d7c', N'154e58cd-8c39-4620-a48b-88bc02966835', N'df9c0a42-323d-4e0d-b29c-54ae4b56a81e', N'P0001', N'P0001P01', CAST(N'2023-11-13T11:50:24.0000000' AS DateTime2), CAST(N'2023-11-16T08:59:08.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'7b194ad6-00cf-43ed-b24b-a38b12bc0d0c', N'nseifert@saperatec.de', N'Approve', NULL, N'2023-11-14T08:45:55Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-14T16:09:52Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgAzADM%3d', N'ERV23-1633', 37.38, N'2023-11-14T16:09:52Z', N'Yes', N'2023-11-14T08:45:49Z', N'2023-11-14T08:45:59Z', NULL, N'Business Central', N'Purchase Invoice', N'05042b18-5709-4b63-b502-93a6b72da5c2', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'C4000', N'C4000202', CAST(N'2023-11-14T08:45:47.0000000' AS DateTime2), CAST(N'2023-11-14T16:10:04.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'c764325a-4857-4b82-823d-a93abe09eaf2', N'nseifert@saperatec.de', N'Reject', NULL, N'2023-11-09T13:11:48Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgAzADM%3d', N'ERV23-1633', 37.38, N'2023-11-09T13:11:48Z', N'Pending', N'2023-11-09T13:09:28Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'05042b18-5709-4b63-b502-93a6b72da5c2', NULL, NULL, N'C4000', N'C4000202', CAST(N'2023-11-09T13:09:25.0000000' AS DateTime2), CAST(N'2023-11-09T13:11:51.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'e5a93798-9be4-4181-b844-abf72e3e6c61', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'EBS23-0194', 245, NULL, N'Pending', NULL, NULL, NULL, N'Business Central', N'Purchase Order', N'26628075-8eee-4496-a3bc-66025432aa7a', NULL, NULL, N'C5000', N'C5000600', CAST(N'2023-11-09T10:45:29.0000000' AS DateTime2), CAST(N'2023-11-09T10:45:29.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'f7c348ef-aa51-41ba-b0b8-b186daa4d396', N'skernbaum@saperatec.de', N'Approve', NULL, N'2023-11-10T12:30:59Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=50&bookmark=37%3bJgAAAACLAQAAAAJ7%2f0UAQgBTADIAMwAtADAAMQA4ADM%3d', N'EBS23-0183', 4905.3, N'2023-11-10T12:30:59Z', N'Yes', N'2023-11-10T10:50:03Z', NULL, NULL, N'Business Central', N'Purchase Order', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', NULL, NULL, N'P0011', N'P0011301', CAST(N'2023-11-10T10:50:01.0000000' AS DateTime2), CAST(N'2023-11-10T12:31:00.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'5c8a9cae-f265-4afa-8b9a-b18f91282d92', N'rrothkamm@saperatec.de', N'Approve', NULL, N'2023-11-14T07:54:01Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-14T16:10:31Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA3ADc%3d', N'ERV23-1677', 39.12, N'2023-11-14T16:10:31Z', N'Yes', N'2023-11-14T07:52:45Z', N'2023-11-14T07:54:04Z', NULL, N'Business Central', N'Purchase Invoice', N'750c0eb3-6462-40e1-85dc-f38d6448a65c', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'C1000', N'C1000205', CAST(N'2023-11-14T07:52:44.0000000' AS DateTime2), CAST(N'2023-11-14T16:10:36.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'cd175392-61e3-4591-ae92-b3faea8076b4', N'nseifert@saperatec.de', N'Approve', NULL, N'2023-11-13T12:12:35Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA1ADY%3d', N'ERV23-1656', 10.22, N'2023-11-13T12:12:35Z', N'Yes', N'2023-11-13T12:02:56Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'05042b18-5709-4b63-b502-93a6b72da5c2', NULL, NULL, N'C1000', N'C1000205', CAST(N'2023-11-13T12:02:52.0000000' AS DateTime2), CAST(N'2023-11-13T12:12:37.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'7d8e587e-7e43-4bc9-a51c-ba1e7cbb3401', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-15T13:58:32Z', N'lstock@saperatec.de', N'Approve', NULL, N'2023-11-15T16:35:19Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA3ADM%3d', N'ERV23-1673', 12898.37, N'2023-11-15T16:35:19Z', N'Yes', N'2023-11-13T13:21:33Z', N'2023-11-15T13:58:34Z', NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', NULL, N'C5000', N'C5000400', CAST(N'2023-11-13T13:21:28.0000000' AS DateTime2), CAST(N'2023-11-15T16:35:21.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'42501c6b-0271-4993-9e64-c2843686aa55', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-14T16:10:20Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA4ADI%3d', N'ERV23-1682', 40, N'2023-11-14T16:10:20Z', N'Yes', N'2023-11-14T08:29:39Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, NULL, N'C1000', N'C1000202', CAST(N'2023-11-14T08:29:38.0000000' AS DateTime2), CAST(N'2023-11-14T16:10:25.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'2337926c-22a0-40f7-9ac4-c3ecde055239', N'nseifert@saperatec.de', N'Approve', NULL, N'2023-11-14T09:57:09Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA4ADY%3d', N'ERV23-1686', 140.21, N'2023-11-14T09:57:09Z', N'Yes', N'2023-11-14T09:17:31Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'05042b18-5709-4b63-b502-93a6b72da5c2', NULL, NULL, N'C1000', N'C1000225', CAST(N'2023-11-14T09:17:30.0000000' AS DateTime2), CAST(N'2023-11-14T09:57:11.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'03aac0ef-3597-4ed9-8296-c437ab4ccc32', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-14T16:10:13Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA4ADM%3d', N'ERV23-1683', 802.2, N'2023-11-14T16:10:13Z', N'Yes', N'2023-11-14T08:34:13Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, NULL, N'C4000', N'C4000101', CAST(N'2023-11-14T08:34:12.0000000' AS DateTime2), CAST(N'2023-11-14T16:10:22.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'292e3ba5-17e7-4ae0-b81c-ca9c79d1b9bc', N'nseifert@saperatec.de', N'Approve', NULL, N'2023-11-14T08:34:09Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA4ADE%3d', N'ERV23-1681', 100.82, N'2023-11-14T08:34:09Z', N'Yes', N'2023-11-14T08:22:01Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'05042b18-5709-4b63-b502-93a6b72da5c2', NULL, NULL, N'C1000', N'C1000223', CAST(N'2023-11-14T08:21:59.0000000' AS DateTime2), CAST(N'2023-11-14T08:34:12.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'84b7b1c7-6f03-44a9-9cc8-cc84fb071e12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'ERV23-1567', 8658.08, NULL, N'Pending', NULL, NULL, NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', NULL, NULL, N'P0001', N'P0001N04', CAST(N'2023-11-09T08:12:21.0000000' AS DateTime2), CAST(N'2023-11-09T08:12:21.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'c39c0d9d-a590-43ea-9c42-cd72b0558694', N'lstock@saperatec.de', N'Approve', NULL, N'2023-11-14T12:25:26Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-14T16:08:33Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA3ADU%3d', N'ERV23-1675', 173.2, N'2023-11-14T16:08:33Z', N'Yes', N'2023-11-14T07:40:24Z', N'2023-11-14T12:25:29Z', NULL, N'Business Central', N'Purchase Invoice', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'C1000', N'C1000301', CAST(N'2023-11-14T07:40:21.0000000' AS DateTime2), CAST(N'2023-11-14T16:08:40.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'00e39bf5-5143-43b3-9c3d-cf0421bf69d7', N'cfriedrich@saperatec.de', N'Approve', NULL, N'2023-11-14T08:47:02Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA1ADc%3d', N'ERV23-1657', 41.7, N'2023-11-14T08:47:02Z', N'Yes', N'2023-11-14T08:34:27Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'23659c75-6839-4a6f-8e61-5fd9699b2a72', NULL, NULL, N'C1000', N'C1000223', CAST(N'2023-11-14T08:34:25.0000000' AS DateTime2), CAST(N'2023-11-14T08:47:04.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'582cb957-f966-4ea7-bcb7-d0c721009739', N'dmeisel@saperatec.de', N'Approve', N'BS und KSt an Rin angepasst.', N'2023-11-09T11:10:42Z', N'skernbaum@saperatec.de', N'Approve', NULL, N'2023-11-09T15:09:38Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA1ADI%3d', N'ERV23-1652', 1657.02, N'2023-11-09T15:09:38Z', N'Yes', N'2023-11-09T09:51:22Z', N'2023-11-09T11:10:45Z', NULL, N'Business Central', N'Purchase Invoice', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', NULL, N'C3200', N'C3200201', CAST(N'2023-11-09T09:51:20.0000000' AS DateTime2), CAST(N'2023-11-09T15:09:40.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'e5fc3193-410b-4d9a-ae28-df0794111412', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-10T11:21:10Z', N'lstock@saperatec.de', N'Reject', N'Bitte BS auf C5000500 ändern', N'2023-11-10T11:27:25Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA1ADM%3d', N'ERV23-1653', 6298.78, N'2023-11-10T11:27:25Z', N'No', N'2023-11-10T10:52:40Z', N'2023-11-10T11:21:13Z', NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', NULL, N'P0001', N'P0001N04', CAST(N'2023-11-10T10:52:38.0000000' AS DateTime2), CAST(N'2023-11-10T11:27:27.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'b690a3e7-1e9b-4ad8-aefb-e7a88c45a407', N'rrothkamm@saperatec.de', N'Approve', NULL, N'2023-11-10T11:01:40Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-12T19:57:27Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA1ADE%3d', N'ERV23-1651', 15.12, N'2023-11-12T19:57:27Z', N'Yes', N'2023-11-10T10:58:50Z', N'2023-11-10T11:01:42Z', NULL, N'Business Central', N'Purchase Invoice', N'750c0eb3-6462-40e1-85dc-f38d6448a65c', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'C1000', N'C1000301', CAST(N'2023-11-10T10:58:48.0000000' AS DateTime2), CAST(N'2023-11-12T19:57:29.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'1b6d7c53-3b5a-4e35-a5ce-e9a90ec3a5ea', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-14T16:09:43Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA4ADg%3d', N'ERV23-1688', 98.8, N'2023-11-14T16:09:43Z', N'Yes', N'2023-11-14T09:34:40Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, NULL, N'P0021', N'P0021101', CAST(N'2023-11-14T09:34:39.0000000' AS DateTime2), CAST(N'2023-11-14T16:09:50.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'5052ab77-98bf-41d0-bb2d-ea8852afec50', N'lstock@saperatec.de', N'Approve', NULL, N'2023-11-14T12:25:40Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA3ADI%3d', N'ERV23-1672', 232.82, N'2023-11-14T12:25:40Z', N'Yes', N'2023-11-14T07:17:52Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', NULL, NULL, N'C5000', N'C5000300', CAST(N'2023-11-14T07:17:38.0000000' AS DateTime2), CAST(N'2023-11-14T12:25:41.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'8e3fe103-7a7b-4a53-b336-ededbba3cb52', N'nseifert@saperatec.de', N'Approve', NULL, N'2023-11-09T12:06:44Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA1ADY%3d', N'ERV23-1656', 10.22, N'2023-11-09T12:06:44Z', N'Yes', N'2023-11-09T11:55:12Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'05042b18-5709-4b63-b502-93a6b72da5c2', NULL, NULL, N'C1000', N'C1000205', CAST(N'2023-11-09T11:55:10.0000000' AS DateTime2), CAST(N'2023-11-09T12:06:46.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'bce119a9-dbc0-4c3a-aa39-f996bb994564', N'cfriedrich@saperatec.de', N'Approve', NULL, N'2023-11-16T10:27:43Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA5ADA%3d', N'ERV23-1690', 143.35, N'2023-11-16T10:27:43Z', N'Yes', N'2023-11-14T14:13:19Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'23659c75-6839-4a6f-8e61-5fd9699b2a72', NULL, NULL, N'C1000', N'C1000301', CAST(N'2023-11-14T14:13:06.0000000' AS DateTime2), CAST(N'2023-11-16T10:27:45.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'3d436fe4-89fe-4150-b30f-fcb727e202cd', N'bwindus@saperatec.de', N'Approve', NULL, N'2023-11-10T09:21:27Z', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA2ADc%3d', N'ERV23-1667', 21.65, N'2023-11-10T09:21:27Z', N'Yes', N'2023-11-10T09:16:51Z', NULL, NULL, N'Business Central', N'Purchase Invoice', N'5715eaa3-a0e2-48ca-bf81-82636a806399', NULL, NULL, N'C1000', N'C1000223', CAST(N'2023-11-10T09:16:49.0000000' AS DateTime2), CAST(N'2023-11-10T09:21:31.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
INSERT [dbo].[tApproval] ([Id], [ApproverOneEmail], [ApproverOneStatus], [ApproverOneNote], [ApproverOneTime], [ApproverTwoEmail], [ApproverTwoStatus], [ApproverTwoNote], [ApproverTwoTime], [ApproverThreeEmail], [ApproverThreeStatus], [ApproverThreeNote], [ApproverThreeTime], [ApproverItemLink], [DocumentNumber], [ApprovalAmount], [ApprovalDate], [ApprovalFinal], [ApproverOneRequestDate], [ApproverTwoRequestDate], [ApproverThreeRequestDate], [ApprovalSourceSystem], [ApprovalObject], [idSellerPurchaser], [idBudgetResponsible], [idExecutiveApprover], [CostCenterCode], [RefCode], [DateCreated], [DateUpdated], [IdMigration], [IdMigrate], [IdClient]) VALUES (N'9ea6b35c-d050-404d-9f76-fcf30ab8bc69', N'mburock@saperatec.de', N'Approve', NULL, N'2023-11-15T13:56:54Z', N'thornung@saperatec.de', N'Approve', NULL, N'2023-11-22T12:03:04Z', NULL, NULL, NULL, NULL, N'https://businesscentral.dynamics.com/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/?company=saperatec%20GmbH&page=51&bookmark=37%3bJgAAAACLAgAAAAJ7%2f0UAUgBWADIAMwAtADEANgA4ADU%3d', N'ERV23-1685', 382.2, N'2023-11-22T12:03:04Z', N'Yes', N'2023-11-14T09:15:20Z', N'2023-11-15T13:56:57Z', NULL, N'Business Central', N'Purchase Invoice', N'b5572063-6304-482c-8f38-2ba978188d7c', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', NULL, N'C1000', N'C1000231', CAST(N'2023-11-14T09:15:14.0000000' AS DateTime2), CAST(N'2023-11-22T12:03:07.0000000' AS DateTime2), NULL, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6')
GO
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'7d976683-6ff4-4422-b49c-44fabbcbd821', N'447db13b-d864-440d-91ce-d09734ab3fc3', -1, N'C0000', NULL, 1, N'447db13b-d864-440d-91ce-d09734ab3fc3', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'85be78a4-0466-4a21-9473-e145663c44bb', N'5715eaa3-a0e2-48ca-bf81-82636a806399', -1, N'C0000', NULL, 1, N'5715eaa3-a0e2-48ca-bf81-82636a806399', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1a74e403-3dbe-4fbb-84aa-620f0a425b20', N'5715eaa3-a0e2-48ca-bf81-82636a806399', -1, N'C1000', NULL, 1, N'5715eaa3-a0e2-48ca-bf81-82636a806399', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'69ce2541-a5a4-48fa-b2dd-7759cae84ae5', N'447db13b-d864-440d-91ce-d09734ab3fc3', -1, N'C1000', NULL, 1, N'447db13b-d864-440d-91ce-d09734ab3fc3', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'5a5f3933-75d2-4f51-b5cc-4ced8a7e3221', N'05042b18-5709-4b63-b502-93a6b72da5c2', -1, N'C1000', NULL, 1, N'05042b18-5709-4b63-b502-93a6b72da5c2', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'38338ec6-dd9e-4459-89a4-70a4e38157c7', N'ab0b1f2a-ad0e-4345-ba60-f2dad6519438', -1, N'C1500', NULL, 1, N'ab0b1f2a-ad0e-4345-ba60-f2dad6519438', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'84fa3337-e0e3-4a8c-a5e9-617f5cb4bf5f', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, N'C2000', NULL, 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'f4114a49-7618-4199-b02e-695f3aac51dd', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, N'C2000', NULL, 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'ee2bce1e-a8ec-4b2a-8862-fe5e3ab0f581', N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', -1, N'C3000', NULL, 1, N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'98b4db7f-ad80-405c-ac41-5f85e29bd6cf', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', -1, N'C3000', NULL, 1, N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'33401e3f-4bd9-4e60-942c-b2954020f840', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', -1, N'C3100', NULL, 1, N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'00f2e5d0-a5da-4a15-9118-46691dce8bbc', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', -1, N'C3200', NULL, 1, N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'523af415-d501-4622-9e8a-cf155563c311', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', -1, N'P0005', NULL, 1, N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'a37ac177-8c4f-400b-949d-b1e9c1e7dbc0', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', -1, N'P0006', NULL, 1, N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'3817204d-8a62-40b0-938b-729fced4573d', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', -1, N'P0011', NULL, 1, N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'9342ccef-4dc1-4482-a738-c9090a20ec21', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', -1, N'P0012', NULL, 1, N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'71a41433-6f8f-4858-9b14-2760ffda66e3', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', -1, N'P0013', NULL, 1, N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'100cf3a2-6b2d-4880-9686-9e8837fe597b', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', -1, N'P0017', N'11', 1, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2024-02-01T05:08:23.8905647' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'9627c36c-5c2b-48aa-9895-d87523d392c9', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', -1, N'P0016', NULL, 1, N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'b48cc1bd-83c3-4d2c-ac27-44b4f8f8c8ec', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', -1, N'P0018', NULL, 1, N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'ba0153d8-eb57-42cd-beb7-664785d5147f', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', -1, N'P0019', NULL, 1, N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'8bb4cfed-6d0b-4272-b4d2-456987018ec3', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', -1, N'P0020', NULL, 1, N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'7a717a9a-7b1f-47d6-8764-b0a46eef8ac4', N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', -1, N'C3100', NULL, 1, N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'368543fb-53dc-40de-ac34-53f5790ea65d', N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', -1, N'C3200', NULL, 1, N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1ed92c34-52a6-4607-b84d-07676b86c690', N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', -1, N'P0005', NULL, 1, N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'e8481118-3f6e-4d73-979d-30e27e9b1ef2', N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', -1, N'P0006', NULL, 1, N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'692811e4-2d65-47c3-9be7-b02eaa47f045', N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', -1, N'P0011', N'44', 1, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2024-02-01T05:03:30.2683342' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'abf8ed21-f597-40f1-b987-0ff9ce1df2d9', N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', -1, N'P0012', NULL, 1, N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'b10db685-3d19-4d25-89c1-997a410529e1', N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', -1, N'P0013', N'76', 1, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2024-02-01T05:02:32.0848520' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'fcc976e6-0576-484a-9957-9f83b8bcc330', N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', -1, N'P0014', NULL, 1, N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'e5f7600b-6484-4011-9297-2c5c6ccf3fdf', N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', -1, N'P0016', NULL, 1, N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'992ea185-3188-4edd-b6aa-dd75ab5f144b', N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', -1, N'P0017', NULL, 1, N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'9ff227d8-cd54-4f2e-843c-3df798660e6c', N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', -1, N'P0018', NULL, 1, N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'81c9757d-3f5c-4702-8cc6-345dda081244', N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', -1, N'P0019', NULL, 1, N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'9b17130d-88c8-4ce9-bdcb-2764b5987392', N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', -1, N'P0020', N'19', 1, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2024-02-01T04:57:54.0105542' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'63fc541b-94d1-4012-bb7c-0f35ee724f48', N'29f7b077-dc0c-465c-b460-a98ab99f2447', -1, N'C4000', NULL, 1, N'29f7b077-dc0c-465c-b460-a98ab99f2447', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'307e13a4-372f-44cf-a314-6e3069ace1d2', N'29f7b077-dc0c-465c-b460-a98ab99f2447', -1, N'P0020', NULL, 1, N'29f7b077-dc0c-465c-b460-a98ab99f2447', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'cdabb4aa-3d4e-4564-b2b0-49d8f109743b', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, N'P0021', N'2', 1, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2024-02-01T04:46:01.5898154' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'7cfa2ffc-6b3d-4e2f-aa44-2c565b1a42ca', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, N'P0021', NULL, 1, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'aca5fe66-35a1-4e8d-b0f2-1e2d76cd1e7d', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, N'P0019', NULL, 1, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-11T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1de966c4-a262-4a47-b538-1d8ed7886fb2', N'b5572063-6304-482c-8f38-2ba978188d7c', -1, N'C5000', NULL, 1, N'b5572063-6304-482c-8f38-2ba978188d7c', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'2c89bfc1-e31d-4b91-8faf-54b335677d50', N'b5572063-6304-482c-8f38-2ba978188d7c', -1, N'C5100', NULL, 1, N'b5572063-6304-482c-8f38-2ba978188d7c', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'cb8fd075-8992-4aeb-856c-c9e89977c35a', N'b5572063-6304-482c-8f38-2ba978188d7c', -1, N'C5200', NULL, 1, N'b5572063-6304-482c-8f38-2ba978188d7c', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'2c398146-1e7f-40d7-8712-805e302ff0fd', N'b5572063-6304-482c-8f38-2ba978188d7c', -1, N'P0001', NULL, 1, N'b5572063-6304-482c-8f38-2ba978188d7c', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'058ee352-3e65-4165-8d5e-67b3fffe61ea', N'3334c30a-3bf9-4c8a-a328-5dd66c732a95', -1, N'C1000', NULL, 1, N'3334c30a-3bf9-4c8a-a328-5dd66c732a95', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'7950d2ed-b003-4499-8d78-6597325a13e7', N'23659c75-6839-4a6f-8e61-5fd9699b2a72', -1, N'C1000', NULL, 1, N'23659c75-6839-4a6f-8e61-5fd9699b2a72', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'0f05e7c3-e33d-419e-beb1-1c8b110e1aa0', N'750c0eb3-6462-40e1-85dc-f38d6448a65c', -1, N'C1000', NULL, 1, N'750c0eb3-6462-40e1-85dc-f38d6448a65c', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1247b925-2319-4309-b7df-989e76b8e4be', N'750c0eb3-6462-40e1-85dc-f38d6448a65c', -1, N'C3000', NULL, 1, N'750c0eb3-6462-40e1-85dc-f38d6448a65c', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'fe66aed3-1fa2-443e-8981-66304320c851', N'750c0eb3-6462-40e1-85dc-f38d6448a65c', -1, N'C5000', NULL, 1, N'750c0eb3-6462-40e1-85dc-f38d6448a65c', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'5695761e-cbd1-4675-a511-eacdf2d5dbbf', N'750c0eb3-6462-40e1-85dc-f38d6448a65c', -1, N'C5100', NULL, 1, N'750c0eb3-6462-40e1-85dc-f38d6448a65c', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'87ade6c3-8a2c-4767-b2ec-be994205d422', N'750c0eb3-6462-40e1-85dc-f38d6448a65c', -1, N'P0001', NULL, 1, N'750c0eb3-6462-40e1-85dc-f38d6448a65c', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'58abe833-73a5-4ef8-b03b-d5180c651c2c', N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', -1, N'C2000', NULL, 1, N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'fdb8f10a-f7be-4021-85b0-d5701625fde5', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, N'C2000', NULL, 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'c47e602c-c0a4-4d29-8688-df4999f5515a', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, N'P0001', NULL, 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'e7d03abf-654f-45eb-8fd4-17e6702e72c8', N'90cdc72c-36ae-4647-b7ec-aebc4dc81e64', -1, N'C2000', NULL, 1, N'90cdc72c-36ae-4647-b7ec-aebc4dc81e64', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'03a75f56-8d52-46d3-b511-ba492f633866', N'e8b29ea0-4f79-4d3e-b467-6f2c16cb096c', -1, N'C5200', NULL, 1, N'e8b29ea0-4f79-4d3e-b467-6f2c16cb096c', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2), CAST(N'2023-07-12T15:23:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'6d65e0af-fdd0-4b3b-8de3-22d3c4002d88', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001S07', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'7fef948f-562a-40e9-80fc-b7cc2df75de8', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001S09', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'7668a613-650a-4d5d-aa07-a93912995794', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001A01', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'00b207ec-1913-4e50-86b0-7dbef3fd32a1', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, N'C0067', N'P0001A03', 1, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2024-02-01T05:00:27.2920999' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'3865394b-ac64-4492-8305-89a8477a0f1c', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001A04', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'6def38cc-1cf7-47e9-8817-962d1b692f3a', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001A08', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'3d7e5be7-77a5-4afe-92fd-cc8ae17678f7', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001A09', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'14798123-5249-4bea-9be4-066ec49861ce', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B01', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'8fb2dbc5-d0fd-43a9-b010-a680ad5a31eb', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B02', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'530da107-f492-4abc-9430-af93219463a0', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B04', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'fe718e37-ccab-4cad-ad7f-5de82f3670a4', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B05', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'5f24c021-111e-49c5-8448-d643a3d4a683', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B08', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'89a7c056-d1ad-4dff-970b-2dc082abd891', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B09', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'dfe59baf-5f9d-4968-9c1d-e01753fcd53c', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B11', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'72003a58-62f4-4f6f-a386-3362ac716638', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B12', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'dd7d6c62-59a3-4d7c-8a1b-17fb6e204700', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B13', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'7f89a3d0-a96c-4f38-ad27-c7f78fb46631', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B14', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'68dac651-0185-4646-8640-5ae687c286d9', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B15', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'13033215-cc80-4145-abeb-a7e7ed315c40', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B16', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'90ae3d07-15fe-4898-ad49-fed9a73829fc', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B17', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1f27ef7d-e9c1-46e3-b949-c45a674b66dd', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B19', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'7209deac-0d48-4f73-9df9-9b4441b7ea5a', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B21', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'92024562-db88-45bf-9e8c-0a0dc113918c', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B22', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'7ff56f4f-b336-4b9f-9dae-0b0d0b49d110', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B23', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'2418f459-2b5b-4d81-aa86-05f76885a0e8', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001B27', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'9842222b-f688-4252-99a3-1668784df841', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001P02', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'807535bc-5524-4f7a-bfb2-816848704c9c', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001P03', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'84614fc1-a5a5-46ce-804f-4440db75f504', N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', -1, NULL, N'P0001V04', 1, N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'66f9e766-7a70-466e-a541-acfb0c9615a3', N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', -1, NULL, N'P0001A02', 1, N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'aa66ae68-42ec-4652-bb80-4b47c2f28efd', N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', -1, NULL, N'P0001A05', 1, N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'f87e2a39-d34b-4f74-bbcb-1c5c7936b62b', N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', -1, NULL, N'P0001A07', 1, N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'286a1f22-36ea-4e7f-92ad-66e341c19bdf', N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', -1, NULL, N'P0001B06', 1, N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'd40f4c82-0754-40cd-8d51-ad83b576c615', N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', -1, NULL, N'P0001B07', 1, N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'76762c5e-4962-49ad-96d6-ee6a69e716bd', N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', -1, NULL, N'P0001B34', 1, N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'8c22cb66-b65f-4f3b-9241-9bf75805adb6', N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', -1, NULL, N'P0001B35', 1, N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'205bf040-46ba-4cc6-9cbb-e77f4033216f', N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', -1, NULL, N'P0001U13', 1, N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'a25d9b3f-36a1-43f4-8589-800fa0d0a16b', N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', -1, NULL, N'P0001U15', 1, N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'dce4ca3d-9f1f-45e0-8f89-3d18c356a87d', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001S02', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'c6df855e-0fcb-456d-89e2-b36cae25640b', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001S03', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'b364d11d-fec6-4df2-af8c-b393a4b87341', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001S04', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'104f5de1-f105-4843-ba4a-aa40eb4ef25b', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001S11', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'552b8e80-ae94-486a-ade6-d9ff1c3a23ee', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001S12', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'f030e24a-b961-414c-b32a-a54cfa996adf', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001S13', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'9dda6dce-5792-474d-a0e8-7abcc385c9f5', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001U06', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
GO
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'5e2705cf-6089-4b13-a03e-093bb0e30e7a', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001U07', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'0eb6ca0d-ac9b-4b87-87b0-83956c04ced1', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, N'P', N'P0001U08', 3, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2024-02-01T11:02:34.9345768' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1ab0a278-b1ce-42c5-a7ac-3fe9a5ad318a', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001U09', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'dce23f0a-37dc-4bac-bdb1-19b74a305a6b', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001U10', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'643b095e-686a-47f8-b2b0-8cd139a92677', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001U07', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-06T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-06T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'029ee62e-a17e-49dc-9ab1-d4ae2baab85d', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001U11', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'ea4fc5d0-6fcb-49fe-b938-58c0a62e3eee', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001U12', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'436c471f-2610-4de6-a59a-179d2757d305', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001U13', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1ef4a346-8903-48f4-a2d9-88a75dd8fd09', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001U14', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'98a7c727-d637-440f-b827-23cc83c5c321', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001U17', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'7b51f788-bd5f-4b41-8318-f1f86aebe2ef', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B36', 1, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:38:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:38:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'2f093c0e-c81b-40e1-8b80-9068af332282', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001I01', 1, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:38:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:38:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'19ea198e-9938-4e17-b3c1-e2d8f59632a3', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001I02', 1, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:38:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:38:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'8bb80959-4e7a-4961-a888-b2dc75b33e93', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001A01', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'14c7cda7-4144-42ad-a768-df30be1fd948', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001A03', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'9a1cb91a-1aa1-4c99-a331-9949cb40be13', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001N01', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'61f55b04-368c-42c9-bb83-15197dcdaf7b', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001N04', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'e223153a-784f-4106-8fc2-93e586eb61fa', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001N05', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1d66f4f5-e431-42b2-a9bc-8fe33e5bab4b', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001N06', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'416597af-fb92-456a-82e2-7ade14581670', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001N11', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'827fa732-25ca-4be7-a579-735068724659', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001P01', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'd1cb3009-8370-4cfb-924d-257a9922ee02', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001S01', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'87459589-f816-4963-86c1-98c0b115bacd', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001S02', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'e5c874d6-eec9-480d-954a-838ba2e8482f', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001S03', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1f2ae341-8365-407d-900c-90095863f1e1', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001S04', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'a50916e2-c1a6-4a91-bafd-8fff951d7635', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001S06', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'56f7500c-ec4d-4841-ba57-1e5ff91c34d2', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001S07', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1d6e296a-2ca6-40ba-8feb-5db21164a928', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001S09', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'6417d188-d637-42a2-a777-4c8e084c1c04', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001S11', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'd0a13628-3187-4dd6-8b53-12fb6224298d', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001S12', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'29eb9c75-3afb-4315-a863-35037b01672f', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001S13', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'55f8ef39-975e-480a-9b9f-a55b2f0f1bc2', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001U04', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'3dc5ba70-4581-42e0-9102-e3d1b20e0b17', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001U14', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'e3de8fa3-a0ce-4041-bfa6-7308b4d7f696', N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', -1, NULL, N'P0001U17', 1, N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'a35d870a-0048-40ea-a459-f179f4287404', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001I09', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'15ce53bd-7eaf-4577-87cd-6deadae17270', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001N10', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'6c538194-b88c-4290-a88f-f1a2a0fc213b', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001U01', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'2416dcf3-3509-4abb-ab51-74508f72e814', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001U06', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'f060b9be-df04-4c89-81fe-bc0026481689', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001U08', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'ac065931-da41-49f3-988a-32233da92ef6', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001U09', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'dd042f9f-d85f-495a-84a7-83eb89ee588d', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001U10', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'382e2fa1-10d4-4958-9d30-34ad57ef0bb0', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001U11', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'aef74890-29f4-4067-8608-653426ccc0ed', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001U12', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'c57da4cb-edae-4420-81e7-fa568e105d5f', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001V01', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'8bcbf91e-9ed0-4f41-aa21-0a9f2763e08b', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001V02', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'585a8a67-e94b-4fc0-800d-8f63f23b4dee', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001V03', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'de8ad3a4-20c3-4088-81ec-ec50271193bc', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001V05', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'dbebf004-ff5a-4ad1-a217-d8c32da21a97', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001V06', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'2e23c167-a988-4de4-88f9-1c0f4a1b2d24', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001V07', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'ca09c99b-0868-4cb8-b023-fe0844814cc0', N'e8b29ea0-4f79-4d3e-b467-6f2c16cb096c', -1, NULL, N'P0001I03', 1, N'e8b29ea0-4f79-4d3e-b467-6f2c16cb096c', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'83ba13b4-56ca-4c5c-a85e-f922e4aea644', N'e8b29ea0-4f79-4d3e-b467-6f2c16cb096c', -1, NULL, N'C5000500', 1, N'e8b29ea0-4f79-4d3e-b467-6f2c16cb096c', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'61c21257-00b2-4f54-8947-dfb2d095d870', N'e8b29ea0-4f79-4d3e-b467-6f2c16cb096c', -1, NULL, N'C5000501', 1, N'e8b29ea0-4f79-4d3e-b467-6f2c16cb096c', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1c6662ec-c42e-4124-bf77-2cce20e3b1c5', N'90cdc72c-36ae-4647-b7ec-aebc4dc81e64', -1, NULL, N'P0001P07', 1, N'90cdc72c-36ae-4647-b7ec-aebc4dc81e64', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'465a67ac-275c-4f18-9e57-ced8c91f8183', N'90cdc72c-36ae-4647-b7ec-aebc4dc81e64', -1, NULL, N'P0001U02', 1, N'90cdc72c-36ae-4647-b7ec-aebc4dc81e64', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'5fc0bfa8-09b4-4736-a2e3-420ee4d033e3', N'90cdc72c-36ae-4647-b7ec-aebc4dc81e64', -1, NULL, N'P0001U03', 1, N'90cdc72c-36ae-4647-b7ec-aebc4dc81e64', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'e562e676-33b0-48b9-8cfd-7ac8c209548b', N'90cdc72c-36ae-4647-b7ec-aebc4dc81e64', -1, NULL, N'P0001U05', 1, N'90cdc72c-36ae-4647-b7ec-aebc4dc81e64', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'18e9f839-a305-4316-a078-df4580875dce', N'90cdc72c-36ae-4647-b7ec-aebc4dc81e64', -1, NULL, N'P0001U16', 1, N'90cdc72c-36ae-4647-b7ec-aebc4dc81e64', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'705932cf-fe3c-4411-97f8-a04107e3ad13', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', -1, NULL, N'P0001I08', 1, N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1b7f23bf-b23a-471a-b253-b40684034f00', N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', -1, NULL, N'P0001I11', 1, N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'7dc02c7e-7e76-44c3-a441-1ae4762862b1', N'b5572063-6304-482c-8f38-2ba978188d7c', -1, NULL, N'P0001I10', 1, N'b5572063-6304-482c-8f38-2ba978188d7c', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'61313d45-6827-46f0-bf3b-3a0d3f0dfd99', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001I04', 1, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'6c8ed35a-ddec-4e94-a189-c83339982512', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001I04', 2, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'9f99771d-8077-43d5-a1d2-bf2e9f5015d7', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001I08', 2, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'458836c1-52e7-4b0e-8985-3c8317a8b58a', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001I11', 2, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'b5a32f29-7cb1-491f-a6a2-a7d923e4a6e8', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001A01', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'7fb81d59-8d52-466e-98ab-576196521889', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001A02', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'9efcbcd1-61bb-470c-85cd-324500356c98', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001A03', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'4abf2e5d-24c9-4110-99c6-6088c77ad37d', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001A04', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'f4ba9bae-6aa2-437f-a5cc-253f401f1c7b', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001A05', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'2bfafb9e-90f3-454e-b634-fe31d2ed9641', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001A07', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'beae4334-255a-40c8-bdb0-1b4455af0662', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001A08', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'6bd7143e-8069-4137-bf2d-1bcfb7436805', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001A09', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1b5686ea-d977-454b-a897-fc151b074052', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B01', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'3e015dca-2e25-4420-97ce-65cb59e31cdc', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B02', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'd809f7f8-3fb5-4767-a85c-31a2af56f893', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B04', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'aae3a13c-0df9-4af7-8e74-5b8ccdccdad0', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B05', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'872a8378-237f-4a17-8af8-d2947175821e', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B06', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1d23de32-47e0-4b95-aebe-7ee4ee71a776', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B07', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'10233456-edae-481b-b235-502a7cf66745', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B08', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'c2902908-a145-426f-a646-208bf78203d9', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B09', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'fdfb8cfd-b56a-41d0-a1df-aafd4bcf051b', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B11', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'b23ecb8e-25ad-4457-bc6f-f358251ca249', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B12', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1e32693b-f421-4fa6-8c18-5a6ab9ea0243', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B13', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'ae688844-335b-4894-8982-451ae06141e4', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B14', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'bf7ae546-cad6-45d9-81b7-72ef12b42790', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B15', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'078a942c-bc13-4292-bcf0-f0802aaf7618', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B16', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'd79ea8f8-db64-43e7-af91-5a627d6d9397', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B17', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'7504f63b-f76f-4058-985a-03d171155aef', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B19', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'5eabecc3-66ca-4180-a97a-9ae142daeb31', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B21', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1fc81e7d-61d7-4da4-97fa-95a3a8bb1a16', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B22', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'32b9080e-de78-4a48-af8e-cd670dbc6f50', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B23', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'751def12-59d9-4382-a48d-d65fc401502c', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B27', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'c71ee371-525d-47e8-8871-f2b2d7841a7c', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B34', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'0c0f30ab-04b9-478c-83a0-d6d20bef1de2', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001B35', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'986e1bcf-5d50-4f12-aff2-3031820278e1', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001I06', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'05589299-5c83-4f84-a47c-6efbb11ab870', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001S01', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'4de5f21d-34fc-48bb-9e68-962b0d8737c2', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001S03', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'16ed2789-c941-4b39-8c03-51100f75e4b2', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001S02', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'4d9f476a-b6a1-4358-91a7-b134cce100aa', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001A04', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'211b95c9-b5ae-4542-a45c-a9a47d941f30', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001A05', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2))
GO
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1f15a05b-f878-47a5-8e2e-26ff04e229a6', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001A07', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'34644b2d-78fa-436e-b7c4-46093d640659', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001A08', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'fcda76ac-49e0-4a12-822e-e49fce589d32', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001A09', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'af490e3d-290c-46ec-8173-c50440009be7', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B01', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'c7e04d6e-b94a-4e5f-92c8-6c4d91ebf0b3', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B02', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'2ee487e2-7879-4eca-a424-05f4948dc63c', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B03', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'bcbfeb61-9c7d-4064-9821-65d8ac089e46', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B04', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'6211d3f2-e582-4ed3-9292-a921bc66a331', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B05', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'0dfb60b0-6057-4f48-879f-6f950fa520a5', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B06', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'88e05439-6e94-4f5b-a844-f6f7d0704c00', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B07', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'4554a394-4824-44f0-8e7f-62a5a4df68db', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B08', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'c374990f-4e06-4f48-836d-108ee6e98a2b', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B09', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T11:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'6175ff9c-7a30-42d9-9052-9921b6c2a683', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B11', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'd6aa39a2-7255-42a3-8102-a1500a669808', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B12', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'191fb3a8-2bb4-4a74-8a57-e85522612256', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B13', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'e55d37c8-75d6-4e7d-85aa-2927c07aee46', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B14', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'27461015-bf25-4583-aad6-3b921b1fa922', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B15', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1ceb6613-b0cb-4214-8e70-02ea37f8b36a', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B16', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'd165804f-7196-46f0-b786-c2df2f54bb6a', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B17', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'9ff1a53d-ac0a-487f-a4d1-d87509f6d885', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B18', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1439508d-33ae-4d63-89f7-0fdf39901d6b', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B19', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'c3da169e-7999-475d-8dbc-cbd70e5fb784', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B21', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'a8d13bc4-dc14-48d8-8c93-d8a32409804f', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B22', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'e576e940-f7cd-40ac-a423-62c1347805db', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B23', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'4a2241c4-c26f-414b-84c4-95b7e8278793', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B27', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'c23f94a0-99fb-47e8-aee9-ce7527f21d4f', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B34', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'31660d6e-5c85-4a27-b0df-7070a383c7ab', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001B35', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'c30c36cf-7a86-4bf3-a22e-f9712fdee91e', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001I01', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'8c639a93-2ffe-4d59-a516-5a5e91a80964', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001I02', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'44f49c4c-72fa-4827-9866-3cc4e23df18c', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001I03', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'85605341-69ee-400b-8276-b603603f0a7e', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001I09', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'd19603a0-6cd9-4b2a-8f76-6ff57c49193c', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001I10', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'e19e9435-bfc4-4131-8217-9ab4ac3d9010', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001N01', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'0bfd91b8-64e0-492a-92f1-71e2c2e22902', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001N04', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'fa069191-dd79-4094-88c3-d1ff5f81947a', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001N05', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'71d6fd84-07bf-4c83-bfcc-f44e2f4988bd', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001N06', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'2d84c904-8ae6-4dc9-9df9-f7e949299937', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001N10', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'dcc007bb-c92d-437a-81ee-7771d0500136', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001N11', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'993bb9aa-4ace-4c9b-8043-04226140cb9f', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001P01', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'd64c5d5c-98ac-48bb-bbd6-132ecbb6ac1b', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001P02', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'c1ef8821-c8e9-4f44-b3ab-af38c7696b3e', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001P03', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'c3cb3c55-3bf9-4e1d-b5e5-b3880a074e13', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001P07', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'185a1224-cdf7-49fa-b55d-1b7693c179a7', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001S01', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'f0bf3420-8127-4713-ae0e-717f7ef64ac7', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001S02', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'67524730-eee2-49a2-9d5b-a59828c22887', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001S03', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'ea401ede-54dc-4b4d-97d7-b6a7e9b7cc43', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001S04', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'220f66c3-2ca2-45ea-89d0-e42f34378769', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001S06', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'f3120da7-c5c1-4ecd-a8f8-3cf5efc7af7c', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001S07', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'5c98be22-4a16-4424-ad76-34a4598a8b60', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001S09', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'7381ff39-1acf-4435-bbf0-80775e2261fd', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001S11', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'9249c2d0-611c-445c-a4ba-43277841a8c4', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001S12', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'2db889b2-870b-4f71-a749-fbf2d7c61762', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001S13', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'e4d38fa6-4f53-406f-80f3-655993ad2251', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U01', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'c638984c-5c06-41f9-a7ed-a017447e532b', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U02', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'cb9d1193-4b3d-40c5-97e1-8297e8cc5079', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U03', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'dcb682b3-f67a-49f5-afbb-765392f2aa34', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U04', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'34e08a2d-b981-4fd2-9376-11808a14fad3', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U05', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'4a69ad3f-a103-4f95-929f-d3b790afd54d', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U06', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'44e9bb70-ba76-4389-a016-b2cb52473338', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U07', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'b1a7e58c-7b08-43b0-b18d-3db509563089', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U08', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'de3055e5-c631-4c46-80cc-164650ae5ce4', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U09', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'12343cf9-dc77-4545-8ef4-0c566396a21a', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U10', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'8ce20fe8-cabb-494a-94bb-b8b77c6e7a07', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U11', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'd9060382-62aa-4350-ac90-bc3b8444d29c', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U12', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'f1860c6b-fbf6-41d9-9cb9-5ca4cd1165d6', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U13', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'f228f9f4-9e92-4857-8f86-aafee6cf6eb5', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U14', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'99959b87-3b00-43f0-9557-6c923ab9193b', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U15', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'36844624-1ef8-46b0-a37e-b11eb3a96ae6', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U16', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'bdf04f2f-b37e-42ff-bd4d-49cdea9b0160', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001U17', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'32901faa-6741-4eda-a3c0-ad1050bf3daa', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001V01', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1b846737-e300-45e5-b939-f5d3eb82feca', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001V02', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'202c0802-7421-4dc5-ae2f-92f9ee9fef9d', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001V03', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'5cf0ceb6-e641-44d0-943f-816f8ffb7968', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001V04', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'cc7ebb34-016f-4dd8-950d-b5794a4c7784', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001V05', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'0546b0ed-3f75-40e8-a9de-2a0cdbb00cc7', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001V06', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'93e3dc4b-afad-40ea-9863-7bff648acd36', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001V07', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'c76a46ae-d9a3-4395-9654-c65f458e2b61', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'C5000500', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'390ceecf-8998-4d8b-b542-87bfd34febd9', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'C5000501', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'268d2f82-b46d-45eb-a48a-caf419a61050', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001I04', 3, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'485a4c64-c481-4f70-a54a-5135f49edabd', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001I05', 3, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'8a99fee2-ecd8-4491-8b60-3b3a8f4fba21', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001I07', 3, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'ddc518b8-65db-4cb2-ad59-9fb6268a08d6', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001I05', 1, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'ad76a139-50d7-4f79-b066-600a126274dd', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001I06', 1, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'01f2194f-04fb-45d3-8412-6cf6f19487d1', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001I07', 1, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'd1faac71-d1de-4857-a092-0e90989deced', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001B36', 2, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'cfcad6f2-7cbe-435f-bb27-0bf43128d28d', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001I05', 2, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'dfac4fb4-ba7f-4677-a8a3-b740bb2c216b', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001I06', 2, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'796daae9-2139-480d-a8ec-50ab01b2a4e3', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001I07', 2, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'24a9a418-2bac-4466-a5e9-c0a1311a13d9', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001I01', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'95105477-5a06-413b-b607-20d975aba26b', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001I02', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'4165ddcc-82d1-495d-962a-742b90e254c6', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001I03', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'8c171f2d-a0e6-4493-bdcb-2d97c4d676af', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001I08', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'f4e79691-c486-4baf-89dc-06ffa84d66c8', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001I09', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'ab7c392e-f8dc-4def-88b6-dbbed4dce194', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001I10', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1a2fb656-8374-4a0a-a677-8e9586799c55', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001I11', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2), CAST(N'2020-12-05T14:45:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'cc9becda-82c7-495a-80fc-f92dfebb5c56', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001N01', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'dcd8b862-ce7e-4e7b-a0de-d9e2759c371c', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001N04', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'1710d7df-8b1e-4940-9f26-1e22e0c93a3f', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001N05', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'63b49480-2657-4b21-94ce-768d7b3b7c09', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001N06', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'ddcf1571-6047-4fa2-b800-f8982c6a76c2', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001N10', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
GO
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'16e868bb-f3ec-4f29-be0d-0be905b6195b', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001N11', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'bb03d223-fc38-4eda-bf3e-6121f0e389a1', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001P01', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'93d33122-9078-4d40-b975-178e29255b63', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001P02', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'c691ca02-38f4-48e5-a4a7-59ac4ac59228', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001P03', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'b80d3535-0358-4a0a-a756-71debf883888', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001P07', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'b63d90fd-cea7-4224-a1a3-2403c8ad1fb4', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001U01', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'a3ef35ba-efa8-47b9-98eb-c13e1afd2a74', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001U02', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'b1c95d09-0d87-45f2-9680-a37e26cb6959', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001U03', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'4ef5ea47-86f4-4b1f-a6f3-8a248c79d2b9', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001U04', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'3a5ec9c5-d4bb-4cf5-8dcb-726c7e5c277b', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001U05', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'17830f26-3eea-40f7-aae3-75988c94a2d0', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001U15', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'4c0b933d-7162-4994-b638-201a9521d9f5', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001U16', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'399fb189-7704-40ee-98ca-c9bcdeae7059', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001V01', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'2344264b-46da-4d4c-9f5a-09d7eb08f392', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001V02', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'428759d5-6771-47af-a9fa-ba30a19e9b72', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001V03', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'f4cb549a-5145-4103-889b-3479ce9378e3', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001V04', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'9be7b2bf-8df8-4247-b706-4f7fe25d7a71', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001V05', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'77a3dd55-e3b6-42d0-9807-4d4b4b10c600', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001V06', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'5fbf7c8d-fde2-4be7-9851-51347e9f0ede', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001V07', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'9ec5a769-1ab6-48f3-8cfc-505f7697bcaf', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'C5000500', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'09c8ed87-d579-4e99-9da6-fb57c79da69b', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'C5000501', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'69c06afa-9955-4b6e-99ca-d1a0bf475e5a', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', -1, NULL, N'P0001S06', 3, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-06T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-06T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'55b7cbc6-c41d-4e76-8163-005e5bf4049c', N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', -1, NULL, N'P0001V08', 1, N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2), CAST(N'2020-12-04T11:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'05014416-aa8a-4ee6-ac5b-804fff69e63f', N'ae773b72-c4c8-49ab-83e4-cad324f727f9', -1, NULL, N'P0001V08', 2, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2), CAST(N'2020-12-05T12:15:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'e24a8cbc-b67e-4095-b43c-282c76ef203e', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', -1, NULL, N'P0001V08', 3, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2), CAST(N'2020-12-05T15:00:52.8259294' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'932a3b3d-d27f-4448-9992-5f9f71aeae0f', N'00000000-0000-0000-0000-000000000000', 1, N'test', N'33', 1, NULL, N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2024-02-01T05:44:56.6693145' AS DateTime2), CAST(N'2024-02-01T05:45:01.8141737' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'a6c9a55d-066d-4659-be8c-eaf0b4e0a773', N'26628075-8eee-4496-a3bc-66025432aa7a', 1, N'c0012', N'19', 1, N'00000000-0000-0000-0000-000000000000', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2024-02-01T11:04:58.1973911' AS DateTime2), CAST(N'2024-02-01T11:04:58.1973919' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'dadbc29c-b0e9-428c-b107-815f630071bb', N'26628075-8eee-4496-a3bc-66025432aa7a', 1, N'test04', N'2', 1, N'00000000-0000-0000-0000-000000000000', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2024-02-01T08:30:41.4637138' AS DateTime2), CAST(N'2024-02-01T08:30:41.4637143' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'8a5f1d3a-fcdc-45cc-a00a-23133869f9b7', N'26628075-8eee-4496-a3bc-66025432aa7a', 1, N'test044', N'1', 1, N'00000000-0000-0000-0000-000000000000', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2024-02-01T08:33:53.0440549' AS DateTime2), CAST(N'2024-02-01T08:33:53.0440556' AS DateTime2))
INSERT [dbo].[tAuthority] ([Id], [idUser], [ApprovalLimit], [CostCenter], [RefCode], [UserRole], [IdMigrate], [IdClient], [DateCreated], [DateUpdated]) VALUES (N'e2848308-6e04-42d9-9c29-84765315116f', N'26628075-8eee-4496-a3bc-66025432aa7a', 12, N't1', N'1', 12, N'00000000-0000-0000-0000-000000000000', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2024-02-01T11:05:45.1765343' AS DateTime2), CAST(N'2024-02-01T11:05:45.1765350' AS DateTime2))
GO
INSERT [dbo].[tClient] ([Id], [DateCreated], [DateUpdated], [TitleClient], [idCurrencyClient], [FlagTemplate], [StartOfBusinessYear], [DATEVClientNumber], [IdMigrate], [idReferenceGroupDefault]) VALUES (N'affe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-07-12T06:55:46.6958499' AS DateTime2), CAST(N'2020-07-12T06:55:46.7108074' AS DateTime2), N'DATEV SKR-04', N'acfe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, 1, NULL, NULL, NULL)
INSERT [dbo].[tClient] ([Id], [DateCreated], [DateUpdated], [TitleClient], [idCurrencyClient], [FlagTemplate], [StartOfBusinessYear], [DATEVClientNumber], [IdMigrate], [idReferenceGroupDefault]) VALUES (N'eb70f962-b9ca-4604-bb76-59845e8c84df', CAST(N'2020-07-12T06:55:46.7177887' AS DateTime2), CAST(N'2020-07-12T06:55:46.7247712' AS DateTime2), N'Unit Test', N'acfe524a-9795-ea11-806f-9cb6d0f9cfb6', 0, 1, 31761, NULL, NULL)
INSERT [dbo].[tClient] ([Id], [DateCreated], [DateUpdated], [TitleClient], [idCurrencyClient], [FlagTemplate], [StartOfBusinessYear], [DATEVClientNumber], [IdMigrate], [idReferenceGroupDefault]) VALUES (N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-07-12T06:49:13.6484935' AS DateTime2), CAST(N'2021-11-07T16:11:40.0106237' AS DateTime2), N'saperatec GmbH', N'acfe524a-9795-ea11-806f-9cb6d0f9cfb6', 0, 1, 31761, NULL, N'923d4c97-d3bd-4ba3-9c7f-af9030da967c')
GO
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'424b5e14-bd2a-4169-8104-d2d114185491', CAST(N'2020-07-12T07:06:32.3520274' AS DateTime2), CAST(N'2024-01-10T08:02:57.8140385' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C1000', N'Verwaltung, zentral', N'Administration, central', 0, N'Allgemeine Verwaltung (Finanzen, HR, Allg. Einkauf). Büroaufwand Bielefeld. Teamassistenz', NULL, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'ae773b72-c4c8-49ab-83e4-cad324f727f9')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'772987dd-b499-489c-91b3-f09d2cf94754', CAST(N'2020-07-12T07:06:32.4541872' AS DateTime2), CAST(N'2023-11-01T15:08:19.4447409' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C1500', N'IT', N'IT', 0, N'Allgemeine IT-Infrastruktur und Software', NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'8a20cde9-0374-4a25-9c14-a76c30ee6462', CAST(N'2020-07-12T07:06:32.5364290' AS DateTime2), CAST(N'2023-11-01T15:09:21.3861636' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C2000', N'Anlagenengineering', N'Plant Engineering', 0, N'COO, Engineering-Personal', NULL, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'b37eff03-82b5-452d-8170-da4edab346ce', CAST(N'2020-07-12T07:06:32.6169778' AS DateTime2), CAST(N'2023-11-01T15:10:30.2964820' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C3000', N'F&E, zentral', N'R&D', 0, N'CTO, Chemiker', NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'ae773b72-c4c8-49ab-83e4-cad324f727f9')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'ccb7bed2-18dd-438a-9757-3478f09e8072', CAST(N'2020-07-12T07:06:32.6945863' AS DateTime2), CAST(N'2023-11-01T15:12:42.3818300' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C3100', N'Labor Bielefeld', N'Lab Bielefeld', 0, N'Chemisch-Physikalischen Labor Bielefeld', NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'ae773b72-c4c8-49ab-83e4-cad324f727f9')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'b69fc001-1312-4a54-91f7-04bad6efd6ba', CAST(N'2020-07-12T07:06:32.7804146' AS DateTime2), CAST(N'2023-11-01T15:12:46.8039589' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C3200', N'Technikum Bielefeld', N'Test plant Bielefeld', 0, N'Pilotanlage Technikum Bielefeld', NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'ae773b72-c4c8-49ab-83e4-cad324f727f9')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'b0c5e8a1-8ac4-4631-800f-7acc539d8547', CAST(N'2020-07-12T07:06:32.9495032' AS DateTime2), CAST(N'2023-11-01T15:19:54.2956022' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0001', N'Anlage Dessau', N'Plant Dessau', 1, N'Projektentwicklung Dessau. Externe Anlagenplanung, -beschaffung und Inbetriebnahme', NULL, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'c6cd442c-3ab6-4960-ba3c-bc2220da6624', CAST(N'2020-07-12T07:06:33.0315803' AS DateTime2), CAST(N'2023-11-01T15:21:42.7863919' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0002', N'H2020 FlexPack', N'H2020 FlexPack', 1, N'Planung FlexPack Demonstration', NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'ff3255bb-fec5-4eed-8526-49365f4189a3', CAST(N'2020-11-17T14:43:30.9174072' AS DateTime2), CAST(N'2023-11-01T15:21:44.8646243' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0003', N'Kundenprojekt MCPP', N'Client Project MCPP', 1, NULL, NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'd55c3137-7411-43aa-b1d1-d15fea7f3c30', CAST(N'2020-11-17T14:43:56.9057428' AS DateTime2), CAST(N'2023-11-01T15:22:31.7578481' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0004', N'Projekt Business Central', N'Project Business Central', 1, NULL, NULL, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'ae773b72-c4c8-49ab-83e4-cad324f727f9')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'c58a3b30-31f1-4820-94a5-55dfd91b0819', CAST(N'2020-11-25T15:01:28.0408840' AS DateTime2), CAST(N'2023-11-01T15:23:42.1363881' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0006', N'Kundenprojekt Apple Display Recycling', N'Client Project Apple Display Recycling', 1, NULL, NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'ac4a402f-988c-422b-bf9b-133dda330f6c', CAST(N'2020-11-25T15:02:35.3101328' AS DateTime2), CAST(N'2023-11-01T15:23:46.2928284' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0005', N'Kundenprojekt EZB Recycling Banknoten', N'Client Project ECB Recycling Bank Notes', 1, NULL, NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'8326cd96-61dc-44e0-93f3-0ea6f10cf14d', CAST(N'2020-12-07T14:03:24.9545902' AS DateTime2), CAST(N'2023-11-01T15:28:23.1058274' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0009', N'Kundenprojekt PepsiCo Pilot', N'Client Project PepsiCo Pilot', 1, N'Technikumsversuche für PepsiCo', NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'6a38a1cf-6857-4944-809e-f85ed7ee55df', CAST(N'2021-02-08T18:05:26.4444259' AS DateTime2), CAST(N'2023-11-01T15:24:23.5916376' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0007', N'ABBA Projektentwicklung', N'ABBA project development', 1, NULL, NULL, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'ae773b72-c4c8-49ab-83e4-cad324f727f9')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'b8bb0e0f-91a3-4e34-ade5-a6eb04497cf7', CAST(N'2021-02-08T18:08:10.9778111' AS DateTime2), CAST(N'2023-11-01T15:28:16.0585350' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0008', N'Projekt PreZero', N'Project PreZero', 1, NULL, NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'80d2dd36-4b23-46a6-892f-0b4e0c196ae2', CAST(N'2021-03-18T13:53:50.1664306' AS DateTime2), CAST(N'2023-11-01T15:28:30.3249529' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0010', N'Kundenprojekt Amcor', N'Client Project Amcor', 1, NULL, NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'c9069be3-3349-495e-b160-9306b977c6d6', CAST(N'2021-11-11T16:18:26.4351068' AS DateTime2), CAST(N'2023-11-01T15:28:32.6375149' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0011', N'Agro2Circular', N'Agro2Circular', 1, NULL, NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'26e4a053-08ea-407a-a1e6-f6ac0928e811', CAST(N'2022-01-27T18:04:06.2538691' AS DateTime2), CAST(N'2023-11-01T15:28:36.2627137' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0012', N'Deinking Verfahrensentwicklung', N'Deinking Process development', 1, NULL, NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'53bb6878-036a-44ef-aa75-9a42df8fdec4', CAST(N'2022-01-27T18:05:55.3978163' AS DateTime2), CAST(N'2023-11-01T15:28:40.3255040' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0013', N'Faser/Fluff-Produktentwicklung', N'Faser/Fluff-Product development', 1, NULL, NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'1e42ee99-7662-4227-afc1-ef0e179b8b3e', CAST(N'2022-01-27T18:06:26.8303651' AS DateTime2), CAST(N'2023-11-01T15:28:44.2006402' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0014', N'Kunststoffentfaserung Verfahrensentwicklung', N'Plastic defibration Process development', 1, NULL, NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'11ba1735-be08-4471-9401-95ed0356035d', CAST(N'2022-01-27T18:09:20.6364887' AS DateTime2), CAST(N'2023-11-01T15:28:52.2323628' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0016', N'Alu-Recycling Produkt- und Verfahrensentwicklung', N'Alu-Recycling Product and Process development', 1, NULL, NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'f6a9c1ee-4187-499f-adac-e989b828f4e6', CAST(N'2022-01-27T18:10:07.5879165' AS DateTime2), CAST(N'2023-11-01T15:28:58.0451277' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0018', N'Debonding on Demand TESA', N'Debonding on Demand TESA', 1, NULL, NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'536085a6-784c-47da-a86e-c4c30e4d9cb2', CAST(N'2022-10-06T15:05:32.4782104' AS DateTime2), CAST(N'2023-11-01T15:17:12.7076614' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C5000', N'Operations, zentral', N'Production central', 0, NULL, NULL, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'c2ff9212-0d89-4897-8445-d2b7d4ef2ff1', CAST(N'2022-10-06T15:21:28.7353380' AS DateTime2), CAST(N'2023-11-01T15:12:54.8669234' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C3300', N'F&E Technikum Dessau', N'Test Plant Dessau', 0, NULL, NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'ae773b72-c4c8-49ab-83e4-cad324f727f9')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'657ac91c-27a9-4de9-a46e-23147561df68', CAST(N'2022-10-26T10:27:22.9165722' AS DateTime2), CAST(N'2024-01-10T08:19:57.0025368' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C0000', N'Bilanzielle Buchungen', N'Balance Sheet Transactions', 1, NULL, NULL, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'83e780b3-1c84-458c-a556-193549d7d621', CAST(N'2023-01-16T09:59:35.3766254' AS DateTime2), CAST(N'2023-11-01T15:29:08.9676689' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0019', N'Projekt Apple II', NULL, 1, NULL, NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'233cb80d-0250-4d5d-93c7-03cd8ca14604', CAST(N'2023-01-16T10:00:26.2841814' AS DateTime2), CAST(N'2023-11-01T15:29:13.7491446' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0020', N'Forschungszulage (FZulG)', N'', 1, NULL, NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'f42ff530-eae6-4be4-93c9-5bbebbaa4464', CAST(N'2023-10-19T13:25:22.6773742' AS DateTime2), CAST(N'2023-11-01T15:17:29.8181216' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C5100', N'Supply Chain', N'Supply Chain', 0, N'Einkauf, Logistik, Fuhrpark, Stoffstrommanagement', NULL, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'3d164316-37e4-4f65-a741-c785731ef2b8', CAST(N'2023-10-19T13:26:45.6007387' AS DateTime2), CAST(N'2023-11-01T15:17:32.2714134' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C5200', N'Instandhaltung', N'Maintenance', 0, N'Anlageninstandhaltung', NULL, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'21bf5126-a29f-4f76-a5df-ab566a1e59cb', CAST(N'2023-10-19T13:29:15.0920147' AS DateTime2), CAST(N'2023-11-01T15:17:35.0372367' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C5300', N'Produktion', N'Production', 0, N'Produktionsleitung', NULL, N'ae773b72-c4c8-49ab-83e4-cad324f727f9', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'56e395c6-439b-46c3-a9af-866d8ad0b362', CAST(N'2023-10-19T13:30:05.5873985' AS DateTime2), CAST(N'2023-10-19T13:30:56.9849531' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C5310', N'Produktion Schicht 1', N'Production shift 1', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'3c570061-20cc-4d16-b953-b172ad62b716', CAST(N'2023-10-19T13:30:59.1386288' AS DateTime2), CAST(N'2023-10-19T13:31:33.7985077' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C5320', N'Produktion Schicht 2', N'Production shift 2', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'1e478909-d5b3-46e7-be29-78430f6f0cc1', CAST(N'2023-10-19T13:31:35.4025722' AS DateTime2), CAST(N'2023-10-19T13:37:44.1052939' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C5330', N'Produktion Schicht 3', N'Production shift 3', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'a6d2d028-be68-493b-9fa2-1e2e60f9f379', CAST(N'2023-10-19T13:37:45.8777687' AS DateTime2), CAST(N'2023-10-19T13:38:09.4654803' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C5340', N'Produktion Schicht 4', N'Production shift 4', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'629c607f-378a-493d-bf43-aa3adbe66337', CAST(N'2023-10-19T13:38:17.5683813' AS DateTime2), CAST(N'2023-10-19T13:38:41.3103403' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C5350', N'Produktion Schicht 5', N'Production shift 5', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'38fa9e93-8eae-495e-951a-fd71ee0f9574', CAST(N'2020-07-12T07:06:32.8582341' AS DateTime2), CAST(N'2023-11-01T15:14:04.4487583' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C4000', N'Geschäftsentwicklung', N'Business Development', 0, N'CEO, Marketing, Vertrieb, Messen', NULL, N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'bd23a852-0be3-4b99-aebd-fdc74cf5dc8a', CAST(N'2022-01-27T18:08:48.3954261' AS DateTime2), CAST(N'2023-11-01T15:28:47.7321006' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0015', N'Kunststoff-Produktentwicklung', N'Plastic Product development', 1, NULL, NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'4e2e6529-5602-4c7f-afdd-fdbff1d7af71', CAST(N'2022-01-27T18:09:49.2847029' AS DateTime2), CAST(N'2023-11-01T15:28:55.1387093' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'P0017', N'Post-Consumer Recycling Verfahrensentwicklung', N'Post-Consumer Recycling Process development', 1, NULL, NULL, N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca')
INSERT [dbo].[tCostCenter] ([Id], [DateCreated], [DateUpdated], [idClient], [CostCenterCode], [TitleCostCenter], [TitleEnglishCostCenter], [FlagProfitCenter], [DescriptionCostCenter], [IdMigrate], [idBudgetResponsible], [idExecutiveApprover]) VALUES (N'1493c844-e403-421f-af0a-c4b292e487e3', CAST(N'2024-01-10T08:33:30.1045507' AS DateTime2), CAST(N'2024-01-10T08:33:30.9638296' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'c00', N's', N's', 1, N'w', NULL, NULL, NULL)
GO
INSERT [dbo].[tCurrency] ([Id], [DateCreated], [DateUpdated], [CurrencyCode], [TitleCurrency], [IdMigrate]) VALUES (N'acfe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-07-12T06:49:13.6236596' AS DateTime2), CAST(N'2020-07-12T06:49:13.6297702' AS DateTime2), N'EUR', N'Euro', NULL)
INSERT [dbo].[tCurrency] ([Id], [DateCreated], [DateUpdated], [CurrencyCode], [TitleCurrency], [IdMigrate]) VALUES (N'adfe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-07-12T06:55:45.3198950' AS DateTime2), CAST(N'2020-07-12T06:55:45.3286656' AS DateTime2), N'USD', N'US Dollar', NULL)
INSERT [dbo].[tCurrency] ([Id], [DateCreated], [DateUpdated], [CurrencyCode], [TitleCurrency], [IdMigrate]) VALUES (N'aefe524a-9795-ea11-806f-9cb6d0f9cfb6', CAST(N'2020-07-12T06:55:45.3393793' AS DateTime2), CAST(N'2020-07-12T06:55:45.3419831' AS DateTime2), N'GBP', N'Great Britain Pound', NULL)
INSERT [dbo].[tCurrency] ([Id], [DateCreated], [DateUpdated], [CurrencyCode], [TitleCurrency], [IdMigrate]) VALUES (N'a0f36ec7-3756-4672-8842-f5ca717e3da3', CAST(N'2020-07-12T06:55:45.3440229' AS DateTime2), CAST(N'2020-07-12T06:55:45.3450613' AS DateTime2), N'SGD', N'Singapore Dollar', NULL)
GO
INSERT [dbo].[tReferenceGroup] ([Id], [DateCreated], [DateUpdated], [idClient], [TypeReferenceGroup], [TitleReferenceGroup], [BaseCode], [NextNum], [FlagAutoGen], [AutoDigits], [IdMigrate]) VALUES (N'95164563-fd24-4bca-9cac-d21c1876e3d3', CAST(N'2020-07-12T07:06:33.2513618' AS DateTime2), CAST(N'2021-11-07T15:58:09.4063625' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'I', N'Inventar', N'00', 1, 0, 2, NULL)
INSERT [dbo].[tReferenceGroup] ([Id], [DateCreated], [DateUpdated], [idClient], [TypeReferenceGroup], [TitleReferenceGroup], [BaseCode], [NextNum], [FlagAutoGen], [AutoDigits], [IdMigrate]) VALUES (N'923d4c97-d3bd-4ba3-9c7f-af9030da967c', CAST(N'2020-07-12T07:06:33.3291533' AS DateTime2), CAST(N'2021-11-07T16:11:22.1041211' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'C', N'Allgemein', N'00', 1, 0, 2, NULL)
INSERT [dbo].[tReferenceGroup] ([Id], [DateCreated], [DateUpdated], [idClient], [TypeReferenceGroup], [TitleReferenceGroup], [BaseCode], [NextNum], [FlagAutoGen], [AutoDigits], [IdMigrate]) VALUES (N'5c0fa1db-db72-421d-bf51-bee469e2c8f9', CAST(N'2022-01-09T11:13:12.3055267' AS DateTime2), CAST(N'2022-01-09T11:33:46.1304994' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'S', N'Spesen', N'00', 1, 0, 2, NULL)
INSERT [dbo].[tReferenceGroup] ([Id], [DateCreated], [DateUpdated], [idClient], [TypeReferenceGroup], [TitleReferenceGroup], [BaseCode], [NextNum], [FlagAutoGen], [AutoDigits], [IdMigrate]) VALUES (N'387a2457-68e3-48f9-bdf1-ec3a9f797c25', CAST(N'2020-07-12T07:06:33.1345676' AS DateTime2), CAST(N'2021-11-07T15:58:08.5469035' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'E', N'Mitarbeiter', N'00', 1, 0, 2, NULL)
INSERT [dbo].[tReferenceGroup] ([Id], [DateCreated], [DateUpdated], [idClient], [TypeReferenceGroup], [TitleReferenceGroup], [BaseCode], [NextNum], [FlagAutoGen], [AutoDigits], [IdMigrate]) VALUES (N'd88cc51e-5702-4eb5-8a67-fff7d0cae798', CAST(N'2022-01-09T11:12:27.3043999' AS DateTime2), CAST(N'2022-01-09T11:13:14.4930563' AS DateTime2), N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', N'T', N'Zeiterfassung', N'00', 1, 0, 2, NULL)
GO
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'a16d4875-a9d3-4d8f-a6b6-56cac70f7c4b', CAST(N'2023-12-13T04:57:30.3101715' AS DateTime2), CAST(N'2023-12-13T04:57:30.5539387' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'0bdd74c6-9a52-4710-a92f-8e62a345672d', CAST(N'2023-12-13T13:58:12.8167609' AS DateTime2), CAST(N'2023-12-13T13:58:13.0468765' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'4b3057b2-1a3a-45d4-948b-f9b932229a23', CAST(N'2023-12-13T14:10:57.2045816' AS DateTime2), CAST(N'2023-12-13T14:10:57.2121358' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'6ed9a421-010d-4385-8aa8-743e927ee6bc', CAST(N'2023-12-14T05:21:34.3953649' AS DateTime2), CAST(N'2023-12-14T05:21:34.5359534' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'68cd315f-fa1f-46a4-b29c-20b0c016bc98', CAST(N'2023-12-15T04:56:03.9965896' AS DateTime2), CAST(N'2023-12-15T04:56:04.1590474' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'421108f8-21f9-4cd0-acef-f533c7e8b0f0', CAST(N'2023-12-15T05:10:33.7222545' AS DateTime2), CAST(N'2023-12-15T05:10:33.7417688' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'b9a7ee46-0ca5-4bc8-8e94-0c8e0f251fa9', CAST(N'2023-12-15T05:20:42.3647624' AS DateTime2), CAST(N'2023-12-15T05:20:42.7527239' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'edee1d2a-35ea-4ee2-8372-a5d3483b7eef', CAST(N'2023-12-15T05:25:45.5210478' AS DateTime2), CAST(N'2023-12-15T05:25:45.9201934' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'949c0b47-6b92-42f8-8528-d8f8f54d161f', CAST(N'2023-12-15T05:42:48.1406425' AS DateTime2), CAST(N'2023-12-15T05:42:48.3459964' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'8d132d53-0a11-4723-b1f9-ab9de24bdcfb', CAST(N'2023-12-15T05:43:28.0965713' AS DateTime2), CAST(N'2023-12-15T05:43:28.5399091' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'294f5a3c-fe18-45e8-91c3-87db90845a8c', CAST(N'2023-12-21T05:06:06.8370070' AS DateTime2), CAST(N'2023-12-21T05:06:07.2245809' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'a285a0c3-5b88-4851-9db6-87143aaa7fba', CAST(N'2023-12-21T06:43:47.7032856' AS DateTime2), CAST(N'2023-12-21T06:43:48.0977243' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'eebc9ffd-04d2-44b8-85a9-b94862fddcda', CAST(N'2023-12-26T14:04:22.3806096' AS DateTime2), CAST(N'2023-12-26T14:04:22.6267627' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'bba29862-4f4c-431b-9648-e98c915ba487', CAST(N'2023-12-26T14:49:29.3257574' AS DateTime2), CAST(N'2023-12-26T14:49:29.4801438' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'614ef5c1-7684-46dd-b422-18e241e10b92', CAST(N'2024-01-07T09:44:38.6218287' AS DateTime2), CAST(N'2024-01-07T09:44:38.8253517' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'87f48a0e-b899-488a-bda9-d6a552f19c40', CAST(N'2024-01-07T10:10:49.0042538' AS DateTime2), CAST(N'2024-01-07T10:10:49.0266725' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'6a4313d8-abb0-4392-832f-4f229fc2b052', CAST(N'2024-01-07T15:49:48.0164254' AS DateTime2), CAST(N'2024-01-07T15:49:48.3778948' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'a18a639e-6dcb-4b11-8e7f-8175ccb7aac2', CAST(N'2024-01-09T13:38:47.3253938' AS DateTime2), CAST(N'2024-01-09T13:38:47.3439899' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'0bcf1710-c85d-4711-badf-26e762ee7820', CAST(N'2024-01-09T14:12:47.8753730' AS DateTime2), CAST(N'2024-01-09T14:12:48.2993636' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'f6ae8187-fda2-4955-a52a-8b279c25b716', CAST(N'2024-01-11T09:02:21.3896624' AS DateTime2), CAST(N'2024-01-11T09:02:21.6093880' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'474f7b54-8850-48e1-a33e-6564d9cfbdec', CAST(N'2024-01-11T09:09:44.3476565' AS DateTime2), CAST(N'2024-01-11T09:09:44.5525826' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'0d91c191-79e3-4841-9a9b-c74c3c82c1e9', CAST(N'2024-01-11T09:25:58.7213018' AS DateTime2), CAST(N'2024-01-11T09:25:58.7349870' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'e618adca-72a2-468b-b79a-f3ac93c269ff', CAST(N'2024-01-11T09:26:29.2528822' AS DateTime2), CAST(N'2024-01-11T09:26:29.6769842' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'bcbb8062-ed14-48bb-a1b5-d2029ba4a979', CAST(N'2024-01-11T10:19:31.9856795' AS DateTime2), CAST(N'2024-01-11T10:19:32.2478023' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'2c731fb5-a1eb-4b8d-87a3-485954ae1ac6', CAST(N'2024-01-11T12:01:59.1169521' AS DateTime2), CAST(N'2024-01-11T12:01:59.4934516' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'2f4b0a13-ec5e-4646-9830-9751b85c8750', CAST(N'2024-01-11T12:09:24.3028107' AS DateTime2), CAST(N'2024-01-11T12:09:24.6589502' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'7e6488f3-11f3-4c08-a84c-37223daefff6', CAST(N'2024-01-12T08:46:47.8847511' AS DateTime2), CAST(N'2024-01-12T08:46:48.2860312' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'7875768c-5503-4dae-91c9-8b2a70269aaf', CAST(N'2024-01-12T13:16:14.2194520' AS DateTime2), CAST(N'2024-01-12T13:16:14.2463748' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'a2108ba6-d73c-47d4-8971-af8e3c1b1c8c', CAST(N'2024-01-18T09:57:47.4110596' AS DateTime2), CAST(N'2024-01-18T09:58:39.0270611' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'bebe52e2-a62f-467b-96c9-77a387798357', CAST(N'2024-01-18T10:05:59.1653649' AS DateTime2), CAST(N'2024-01-18T10:05:59.6127879' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'9a6e5ab3-6037-480e-8845-daf0dd2c3b07', CAST(N'2024-01-20T05:24:47.4101654' AS DateTime2), CAST(N'2024-01-20T05:24:47.6097988' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'abfb4f81-20a3-44f3-a81a-d795fa2c34fe', CAST(N'2024-01-20T05:32:57.6881782' AS DateTime2), CAST(N'2024-01-20T05:32:58.0831347' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'4a85fbf8-670b-4d8a-9efb-39a890003328', CAST(N'2024-01-20T05:45:03.4835205' AS DateTime2), CAST(N'2024-01-20T05:45:03.8839579' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'b36bab1b-6d63-4483-ac5d-fd19f4fba8b7', CAST(N'2024-01-20T05:59:45.4921975' AS DateTime2), CAST(N'2024-01-20T05:59:45.9059758' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'd5df7966-5a99-4d04-9562-ed96ad4040e2', CAST(N'2024-01-20T06:17:51.8327383' AS DateTime2), CAST(N'2024-01-20T06:17:52.3940928' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'd0b995d0-0bef-4fcb-ab0a-8621b4a1f7a0', CAST(N'2024-01-20T06:29:54.2464507' AS DateTime2), CAST(N'2024-01-20T06:29:54.6498569' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'e8b7c1c9-d4be-43c4-8c37-1dc735743286', CAST(N'2024-01-20T11:43:04.6407825' AS DateTime2), CAST(N'2024-01-20T11:43:04.8712484' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'08a4a640-0761-4db6-9382-9a6c7fc06065', CAST(N'2024-01-22T05:01:13.1138364' AS DateTime2), CAST(N'2024-01-22T05:01:13.2777840' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'80d2419c-1716-4309-a119-8218b57d62bf', CAST(N'2024-01-22T05:26:34.4520705' AS DateTime2), CAST(N'2024-01-22T05:26:34.4717087' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'ed951c00-553b-4240-a904-2fb4f04c6b8a', CAST(N'2024-01-22T05:27:00.7432790' AS DateTime2), CAST(N'2024-01-22T05:27:00.7446376' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'c28fc47b-4424-438c-a54c-9c19aecc0333', CAST(N'2024-01-22T05:28:22.2052694' AS DateTime2), CAST(N'2024-01-22T05:28:22.2194272' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'89ec0c77-6b38-4cf3-8088-7ee86f597a01', CAST(N'2024-01-23T04:35:51.3403727' AS DateTime2), CAST(N'2024-01-23T04:35:51.3589670' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'7683590c-1d67-4fcb-ab17-367f97db43f4', CAST(N'2024-01-29T05:16:43.1520046' AS DateTime2), CAST(N'2024-01-29T05:16:43.3355764' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'5e91a12a-efc7-4134-8237-8b360c884cf4', CAST(N'2024-01-31T08:20:44.4624906' AS DateTime2), CAST(N'2024-01-31T08:20:44.6230436' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'866dbd1d-1fa2-4c9e-b63f-38b5279e58f4', CAST(N'2024-01-31T12:07:34.9114008' AS DateTime2), CAST(N'2024-01-31T12:07:35.0951766' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'1262b02c-a467-44b7-b570-4c5e42193cd0', CAST(N'2024-02-01T04:24:30.4155302' AS DateTime2), CAST(N'2024-02-01T04:24:30.6291429' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'4dd28864-dc3a-473a-9d08-1ca323e4cf1d', CAST(N'2024-02-01T04:31:29.5369325' AS DateTime2), CAST(N'2024-02-01T04:31:29.5517397' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'675e4ef4-ac2d-4335-b1e7-b902c20382cd', CAST(N'2024-02-01T05:52:22.7864339' AS DateTime2), CAST(N'2024-02-01T05:52:23.0879701' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'96a8ca6f-a10d-46d4-8b1f-d51f346cab53', CAST(N'2024-02-01T11:00:41.3843978' AS DateTime2), CAST(N'2024-02-01T11:00:41.7707616' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'ef226615-e6ef-4662-8ba1-c4186425ed41', CAST(N'2024-02-05T11:25:18.0405254' AS DateTime2), CAST(N'2024-02-05T11:25:18.5202684' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'e855cbb4-be45-47b3-8136-65e6f6359010', CAST(N'2024-02-06T08:36:00.5478892' AS DateTime2), CAST(N'2024-02-06T08:36:01.0052361' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'65be44a2-7076-403e-a1e7-5e14909ceae9', CAST(N'2024-02-06T08:41:39.9070049' AS DateTime2), CAST(N'2024-02-06T08:41:40.2799675' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'a24cee30-5d6d-4921-81df-6b9e3c578b6d', CAST(N'2024-02-06T08:44:29.7760166' AS DateTime2), CAST(N'2024-02-06T08:44:30.0895840' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'b9adb26f-1ff6-4b34-95da-d0813dc391d7', CAST(N'2024-02-06T08:49:02.7903959' AS DateTime2), CAST(N'2024-02-06T08:49:03.1367747' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'afa303d0-08c3-47ed-a521-40c1460b6f25', CAST(N'2024-02-06T08:55:50.0927642' AS DateTime2), CAST(N'2024-02-06T08:55:50.4026036' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'103ca51c-6e8e-4161-9067-369b54a2699f', CAST(N'2024-02-06T08:58:47.9969277' AS DateTime2), CAST(N'2024-02-06T08:58:48.3297981' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'54b01ba4-acbe-4715-87b8-59062a06da42', CAST(N'2024-02-06T09:00:21.8009075' AS DateTime2), CAST(N'2024-02-06T09:00:22.1657408' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'ab571562-ce92-46b4-b67a-c3ab71516d1c', CAST(N'2024-02-06T09:20:58.1162636' AS DateTime2), CAST(N'2024-02-06T09:20:58.8583897' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'a7de51c6-2147-44ad-b3ce-058ba422c155', CAST(N'2024-02-06T09:28:01.2376272' AS DateTime2), CAST(N'2024-02-06T09:28:01.5777558' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'f18d6782-7fa0-49ae-9988-64c0fa40f27b', CAST(N'2024-02-06T09:29:23.5776562' AS DateTime2), CAST(N'2024-02-06T09:29:23.9010714' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'f5736c9e-5609-4008-b64c-95c02b2d2732', CAST(N'2024-02-06T09:34:13.1302042' AS DateTime2), CAST(N'2024-02-06T09:34:13.4545668' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'33c285f5-f453-4885-9fae-2e115667a1b1', CAST(N'2024-02-06T09:42:59.2686785' AS DateTime2), CAST(N'2024-02-06T09:42:59.6230481' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'b66a623b-d730-4094-bf01-847e6a111ac2', CAST(N'2024-02-06T09:45:37.7581975' AS DateTime2), CAST(N'2024-02-06T09:45:38.1011991' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'6edcb552-1dc0-4caf-8455-c1503b0d22b5', CAST(N'2024-02-06T10:14:06.3029095' AS DateTime2), CAST(N'2024-02-06T10:14:06.3584006' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'4b90843d-b439-4ec8-9d6d-b20ae7bdf89a', CAST(N'2024-02-06T10:15:43.0790494' AS DateTime2), CAST(N'2024-02-06T10:15:43.2232427' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'227d589f-dd34-452a-803c-4a6a3d66f702', CAST(N'2024-02-06T10:21:50.6291891' AS DateTime2), CAST(N'2024-02-06T10:21:50.9654507' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'73c20a3e-9b7a-4e0b-b5b4-5f5a98e6b544', CAST(N'2024-02-06T10:24:39.9654925' AS DateTime2), CAST(N'2024-02-06T10:24:40.3040200' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'59e8b5bd-d02f-4815-86be-7136fc79c57a', CAST(N'2024-02-06T10:25:40.7912636' AS DateTime2), CAST(N'2024-02-06T10:25:41.1536725' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'33f748ec-9b86-46f6-9547-1d3ee4620f39', CAST(N'2024-02-06T10:58:08.0072153' AS DateTime2), CAST(N'2024-02-06T10:58:08.3069795' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'dccac1fb-7f79-4d7e-b567-66fd4ea2faf6', CAST(N'2024-02-06T11:16:47.2483131' AS DateTime2), CAST(N'2024-02-06T11:16:47.5739285' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'684980e9-67cb-4f4f-8d76-78bbb9ca55eb', CAST(N'2023-12-27T05:21:08.0541647' AS DateTime2), CAST(N'2023-12-27T05:21:08.2871569' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'8193a891-2c45-4362-973f-6608cd924f35', CAST(N'2023-12-27T08:37:48.8780070' AS DateTime2), CAST(N'2023-12-27T08:37:48.9144509' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'a95e6ea8-dcf2-4f82-b803-fdfc035514f0', CAST(N'2023-12-27T08:58:34.1030048' AS DateTime2), CAST(N'2023-12-27T08:58:34.4256640' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'c5a36e0e-d214-4c57-b723-d83e4c440868', CAST(N'2023-12-27T09:06:02.5011546' AS DateTime2), CAST(N'2023-12-27T09:06:02.8166413' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'5a0d3243-60da-4f91-bb54-cf815e10d4ab', CAST(N'2023-12-27T09:12:02.2013147' AS DateTime2), CAST(N'2023-12-27T09:12:02.2053861' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'b2c55b02-3215-439d-9263-390f9b4e6522', CAST(N'2023-12-27T09:24:51.1115814' AS DateTime2), CAST(N'2023-12-27T09:24:51.4951687' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'21e43f65-b93e-46ff-8564-8ed30652fa44', CAST(N'2023-12-27T09:26:09.1678943' AS DateTime2), CAST(N'2023-12-27T09:26:09.1799507' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'02990f6a-b8b1-4ad5-a5d5-bf38990fb18d', CAST(N'2023-12-28T05:07:46.6615901' AS DateTime2), CAST(N'2023-12-28T05:07:46.8482757' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'71c521d6-6060-40dc-8bdc-5bcef955df4e', CAST(N'2024-01-05T04:43:03.2324830' AS DateTime2), CAST(N'2024-01-05T04:43:03.4032921' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'27c5af44-e2cc-4560-ba56-6345d3c763aa', CAST(N'2024-01-07T10:37:14.1855670' AS DateTime2), CAST(N'2024-01-07T10:37:14.5711216' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'c72812e8-2a49-4c46-853a-3554711815d1', CAST(N'2024-01-07T15:00:19.2365492' AS DateTime2), CAST(N'2024-01-07T15:00:19.6353045' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'91acb13c-373c-4c89-82a2-89a20bdd225e', CAST(N'2024-01-08T05:09:09.4176473' AS DateTime2), CAST(N'2024-01-08T05:09:09.7496803' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'c50217a1-9f8d-4664-b3aa-0179b343add7', CAST(N'2024-01-09T10:06:51.6181352' AS DateTime2), CAST(N'2024-01-09T10:06:56.3673614' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'cb2ccb25-a859-4244-9ce7-1fb5ca2d0270', CAST(N'2024-01-09T13:28:57.4338778' AS DateTime2), CAST(N'2024-01-09T13:28:58.3439486' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'44d2b5fd-1ffe-4400-9e38-b62c5564be3c', CAST(N'2024-01-10T07:59:31.9925937' AS DateTime2), CAST(N'2024-01-10T07:59:32.3612735' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'73b5888c-8573-4c50-a3c8-f34715ac5bac', CAST(N'2024-01-10T08:02:57.8229762' AS DateTime2), CAST(N'2024-01-10T08:02:57.8313808' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'aa7d216c-5b66-4b1f-b891-fb14c3a935b1', CAST(N'2024-02-01T05:41:18.5214467' AS DateTime2), CAST(N'2024-02-01T05:41:18.8435981' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'6d86a1c1-fc0c-4315-89c4-ef063c90129f', CAST(N'2024-02-06T09:44:07.8191036' AS DateTime2), CAST(N'2024-02-06T09:44:08.1223478' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'b14a8785-ac81-46e7-8b78-61feec95ee54', CAST(N'2024-01-12T10:02:35.7774102' AS DateTime2), CAST(N'2024-01-12T10:02:35.8091931' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'b2d41ce8-844b-4441-a373-f3cdd749f597', CAST(N'2024-01-12T13:00:51.3183807' AS DateTime2), CAST(N'2024-01-12T13:00:51.5572194' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'020d24ec-4be3-4d06-9056-c9061bbaf7c1', CAST(N'2024-01-18T10:54:55.2190992' AS DateTime2), CAST(N'2024-01-18T10:54:55.6669855' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'f6aa91bc-94c7-4542-9c1d-fa8f0517f774', CAST(N'2024-01-20T13:42:43.1086079' AS DateTime2), CAST(N'2024-01-20T13:42:43.3229533' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'91fcfde2-fc1b-44d5-9b26-56e269a07fdf', CAST(N'2024-01-23T04:28:20.4872022' AS DateTime2), CAST(N'2024-01-23T04:28:20.6836244' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'b5f07f30-d2fd-4a0e-af1e-6e8504b2a57e', CAST(N'2024-01-23T05:12:58.3723521' AS DateTime2), CAST(N'2024-01-23T05:12:58.7381587' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'351eaf18-7228-4fff-9eb7-d156215e739c', CAST(N'2024-01-24T08:19:45.5235315' AS DateTime2), CAST(N'2024-01-24T08:19:45.7356831' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'afaf8637-d7dd-4218-9669-124b1e77320d', CAST(N'2024-01-24T08:22:49.4395135' AS DateTime2), CAST(N'2024-01-24T08:22:49.7771462' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'e90398f2-5f8b-4721-a93b-6020638977a3', CAST(N'2024-02-01T09:23:40.2684955' AS DateTime2), CAST(N'2024-02-01T09:23:40.2841505' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'd661ad5e-c00c-4eae-8723-86c1743cba4c', CAST(N'2024-02-01T09:40:57.3408561' AS DateTime2), CAST(N'2024-02-01T09:40:57.6527573' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
INSERT [dbo].[tSession] ([Id], [DateCreated], [DateUpdated], [idUser], [idClient], [IdMigrate]) VALUES (N'cf61f900-7577-4847-96c8-591f81276abb', CAST(N'2024-02-05T11:04:50.4919461' AS DateTime2), CAST(N'2024-02-05T11:04:50.7989090' AS DateTime2), N'26628075-8eee-4496-a3bc-66025432aa7a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', NULL)
GO
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'4a3eba2f-aefe-4ab6-a880-5d195dc42aca', CAST(N'2020-11-07T22:23:52.8259294' AS DateTime2), CAST(N'2023-11-17T07:44:10.2174975' AS DateTime2), N'Thorsten Hornung', N'thornung@saperatec.de', N'UFLe0yklejQrSS/6gKGMDvNpbB+dfvUZAhDB6aNcVUhnRb5r', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, N'C:\Users\thors\OneDrive - saperatec\Finance\Test', N'C:\Users\thors\OneDrive\Desktop\verum_Test Budget Tool Bearbeitung.xlsm', NULL, 20000, N'TH')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'003d2e06-d4e3-41f9-9c80-8b1ec7d2c2c9', CAST(N'2022-07-22T09:55:26.1074984' AS DateTime2), CAST(N'2023-10-06T13:41:51.9099266' AS DateTime2), N'Sarah Treffkorn', N'streffkorn@saperatec.de', N'iuhQuM4tQWq49wOKzu807oRsKgq5CLiYXgKxlgJazb0NxTZJ', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 0, NULL, NULL, NULL, 0, N'ST')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'05042b18-5709-4b63-b502-93a6b72da5c2', CAST(N'2022-07-22T10:03:21.2151992' AS DateTime2), CAST(N'2023-10-06T13:41:57.8788753' AS DateTime2), N'Nancy Seifert', N'nseifert@saperatec.de', N'5EPOG/cIzVM7RHjz5G6LcRyJ94BUY+vE3V3XcV31KcMgh5Va', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 0, NULL, NULL, NULL, 1000, N'NS')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'5715eaa3-a0e2-48ca-bf81-82636a806399', CAST(N'2023-01-10T12:22:16.1473173' AS DateTime2), CAST(N'2023-11-17T13:07:48.0750140' AS DateTime2), N'Berit Windus', N'bwindus@saperatec.de', N'JtBqNVgOs6cDUApT7YbzQpXQp8h98cQpdwvc6ZYUitOOPGoL', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 0, N'S:\Buchhaltung\Buchungsbelege 2023\10-2023\FiBu-Auswertung\ENTWURF nach 3. Lauf\Journale', N'C:\Users\bwindus\saperatec\Verwaltung - Dokumente\Finance\0 Masterdateien\verum_Test Budget Tool\verum_Test Budget Tool.xlsm', NULL, 1000, N'BW')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'26628075-8eee-4496-a3bc-66025432aa7a', CAST(N'2023-05-12T11:29:44.3698695' AS DateTime2), CAST(N'2024-01-07T11:19:30.9732147' AS DateTime2), N'Developer1', N'developer1-sap@saperatec.de ', N'MqPaKtCJGseqQc6UvS3uOxHATJ9wfzlQmOrNhoyDNCltLNKM', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 0, N'DS')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', CAST(N'2023-11-01T15:23:52.8259294' AS DateTime2), CAST(N'2023-11-07T12:39:09.0366892' AS DateTime2), N'Sebastian Kernbaum', N'skernbaum@saperatec.de', N'6f5a2122e6d16ff35954e064fbb539e8eedad409', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, N'', N'', N'da667923-249f-4b7e-a0b4-71f18a5f5dfa', 20000, N'SK')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'e8b29ea0-4f79-4d3e-b467-6f2c16cb096c', CAST(N'2020-11-07T06:49:13.6595140' AS DateTime2), CAST(N'2023-11-10T15:38:24.4143517' AS DateTime2), N'Christian Splisdisser', N'csplisdisser@saperatec.de', N'e8b29ea0-4f79-4d3e-b467-6f2c16cb096c', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 0, N'CS')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'23659c75-6839-4a6f-8e61-5fd9699b2a72', CAST(N'2020-11-07T06:49:13.6595140' AS DateTime2), CAST(N'2023-11-07T12:37:06.4352180' AS DateTime2), N'Christin Friedrich', N'cfriedrich@saperatec.de', N'5ae7b5f2d6e02d25cea0b52c3a2a12b0d91405f2', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 1000, N'CF')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'8dcd404c-55c8-42a1-b842-7711f3f4dcd3', CAST(N'2020-11-07T06:49:13.6595140' AS DateTime2), CAST(N'2023-11-07T12:37:11.9822905' AS DateTime2), N'Dr. Dennis Max Meisel', N'dmeisel@saperatec.de', N'0d94299f73a82bb50c258fce9171969254b1620a', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 1000, N'DM')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'fbfc62ff-3544-4ee6-a207-8877a329c3c2', CAST(N'2020-11-07T06:49:13.6595140' AS DateTime2), CAST(N'2023-11-10T14:56:40.8053364' AS DateTime2), N'Jeremy Stenger', N'jstenger@saperatec.de', N'3fbd1909193bec61bf05639e5d041a4f32d76e26', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 0, N'JS')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'7bf07b63-b2ce-4026-a3cb-3c66b9ad43fa', CAST(N'2020-11-07T06:49:13.6595140' AS DateTime2), CAST(N'2023-11-07T09:11:35.5485269' AS DateTime2), N'Jörg Uhding', N'juhding@saperatec.de', N'509a1e6af8fe52f58276150ed3a2f50ec5938290', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 0, N'JU')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'b5572063-6304-482c-8f38-2ba978188d7c', CAST(N'2020-11-07T06:49:13.6595140' AS DateTime2), CAST(N'2023-11-09T09:01:41.1864275' AS DateTime2), N'Marcus Burock', N'mburock@saperatec.de', N'1fa5c6d19e8328587ce744b04e53a5f58d206016', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 1000, N'MB')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'795fd2eb-2ab8-4ff7-a13e-3c6b0a75c412', CAST(N'2020-11-07T06:49:13.6595140' AS DateTime2), CAST(N'2023-11-07T09:24:01.7503916' AS DateTime2), N'Mario Wendler', N'mwendler@saperatec.de', N'99b4e4785ec0638069bb6b8b2806878db4f5e1f4', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 0, N'MW')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'0b56b2f4-e474-4cc0-9e60-2a2a70d63332', CAST(N'2020-11-07T06:49:13.6595140' AS DateTime2), CAST(N'2023-11-07T12:45:17.6388930' AS DateTime2), N'Oliver Stöcker', N'ostoecker@saperatec.de', N'989c54b269f809c872359205876496337017b8aa', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 1000, N'OS')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'3334c30a-3bf9-4c8a-a328-5dd66c732a95', CAST(N'2020-11-07T06:49:13.6595140' AS DateTime2), CAST(N'2023-11-10T15:03:04.1332942' AS DateTime2), N'Lena Küchler', N'lkuechler@saperatec.de', N'fafb09aa2c49eecaafe5db2154ad31660ee907da', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 0, N'LK')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'1b951374-3298-ea11-8071-9cb6d0f9cfb6', CAST(N'2020-07-12T06:49:13.6595140' AS DateTime2), CAST(N'2023-10-06T13:41:31.1904983' AS DateTime2), N'Test Controller', N'test_controller', N'taPoSw6iNxeeI94657+fJHBEo73wcKgAual/9Zt7Nf31no9p', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, N'C:\Users\Thorsten\OneDrive - saperatec\Finance\5. Controlling\Journals\Neu', N'C:\Laufwerke\Buchhaltung_Personal-Ordner\Controlling\Budget & Forecast\2020-08 Forecast\2020.08 Forecast verum_TestImport.xlsx', NULL, 0, N'TC')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'447db13b-d864-440d-91ce-d09734ab3fc3', CAST(N'2020-11-07T22:20:00.9550129' AS DateTime2), CAST(N'2023-11-07T12:42:30.5215094' AS DateTime2), N'Thomas Litka', N'tlitka@saperatec.de', N'MOfx6XKIDmgLZ6dv7bYyg3t0U9il/PJ6WSYDLcauHGR8BHrw', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 0, N'C:\Users\tlitka\Documents\Buchhaltung\Monatsabschluss\2023-08\Entwurf\j', N'C:\Users\tlitka\saperatec\Verwaltung - Dokumente\Finance\Controlling\Budget&Forecast\2023-07 Forecast Q3\Arbeitsdateien\verum_Test Budget Tool.xlsm', NULL, 1000, N'TL')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'c82b64d8-0aba-4314-bae1-e223270664fc', CAST(N'2022-04-11T06:50:41.6950954' AS DateTime2), CAST(N'2023-10-06T13:41:47.0817116' AS DateTime2), N'Fabian Friedrich', N'ffriedrich@saperatec.de', N'6gRLadZG212K6CVap+keKsBI6Dd7QhdkkdQ3tQww8Ovit/7F', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 0, N'FF')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'ab0b1f2a-ad0e-4345-ba60-f2dad6519438', CAST(N'2023-06-20T13:20:46.8229995' AS DateTime2), CAST(N'2023-10-06T13:42:16.9732357' AS DateTime2), N'Ayyaz Mehmood', N'amehmood@saperatec.de', N'wrc/mFLFw766WbhrybIM69qwpFFy8ToA8e73owkfzk6WsddA', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 0, NULL, NULL, NULL, 1000, N'AM')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'90cdc72c-36ae-4647-b7ec-aebc4dc81e64', CAST(N'2020-11-07T06:49:13.6595140' AS DateTime2), CAST(N'2023-11-10T15:34:49.8206681' AS DateTime2), N'Sven Bertl', N'SBertl@saperatec.de', N'90cdc72c-36ae-4647-b7ec-aebc4dc81e64', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 0, N'SB')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'ae773b72-c4c8-49ab-83e4-cad324f727f9', CAST(N'2023-11-01T16:23:52.8259294' AS DateTime2), CAST(N'2023-11-01T15:02:49.2232493' AS DateTime2), N'Lars Stock', N'lstock@saperatec.de', N'5AeKIjg777vQ1hhhkKAmwkT0pUXPzE4GCmINnII9yuWqyaqU', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, N'', N'', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 20000, N'LS')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'2c7038bf-27c1-4e20-b28f-9ec31f26d57b', CAST(N'2020-11-07T06:49:13.6595140' AS DateTime2), CAST(N'2023-11-10T14:55:27.6178910' AS DateTime2), N'Andreas Fütterer', N'afuetterer@saperatec.de', N'79e829306ed43b07b04d14a53c922e608cea3678', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 0, N'AF')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'fe05142f-b42f-4b9b-b4c5-aa34d288acf1', CAST(N'2020-11-07T06:49:13.6595140' AS DateTime2), CAST(N'2023-11-07T12:37:19.0136642' AS DateTime2), N'Frank Wegert', N'fwegert@saperatec.de', N'd16acf21a09e6851602d568b3cb55a0e81d89515', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 1000, N'FW')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'29f7b077-dc0c-465c-b460-a98ab99f2447', CAST(N'2020-11-07T06:49:13.6595140' AS DateTime2), CAST(N'2023-11-07T12:44:38.2155229' AS DateTime2), N'Jürgen Deinert', N'jdeinert@saperatec.de', N'11c55600a739cfd9e3d7c895b8551a4dcc494b5d', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 1000, N'JD')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'8c6b1628-d927-43e1-b9b5-f4b0fbdba8cf', CAST(N'2020-11-07T06:49:13.6595140' AS DateTime2), CAST(N'2023-11-07T12:45:09.0917258' AS DateTime2), N'Dr. Marcus Schulze', N'mschulze@saperatec.de', N'8ca93f3f7ee1304b173aa972b2f72a5257c06817', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 1000, N'MS')
INSERT [dbo].[tUser] ([Id], [DateCreated], [DateUpdated], [UserName], [UserLogin], [UserPasswordHash], [idClientDefault], [TypeUser], [DATEVImportFolder], [DataImportFolder], [IdMigrate], [ApprovalLimit], [UserCode]) VALUES (N'750c0eb3-6462-40e1-85dc-f38d6448a65c', CAST(N'2020-11-07T06:49:13.6595140' AS DateTime2), CAST(N'2023-11-10T15:03:24.1176719' AS DateTime2), N'René Rothkamm', N'rrothkamm@saperatec.de', N'2f43ad7fa9e6c66f8ccadcae8ddb5dac701d22ba', N'b0fe524a-9795-ea11-806f-9cb6d0f9cfb6', 1, NULL, NULL, NULL, 0, N'RR')
GO
/****** Object:  Index [PK__tAccount__3214EC0606DC0B0F]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tAccount] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tAccount_Code]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tAccount_Code] ON [dbo].[tAccount]
(
	[idClient] ASC,
	[AccountCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tAccount_idAccountGroup]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tAccount_idAccountGroup] ON [dbo].[tAccount]
(
	[idAccountGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tAccount_idAccountReporting]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tAccount_idAccountReporting] ON [dbo].[tAccount]
(
	[idAccountReporting] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tAccount__3214EC06E3FFDDED]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tAccountGroup] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tAccountGroup_idClient]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tAccountGroup_idClient] ON [dbo].[tAccountGroup]
(
	[idClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tAccount__3214EC0600257E68]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tAccountMainGroup] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tAccountMainGroup_MainGroupOrder]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tAccountMainGroup_MainGroupOrder] ON [dbo].[tAccountMainGroup]
(
	[idAccountSection] ASC,
	[MainGroupOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tAccount__3214EC06A9FE869E]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tAccountSection] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tAccountSection_SectionOrder]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tAccountSection_SectionOrder] ON [dbo].[tAccountSection]
(
	[TypeAccount] ASC,
	[SectionOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tBooking__3214EC0642886971]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tBookingRun] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tBookingRun_idClient]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tBookingRun_idClient] ON [dbo].[tBookingRun]
(
	[idClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tBookRec__3214EC06722AC2FA]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tBookRecord] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tBookRecord_idAccountCredit]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tBookRecord_idAccountCredit] ON [dbo].[tBookRecord]
(
	[idAccountCredit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tBookRecord_idAccountDebit]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tBookRecord_idAccountDebit] ON [dbo].[tBookRecord]
(
	[idAccountDebit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tBookRecord_idBookingRun]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tBookRecord_idBookingRun] ON [dbo].[tBookRecord]
(
	[idBookingRun] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tBookRecord_idClient]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tBookRecord_idClient] ON [dbo].[tBookRecord]
(
	[idClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tBookRecord_idCostCenterBookRecord]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tBookRecord_idCostCenterBookRecord] ON [dbo].[tBookRecord]
(
	[idCostCenterBookRecord] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tBookRecord_idPlanElementInstance]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tBookRecord_idPlanElementInstance] ON [dbo].[tBookRecord]
(
	[idPlanElementInstance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tBookRecord_ReferenceIDBookRecord]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tBookRecord_ReferenceIDBookRecord] ON [dbo].[tBookRecord]
(
	[ReferenceIDBookRecord] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tBookTra__3214EC06EBB92037]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tBookTransaction] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tBookTransaction_idAccountBooking]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idAccountBooking] ON [dbo].[tBookTransaction]
(
	[idAccountBooking] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tBookTransaction_idAccountReport]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idAccountReport] ON [dbo].[tBookTransaction]
(
	[idAccountReport] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tBookTransaction_idBookingRecord]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idBookingRecord] ON [dbo].[tBookTransaction]
(
	[idBookingRecord] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tBookTransaction_idClient]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idClient] ON [dbo].[tBookTransaction]
(
	[idClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tBookTransaction_idCostCenter]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idCostCenter] ON [dbo].[tBookTransaction]
(
	[idCostCenter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tBookTransaction_idPlan]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idPlan] ON [dbo].[tBookTransaction]
(
	[idPlan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tBookTransaction_idPlanElement]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tBookTransaction_idPlanElement] ON [dbo].[tBookTransaction]
(
	[idPlanElement] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tClient__3214EC06F72B0AE1]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tClient] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tClient_idCurrencyClient]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tClient_idCurrencyClient] ON [dbo].[tClient]
(
	[idCurrencyClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tCostCen__3214EC06771C4D92]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tCostCenter] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tCostCenter_Code]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tCostCenter_Code] ON [dbo].[tCostCenter]
(
	[idClient] ASC,
	[CostCenterCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tCurrenc__3214EC06FE81DE4A]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tCurrency] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tCurrenc__3214EC06AFAB6136]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tCurrencyExchangeRate] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tCurrencyExchangeRate_idClient]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tCurrencyExchangeRate_idClient] ON [dbo].[tCurrencyExchangeRate]
(
	[idClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tCurrencyExchangeRate_idCurrencyExchangeRate]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tCurrencyExchangeRate_idCurrencyExchangeRate] ON [dbo].[tCurrencyExchangeRate]
(
	[idCurrencyExchangeRate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tCurrencyExchangeRate_idPlan]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tCurrencyExchangeRate_idPlan] ON [dbo].[tCurrencyExchangeRate]
(
	[idPlan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tCurrencyExchangeRate_RateDate]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tCurrencyExchangeRate_RateDate] ON [dbo].[tCurrencyExchangeRate]
(
	[DateExchangeRate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tDepreci__3214EC06FF72528F]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tDepreciationRule] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tDepreciationRule_idAccountActivation]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tDepreciationRule_idAccountActivation] ON [dbo].[tDepreciationRule]
(
	[idAccountActivation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tDepreciationRule_idAccountDepreciation]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tDepreciationRule_idAccountDepreciation] ON [dbo].[tDepreciationRule]
(
	[idAccountDepreciation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tDepreciationRule_idClient]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tDepreciationRule_idClient] ON [dbo].[tDepreciationRule]
(
	[idClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tJobRepo__3214EC069F051337]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tJobReport] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tJobRepo__3214EC062666F0D0]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tJobReportItem] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlan__3214EC06BE49DC51]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlan] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlan_idClient]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlan_idClient] ON [dbo].[tPlan]
(
	[idClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlan_idPlanBase]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlan_idPlanBase] ON [dbo].[tPlan]
(
	[idPlanBase] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlanAcc__3214EC0676330410]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlanAccountFunction] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanAccountFunction_idAccountPlanAccountFunction]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanAccountFunction_idAccountPlanAccountFunction] ON [dbo].[tPlanAccountFunction]
(
	[idAccountPlanAccountFunction] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanAccountFunction_idClient]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanAccountFunction_idClient] ON [dbo].[tPlanAccountFunction]
(
	[idClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanAccountFunction_TypeAccountFunction]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanAccountFunction_TypeAccountFunction] ON [dbo].[tPlanAccountFunction]
(
	[TypeAccountFunction] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlanAll__3214EC061426BA29]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlanAllocationSchedule] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanAllocationSchedule_idPlan]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanAllocationSchedule_idPlan] ON [dbo].[tPlanAllocationSchedule]
(
	[idPlan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlanAll__3214EC0647BDA484]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlanAllocationScheduleItems] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanAllocationScheduleItems_idPlanAllocationSchedule]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tPlanAllocationScheduleItems_idPlanAllocationSchedule] ON [dbo].[tPlanAllocationScheduleItems]
(
	[idPlanAllocationSchedule] ASC,
	[OrderNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlanEle__3214EC06B4B24DC6]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlanElement] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElement_idClient]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElement_idClient] ON [dbo].[tPlanElement]
(
	[idClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElement_idCostCenterPlanElement]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElement_idCostCenterPlanElement] ON [dbo].[tPlanElement]
(
	[idCostCenterPlanElement] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElement_idCurrency]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElement_idCurrency] ON [dbo].[tPlanElement]
(
	[idCurrency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElement_idPlanGroup]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElement_idPlanGroup] ON [dbo].[tPlanElement]
(
	[idPlanGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tPlanElement_ReferenceIDPlanElement]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElement_ReferenceIDPlanElement] ON [dbo].[tPlanElement]
(
	[ReferenceIDPlanElement] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlanEle__3214EC063905343E]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlanElementBooking] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementBooking_idAccountCredit]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementBooking_idAccountCredit] ON [dbo].[tPlanElementBooking]
(
	[idAccountCredit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementBooking_idAccountDebit]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementBooking_idAccountDebit] ON [dbo].[tPlanElementBooking]
(
	[idAccountDebit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementBooking_idAllocationSchedule]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementBooking_idAllocationSchedule] ON [dbo].[tPlanElementBooking]
(
	[idAllocationSchedule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementBooking_idInflationRule]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementBooking_idInflationRule] ON [dbo].[tPlanElementBooking]
(
	[idInflationRule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementBooking_idParContingencyRate]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementBooking_idParContingencyRate] ON [dbo].[tPlanElementBooking]
(
	[idParContingencyRate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementBooking_idParPrice1]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementBooking_idParPrice1] ON [dbo].[tPlanElementBooking]
(
	[idParPrice1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementBooking_idParPrice2]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementBooking_idParPrice2] ON [dbo].[tPlanElementBooking]
(
	[idParPrice2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementBooking_idPlanInstance]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementBooking_idPlanInstance] ON [dbo].[tPlanElementBooking]
(
	[idPlanInstance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlanEle__3214EC0681FEB196]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlanElementContract] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementContract_idAccountAdvance]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idAccountAdvance] ON [dbo].[tPlanElementContract]
(
	[idAccountAdvance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementContract_idAccountMain]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idAccountMain] ON [dbo].[tPlanElementContract]
(
	[idAccountMain] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementContract_idAllocationSchedule]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idAllocationSchedule] ON [dbo].[tPlanElementContract]
(
	[idAllocationSchedule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementContract_idDepreciationRule]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idDepreciationRule] ON [dbo].[tPlanElementContract]
(
	[idDepreciationRule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementContract_idDepreciationTrigger]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idDepreciationTrigger] ON [dbo].[tPlanElementContract]
(
	[idDepreciationTrigger] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementContract_idInflationRule]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idInflationRule] ON [dbo].[tPlanElementContract]
(
	[idInflationRule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementContract_idParContingencyRate]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idParContingencyRate] ON [dbo].[tPlanElementContract]
(
	[idParContingencyRate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementContract_idParPrice1]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idParPrice1] ON [dbo].[tPlanElementContract]
(
	[idParPrice1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementContract_idParPrice2]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idParPrice2] ON [dbo].[tPlanElementContract]
(
	[idParPrice2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementContract_idParTriggerAdvance]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idParTriggerAdvance] ON [dbo].[tPlanElementContract]
(
	[idParTriggerAdvance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementContract_idPlanInstance]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idPlanInstance] ON [dbo].[tPlanElementContract]
(
	[idPlanInstance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementContract_idVATRule]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementContract_idVATRule] ON [dbo].[tPlanElementContract]
(
	[idVATRule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlanEle__3214EC06F39F590D]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlanElementHR] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementHR_idExpenseGroup]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementHR_idExpenseGroup] ON [dbo].[tPlanElementHR]
(
	[idExpenseGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementHR_idInflationRule]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementHR_idInflationRule] ON [dbo].[tPlanElementHR]
(
	[idInflationRule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementHR_idPlanInstance]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementHR_idPlanInstance] ON [dbo].[tPlanElementHR]
(
	[idPlanInstance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementHR_idTariff]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementHR_idTariff] ON [dbo].[tPlanElementHR]
(
	[idTariff] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlanEle__3214EC06C7185EE9]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlanElementInstance] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementInstance_idParTriggerDueDate]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementInstance_idParTriggerDueDate] ON [dbo].[tPlanElementInstance]
(
	[idParTriggerDueDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementInstance_idPlan]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementInstance_idPlan] ON [dbo].[tPlanElementInstance]
(
	[idPlan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanElementInstance_idPlanElement]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanElementInstance_idPlanElement] ON [dbo].[tPlanElementInstance]
(
	[idPlanElement] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlanGro__3214EC06BEB4AB9E]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlanGroup] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanGroup_idClient]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanGroup_idClient] ON [dbo].[tPlanGroup]
(
	[idClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlanHRE__3214EC064F9FAA7E]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlanHRExpense] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanHRExpense_idAccountExpense]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanHRExpense_idAccountExpense] ON [dbo].[tPlanHRExpense]
(
	[idAccountExpense] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlanHRE__3214EC0602C12D85]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlanHRExpenseGroup] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tPlanHRExpenseGroup_ExpenseGroupIndex]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tPlanHRExpenseGroup_ExpenseGroupIndex] ON [dbo].[tPlanHRExpenseGroup]
(
	[idPlan] ASC,
	[TitleExpenseGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlanHRT__3214EC06FF29E7EF]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlanHRTariff] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanHRTariff_idAccountSalary]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanHRTariff_idAccountSalary] ON [dbo].[tPlanHRTariff]
(
	[idAccountSalary] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tPlanHRTariff_TariffIndex]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tPlanHRTariff_TariffIndex] ON [dbo].[tPlanHRTariff]
(
	[idPlan] ASC,
	[TitleTariff] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlanHRT__3214EC06DE69167B]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlanHRTariffDetail] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlanInf__3214EC06C7CA3225]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlanInflationRule] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlanPar__3214EC06C167F0DF]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlanParameter] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tPlanParameter_PlanTitle]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tPlanParameter_PlanTitle] ON [dbo].[tPlanParameter]
(
	[idPlan] ASC,
	[TypePlanParameter] ASC,
	[TitlePlanParameter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tPlanTra__3214EC06C712DD6E]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tPlanTransaction] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanTransaction_idBookTransaction]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanTransaction_idBookTransaction] ON [dbo].[tPlanTransaction]
(
	[idBookTransaction] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tPlanTransaction_idPlan]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tPlanTransaction_idPlan] ON [dbo].[tPlanTransaction]
(
	[idPlan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tReferen__3214EC0629824E53]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tReferenceCode] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tReferenceCode_Code]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tReferenceCode_Code] ON [dbo].[tReferenceCode]
(
	[idClient] ASC,
	[RefCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tReferenceCode_idReferenceGroup]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tReferenceCode_idReferenceGroup] ON [dbo].[tReferenceCode]
(
	[idReferenceGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tReferen__3214EC065D7A16D2]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tReferenceGroup] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tReferenceGroup_Code]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tReferenceGroup_Code] ON [dbo].[tReferenceGroup]
(
	[idClient] ASC,
	[TypeReferenceGroup] ASC,
	[BaseCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tSession__3214EC06B35C755B]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tSession] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tTypeCod__3214EC06C7C0382E]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tTypeCodeDef] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tTypeCodeDef_TypeCodeDef]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tTypeCodeDef_TypeCodeDef] ON [dbo].[tTypeCodeDef]
(
	[TypeID] ASC,
	[TypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tTypeGro__3214EC06A141FF79]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tTypeGroupDef] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tTypeGroupDef_TypeGroupID]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tTypeGroupDef_TypeGroupID] ON [dbo].[tTypeGroupDef]
(
	[TypeGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tUser__3214EC0664FCEBF0]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tUser] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK__tVATRule__3214EC0679960E9B]    Script Date: 07-Feb-24 10:16:19 AM ******/
ALTER TABLE [dbo].[tVATRule] ADD PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tVATRule_Code]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tVATRule_Code] ON [dbo].[tVATRule]
(
	[idClient] ASC,
	[VATRuleCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tVATRule_iAccountVATBalance]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tVATRule_iAccountVATBalance] ON [dbo].[tVATRule]
(
	[idAccountVATBalance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tVATRule_idAccountVATInput]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tVATRule_idAccountVATInput] ON [dbo].[tVATRule]
(
	[idAccountVATInput] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_tVATRule_idAccountVATOutput]    Script Date: 07-Feb-24 10:16:19 AM ******/
CREATE NONCLUSTERED INDEX [IX_tVATRule_idAccountVATOutput] ON [dbo].[tVATRule]
(
	[idAccountVATOutput] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tAccount] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tAccount] ADD  DEFAULT ((0)) FOR [TypeAccount]
GO
ALTER TABLE [dbo].[tAccount] ADD  DEFAULT ((0)) FOR [FlagPlan]
GO
ALTER TABLE [dbo].[tAccountGroup] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tAccountGroup] ADD  DEFAULT ((0)) FOR [AccountGroupOrder]
GO
ALTER TABLE [dbo].[tAccountGroup] ADD  DEFAULT ((0)) FOR [AccountCodeFrom]
GO
ALTER TABLE [dbo].[tAccountGroup] ADD  DEFAULT ((0)) FOR [AccountCodeTo]
GO
ALTER TABLE [dbo].[tAccountGroup] ADD  DEFAULT ((0)) FOR [TypeAccountDefault]
GO
ALTER TABLE [dbo].[tAccountMainGroup] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tAccountSection] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tAccountSection] ADD  DEFAULT ((0)) FOR [TypeAccount]
GO
ALTER TABLE [dbo].[tAuthority] ADD  CONSTRAINT [DF_tAuthority_UserLimit]  DEFAULT ((-1)) FOR [ApprovalLimit]
GO
ALTER TABLE [dbo].[tBookingRun] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tBookingRun] ADD  DEFAULT ((0)) FOR [VersionCode]
GO
ALTER TABLE [dbo].[tBookingRun] ADD  DEFAULT ((0)) FOR [StatusPreliminary]
GO
ALTER TABLE [dbo].[tBookRecord] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tBookRecord] ADD  DEFAULT ((0)) FOR [FlagOutdated]
GO
ALTER TABLE [dbo].[tBookRecord] ADD  DEFAULT ((0)) FOR [TypeBookRecord]
GO
ALTER TABLE [dbo].[tBookRecord] ADD  DEFAULT ((0)) FOR [FlagAccountOpening]
GO
ALTER TABLE [dbo].[tBookTransaction] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tBookTransaction] ADD  DEFAULT ((0)) FOR [FlagAccountOpening]
GO
ALTER TABLE [dbo].[tBookTransaction] ADD  DEFAULT ((0)) FOR [FlagForecast]
GO
ALTER TABLE [dbo].[tBookTransaction] ADD  CONSTRAINT [DF_tBookTransaction_FlagBaseline]  DEFAULT ((0)) FOR [FlagBaseline]
GO
ALTER TABLE [dbo].[tClient] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tClient] ADD  DEFAULT ((0)) FOR [FlagTemplate]
GO
ALTER TABLE [dbo].[tClient] ADD  DEFAULT ((1)) FOR [StartOfBusinessYear]
GO
ALTER TABLE [dbo].[tCostCenter] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tCostCenter] ADD  DEFAULT ((0)) FOR [FlagProfitCenter]
GO
ALTER TABLE [dbo].[tCurrency] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tCurrencyExchangeRate] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tDepreciationRule] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tDepreciationRule] ADD  DEFAULT ((1)) FOR [PeriodInMonths]
GO
ALTER TABLE [dbo].[tJobReport] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tJobReportItem] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlan] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlan] ADD  DEFAULT ((0)) FOR [PlanFlagBaseline]
GO
ALTER TABLE [dbo].[tPlan] ADD  CONSTRAINT [DF__tPlan__TypeStatu__41EDCAC5]  DEFAULT ((3)) FOR [TypeStatus]
GO
ALTER TABLE [dbo].[tPlanAccountFunction] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlanAllocationSchedule] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlanAllocationSchedule] ADD  DEFAULT ((1)) FOR [MonthsBetweenItems]
GO
ALTER TABLE [dbo].[tPlanAllocationSchedule] ADD  DEFAULT ((0)) FOR [FlagAbsoluteRates]
GO
ALTER TABLE [dbo].[tPlanAllocationSchedule] ADD  DEFAULT ((0)) FOR [AdvanceDelayPeriods]
GO
ALTER TABLE [dbo].[tPlanAllocationSchedule] ADD  DEFAULT ((0)) FOR [FlagAuto]
GO
ALTER TABLE [dbo].[tPlanAllocationScheduleItems] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlanElement] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlanElement] ADD  DEFAULT ((0)) FOR [TypePlanElement]
GO
ALTER TABLE [dbo].[tPlanElement] ADD  DEFAULT ((0)) FOR [ElementFlagBaseline]
GO
ALTER TABLE [dbo].[tPlanElementBooking] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlanElementBooking] ADD  DEFAULT ((0)) FOR [TypeRepeat]
GO
ALTER TABLE [dbo].[tPlanElementBooking] ADD  DEFAULT ((1)) FOR [NumberOfUnits]
GO
ALTER TABLE [dbo].[tPlanElementBooking] ADD  DEFAULT ((0)) FOR [FlagAccountOpening]
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD  DEFAULT ((0)) FOR [TypeRepeat]
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD  DEFAULT ((0)) FOR [AdvanceDelay]
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD  DEFAULT ((0)) FOR [DepreciationDelay]
GO
ALTER TABLE [dbo].[tPlanElementContract] ADD  DEFAULT ((1)) FOR [NumberOfUnits]
GO
ALTER TABLE [dbo].[tPlanElementHR] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlanElementInstance] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlanElementInstance] ADD  DEFAULT ((0)) FOR [FlagUpdate]
GO
ALTER TABLE [dbo].[tPlanElementInstance] ADD  DEFAULT ((0)) FOR [FlagBaseline]
GO
ALTER TABLE [dbo].[tPlanElementInstance] ADD  DEFAULT ((1)) FOR [FlagDateOffset]
GO
ALTER TABLE [dbo].[tPlanElementInstance] ADD  DEFAULT ((0)) FOR [DueDateYear]
GO
ALTER TABLE [dbo].[tPlanElementInstance] ADD  DEFAULT ((0)) FOR [DueDateMonth]
GO
ALTER TABLE [dbo].[tPlanElementInstance] ADD  DEFAULT ((0)) FOR [DueDateDay]
GO
ALTER TABLE [dbo].[tPlanGroup] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlanHRExpense] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlanHRExpense] ADD  DEFAULT ((0)) FOR [RatioToSalary]
GO
ALTER TABLE [dbo].[tPlanHRExpense] ADD  DEFAULT ((0)) FOR [ExpenseAmount]
GO
ALTER TABLE [dbo].[tPlanHRExpense] ADD  DEFAULT ((0)) FOR [SalaryCap]
GO
ALTER TABLE [dbo].[tPlanHRExpense] ADD  DEFAULT ((0)) FOR [DeductFromSalary]
GO
ALTER TABLE [dbo].[tPlanHRExpense] ADD  DEFAULT ((0)) FOR [ApplyToBonusMode]
GO
ALTER TABLE [dbo].[tPlanHRExpenseGroup] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlanHRTariff] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlanHRTariff] ADD  DEFAULT ((28)) FOR [PayDay]
GO
ALTER TABLE [dbo].[tPlanHRTariff] ADD  DEFAULT ((1)) FOR [FlagShared]
GO
ALTER TABLE [dbo].[tPlanHRTariffDetail] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlanHRTariffDetail] ADD  DEFAULT ((40)) FOR [WorkTimeWeekly]
GO
ALTER TABLE [dbo].[tPlanHRTariffDetail] ADD  DEFAULT ((1)) FOR [FTEFactor]
GO
ALTER TABLE [dbo].[tPlanHRTariffDetail] ADD  DEFAULT ((0)) FOR [RatioShiftNight]
GO
ALTER TABLE [dbo].[tPlanHRTariffDetail] ADD  DEFAULT ((0)) FOR [RatioShiftSpecial]
GO
ALTER TABLE [dbo].[tPlanHRTariffDetail] ADD  DEFAULT ((0)) FOR [RatioOvertime]
GO
ALTER TABLE [dbo].[tPlanHRTariffDetail] ADD  DEFAULT ((0)) FOR [AnnualLeave]
GO
ALTER TABLE [dbo].[tPlanHRTariffDetail] ADD  DEFAULT ((0)) FOR [StandardHolidays]
GO
ALTER TABLE [dbo].[tPlanHRTariffDetail] ADD  DEFAULT ((0)) FOR [BaseSalaryMonthly]
GO
ALTER TABLE [dbo].[tPlanHRTariffDetail] ADD  DEFAULT ((0)) FOR [RateShiftNight]
GO
ALTER TABLE [dbo].[tPlanHRTariffDetail] ADD  DEFAULT ((0)) FOR [RateShiftSpecial]
GO
ALTER TABLE [dbo].[tPlanHRTariffDetail] ADD  DEFAULT ((1)) FOR [RateOvertime]
GO
ALTER TABLE [dbo].[tPlanHRTariffDetail] ADD  DEFAULT ((12)) FOR [AnnualBonusMonth]
GO
ALTER TABLE [dbo].[tPlanInflationRule] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlanInflationRule] ADD  DEFAULT ((12)) FOR [InflationInterval]
GO
ALTER TABLE [dbo].[tPlanInflationRule] ADD  DEFAULT ((0)) FOR [InflationRateAnnual]
GO
ALTER TABLE [dbo].[tPlanParameter] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tPlanParameter] ADD  DEFAULT ((0)) FOR [TypePlanParameter]
GO
ALTER TABLE [dbo].[tPlanParameter] ADD  DEFAULT ((0)) FOR [ValueNum]
GO
ALTER TABLE [dbo].[tPlanTransaction] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tReferenceCode] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tReferenceCode] ADD  CONSTRAINT [DF_tReferenceCode_FlagActive]  DEFAULT ((1)) FOR [FlagActive]
GO
ALTER TABLE [dbo].[tReferenceGroup] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tReferenceGroup] ADD  DEFAULT ((0)) FOR [NextNum]
GO
ALTER TABLE [dbo].[tReferenceGroup] ADD  DEFAULT ((1)) FOR [FlagAutoGen]
GO
ALTER TABLE [dbo].[tReferenceGroup] ADD  DEFAULT ((4)) FOR [AutoDigits]
GO
ALTER TABLE [dbo].[tSession] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tTypeCodeDef] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tTypeGroupDef] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tUser] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tUser] ADD  DEFAULT ((0)) FOR [TypeUser]
GO
ALTER TABLE [dbo].[tVATRule] ADD  DEFAULT (sysutcdatetime()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[tVATRule] ADD  DEFAULT ((0)) FOR [FlagReverseCharge]
GO
ALTER TABLE [dbo].[tAccount]  WITH CHECK ADD  CONSTRAINT [FK_tAccount_idAccountGroup] FOREIGN KEY([idAccountGroup])
REFERENCES [dbo].[tAccountGroup] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tAccount] CHECK CONSTRAINT [FK_tAccount_idAccountGroup]
GO
ALTER TABLE [dbo].[tAccount]  WITH CHECK ADD  CONSTRAINT [FK_tAccount_idAccountMainGroup] FOREIGN KEY([idAccountMainGroup])
REFERENCES [dbo].[tAccountMainGroup] ([Id])
GO
ALTER TABLE [dbo].[tAccount] CHECK CONSTRAINT [FK_tAccount_idAccountMainGroup]
GO
ALTER TABLE [dbo].[tAccount]  WITH CHECK ADD  CONSTRAINT [FK_tAccount_idAccountReporting] FOREIGN KEY([idAccountReporting])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tAccount] CHECK CONSTRAINT [FK_tAccount_idAccountReporting]
GO
ALTER TABLE [dbo].[tAccount]  WITH CHECK ADD  CONSTRAINT [FK_tAccount_idAccountSection] FOREIGN KEY([idAccountSection])
REFERENCES [dbo].[tAccountSection] ([Id])
GO
ALTER TABLE [dbo].[tAccount] CHECK CONSTRAINT [FK_tAccount_idAccountSection]
GO
ALTER TABLE [dbo].[tAccountGroup]  WITH CHECK ADD  CONSTRAINT [FK_tAccountGroup_idAccountMainGroup] FOREIGN KEY([idAccountMainGroup])
REFERENCES [dbo].[tAccountMainGroup] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tAccountGroup] CHECK CONSTRAINT [FK_tAccountGroup_idAccountMainGroup]
GO
ALTER TABLE [dbo].[tAccountMainGroup]  WITH CHECK ADD  CONSTRAINT [FK_tAccountMainGroup_idAccountSection] FOREIGN KEY([idAccountSection])
REFERENCES [dbo].[tAccountSection] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tAccountMainGroup] CHECK CONSTRAINT [FK_tAccountMainGroup_idAccountSection]
GO
ALTER TABLE [dbo].[tAccountSection]  WITH CHECK ADD  CONSTRAINT [FK_tAccountSection_idClient] FOREIGN KEY([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tAccountSection] CHECK CONSTRAINT [FK_tAccountSection_idClient]
GO
ALTER TABLE [dbo].[tBookingRun]  WITH CHECK ADD  CONSTRAINT [FK_tBookingRun_idClient] FOREIGN KEY([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tBookingRun] CHECK CONSTRAINT [FK_tBookingRun_idClient]
GO
ALTER TABLE [dbo].[tBookRecord]  WITH CHECK ADD  CONSTRAINT [FK_tBookRecord_idAccountCredit] FOREIGN KEY([idAccountCredit])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tBookRecord] CHECK CONSTRAINT [FK_tBookRecord_idAccountCredit]
GO
ALTER TABLE [dbo].[tBookRecord]  WITH CHECK ADD  CONSTRAINT [FK_tBookRecord_idAccountDebit] FOREIGN KEY([idAccountDebit])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tBookRecord] CHECK CONSTRAINT [FK_tBookRecord_idAccountDebit]
GO
ALTER TABLE [dbo].[tBookRecord]  WITH CHECK ADD  CONSTRAINT [FK_tBookRecord_idBookingRun] FOREIGN KEY([idBookingRun])
REFERENCES [dbo].[tBookingRun] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tBookRecord] CHECK CONSTRAINT [FK_tBookRecord_idBookingRun]
GO
ALTER TABLE [dbo].[tBookRecord]  WITH CHECK ADD  CONSTRAINT [FK_tBookRecord_idClient] FOREIGN KEY([idClient])
REFERENCES [dbo].[tClient] ([Id])
GO
ALTER TABLE [dbo].[tBookRecord] CHECK CONSTRAINT [FK_tBookRecord_idClient]
GO
ALTER TABLE [dbo].[tBookRecord]  WITH CHECK ADD  CONSTRAINT [FK_tBookRecord_idCostCenterBookRecord] FOREIGN KEY([idCostCenterBookRecord])
REFERENCES [dbo].[tCostCenter] ([Id])
GO
ALTER TABLE [dbo].[tBookRecord] CHECK CONSTRAINT [FK_tBookRecord_idCostCenterBookRecord]
GO
ALTER TABLE [dbo].[tBookRecord]  WITH CHECK ADD  CONSTRAINT [FK_tBookRecord_idPlanElementInstance] FOREIGN KEY([idPlanElementInstance])
REFERENCES [dbo].[tPlanElementInstance] ([Id])
GO
ALTER TABLE [dbo].[tBookRecord] CHECK CONSTRAINT [FK_tBookRecord_idPlanElementInstance]
GO
ALTER TABLE [dbo].[tBookTransaction]  WITH CHECK ADD  CONSTRAINT [FK_tBookTransaction_idAccountBooking] FOREIGN KEY([idAccountBooking])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tBookTransaction] CHECK CONSTRAINT [FK_tBookTransaction_idAccountBooking]
GO
ALTER TABLE [dbo].[tBookTransaction]  WITH CHECK ADD  CONSTRAINT [FK_tBookTransaction_idAccountReport] FOREIGN KEY([idAccountReport])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tBookTransaction] CHECK CONSTRAINT [FK_tBookTransaction_idAccountReport]
GO
ALTER TABLE [dbo].[tBookTransaction]  WITH CHECK ADD  CONSTRAINT [FK_tBookTransaction_idBookingRecord] FOREIGN KEY([idBookingRecord])
REFERENCES [dbo].[tBookRecord] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tBookTransaction] CHECK CONSTRAINT [FK_tBookTransaction_idBookingRecord]
GO
ALTER TABLE [dbo].[tBookTransaction]  WITH CHECK ADD  CONSTRAINT [FK_tBookTransaction_idCostCenter] FOREIGN KEY([idCostCenter])
REFERENCES [dbo].[tCostCenter] ([Id])
GO
ALTER TABLE [dbo].[tBookTransaction] CHECK CONSTRAINT [FK_tBookTransaction_idCostCenter]
GO
ALTER TABLE [dbo].[tBookTransaction]  WITH CHECK ADD  CONSTRAINT [FK_tBookTransaction_idPlan] FOREIGN KEY([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
GO
ALTER TABLE [dbo].[tBookTransaction] CHECK CONSTRAINT [FK_tBookTransaction_idPlan]
GO
ALTER TABLE [dbo].[tBookTransaction]  WITH CHECK ADD  CONSTRAINT [FK_tBookTransaction_idPlanElement] FOREIGN KEY([idPlanElement])
REFERENCES [dbo].[tPlanElement] ([Id])
GO
ALTER TABLE [dbo].[tBookTransaction] CHECK CONSTRAINT [FK_tBookTransaction_idPlanElement]
GO
ALTER TABLE [dbo].[tClient]  WITH CHECK ADD  CONSTRAINT [FK_tClient_idCurrencyClient] FOREIGN KEY([idCurrencyClient])
REFERENCES [dbo].[tCurrency] ([Id])
GO
ALTER TABLE [dbo].[tClient] CHECK CONSTRAINT [FK_tClient_idCurrencyClient]
GO
ALTER TABLE [dbo].[tClient]  WITH CHECK ADD  CONSTRAINT [FK_tClient_idReferenceGroup] FOREIGN KEY([idReferenceGroupDefault])
REFERENCES [dbo].[tReferenceGroup] ([Id])
GO
ALTER TABLE [dbo].[tClient] CHECK CONSTRAINT [FK_tClient_idReferenceGroup]
GO
ALTER TABLE [dbo].[tCostCenter]  WITH CHECK ADD  CONSTRAINT [FK_tCostCenter_idClient] FOREIGN KEY([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tCostCenter] CHECK CONSTRAINT [FK_tCostCenter_idClient]
GO
ALTER TABLE [dbo].[tCurrencyExchangeRate]  WITH CHECK ADD  CONSTRAINT [FK_tCurrencyExchangeRate_idClient] FOREIGN KEY([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tCurrencyExchangeRate] CHECK CONSTRAINT [FK_tCurrencyExchangeRate_idClient]
GO
ALTER TABLE [dbo].[tCurrencyExchangeRate]  WITH CHECK ADD  CONSTRAINT [FK_tCurrencyExchangeRate_idCurrencyExchangeRate] FOREIGN KEY([idCurrencyExchangeRate])
REFERENCES [dbo].[tCurrency] ([Id])
GO
ALTER TABLE [dbo].[tCurrencyExchangeRate] CHECK CONSTRAINT [FK_tCurrencyExchangeRate_idCurrencyExchangeRate]
GO
ALTER TABLE [dbo].[tCurrencyExchangeRate]  WITH CHECK ADD  CONSTRAINT [FK_tCurrencyExchangeRate_idPlan] FOREIGN KEY([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
GO
ALTER TABLE [dbo].[tCurrencyExchangeRate] CHECK CONSTRAINT [FK_tCurrencyExchangeRate_idPlan]
GO
ALTER TABLE [dbo].[tDepreciationRule]  WITH CHECK ADD  CONSTRAINT [FK_tDepreciationRule_idAccountActivation] FOREIGN KEY([idAccountActivation])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tDepreciationRule] CHECK CONSTRAINT [FK_tDepreciationRule_idAccountActivation]
GO
ALTER TABLE [dbo].[tDepreciationRule]  WITH CHECK ADD  CONSTRAINT [FK_tDepreciationRule_idAccountDepreciation] FOREIGN KEY([idAccountDepreciation])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tDepreciationRule] CHECK CONSTRAINT [FK_tDepreciationRule_idAccountDepreciation]
GO
ALTER TABLE [dbo].[tDepreciationRule]  WITH CHECK ADD  CONSTRAINT [FK_tDepreciationRule_idClient] FOREIGN KEY([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tDepreciationRule] CHECK CONSTRAINT [FK_tDepreciationRule_idClient]
GO
ALTER TABLE [dbo].[tJobReport]  WITH CHECK ADD  CONSTRAINT [FK_tJobReport_idClient] FOREIGN KEY([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tJobReport] CHECK CONSTRAINT [FK_tJobReport_idClient]
GO
ALTER TABLE [dbo].[tJobReport]  WITH CHECK ADD  CONSTRAINT [FK_tJobReport_idUser] FOREIGN KEY([idUser])
REFERENCES [dbo].[tUser] ([Id])
GO
ALTER TABLE [dbo].[tJobReport] CHECK CONSTRAINT [FK_tJobReport_idUser]
GO
ALTER TABLE [dbo].[tJobReportItem]  WITH CHECK ADD  CONSTRAINT [FK_tJobReportItem_idJobReport] FOREIGN KEY([idJobReport])
REFERENCES [dbo].[tJobReport] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tJobReportItem] CHECK CONSTRAINT [FK_tJobReportItem_idJobReport]
GO
ALTER TABLE [dbo].[tPlan]  WITH CHECK ADD  CONSTRAINT [FK_tPlan_idClient] FOREIGN KEY([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlan] CHECK CONSTRAINT [FK_tPlan_idClient]
GO
ALTER TABLE [dbo].[tPlan]  WITH CHECK ADD  CONSTRAINT [FK_tPlan_idPlanBase] FOREIGN KEY([idPlanBase])
REFERENCES [dbo].[tPlan] ([Id])
GO
ALTER TABLE [dbo].[tPlan] CHECK CONSTRAINT [FK_tPlan_idPlanBase]
GO
ALTER TABLE [dbo].[tPlanAccountFunction]  WITH CHECK ADD  CONSTRAINT [FK_tPlanAccountFunction_idAccountPlanAccountFunction] FOREIGN KEY([idAccountPlanAccountFunction])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tPlanAccountFunction] CHECK CONSTRAINT [FK_tPlanAccountFunction_idAccountPlanAccountFunction]
GO
ALTER TABLE [dbo].[tPlanAccountFunction]  WITH CHECK ADD  CONSTRAINT [FK_tPlanAccountFunction_idClient] FOREIGN KEY([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanAccountFunction] CHECK CONSTRAINT [FK_tPlanAccountFunction_idClient]
GO
ALTER TABLE [dbo].[tPlanAllocationSchedule]  WITH CHECK ADD  CONSTRAINT [FK_tPlanAllocationSchedule_idPlan] FOREIGN KEY([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanAllocationSchedule] CHECK CONSTRAINT [FK_tPlanAllocationSchedule_idPlan]
GO
ALTER TABLE [dbo].[tPlanAllocationScheduleItems]  WITH CHECK ADD  CONSTRAINT [FK_tPlanAllocationScheduleItems_idPlanAllocationSchedule] FOREIGN KEY([idPlanAllocationSchedule])
REFERENCES [dbo].[tPlanAllocationSchedule] ([Id])
GO
ALTER TABLE [dbo].[tPlanAllocationScheduleItems] CHECK CONSTRAINT [FK_tPlanAllocationScheduleItems_idPlanAllocationSchedule]
GO
ALTER TABLE [dbo].[tPlanElement]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElement_idClient] FOREIGN KEY([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanElement] CHECK CONSTRAINT [FK_tPlanElement_idClient]
GO
ALTER TABLE [dbo].[tPlanElement]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElement_idCostCenterPlanElement] FOREIGN KEY([idCostCenterPlanElement])
REFERENCES [dbo].[tCostCenter] ([Id])
GO
ALTER TABLE [dbo].[tPlanElement] CHECK CONSTRAINT [FK_tPlanElement_idCostCenterPlanElement]
GO
ALTER TABLE [dbo].[tPlanElement]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElement_idCurrency] FOREIGN KEY([idCurrency])
REFERENCES [dbo].[tCurrency] ([Id])
GO
ALTER TABLE [dbo].[tPlanElement] CHECK CONSTRAINT [FK_tPlanElement_idCurrency]
GO
ALTER TABLE [dbo].[tPlanElement]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElement_idPlanGroup] FOREIGN KEY([idPlanGroup])
REFERENCES [dbo].[tPlanGroup] ([Id])
GO
ALTER TABLE [dbo].[tPlanElement] CHECK CONSTRAINT [FK_tPlanElement_idPlanGroup]
GO
ALTER TABLE [dbo].[tPlanElementBooking]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementBooking_idAccountCredit] FOREIGN KEY([idAccountCredit])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementBooking] CHECK CONSTRAINT [FK_tPlanElementBooking_idAccountCredit]
GO
ALTER TABLE [dbo].[tPlanElementBooking]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementBooking_idAccountDebit] FOREIGN KEY([idAccountDebit])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementBooking] CHECK CONSTRAINT [FK_tPlanElementBooking_idAccountDebit]
GO
ALTER TABLE [dbo].[tPlanElementBooking]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementBooking_idAllocationSchedule] FOREIGN KEY([idAllocationSchedule])
REFERENCES [dbo].[tPlanAllocationSchedule] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementBooking] CHECK CONSTRAINT [FK_tPlanElementBooking_idAllocationSchedule]
GO
ALTER TABLE [dbo].[tPlanElementBooking]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementBooking_idInflationRule] FOREIGN KEY([idInflationRule])
REFERENCES [dbo].[tPlanInflationRule] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementBooking] CHECK CONSTRAINT [FK_tPlanElementBooking_idInflationRule]
GO
ALTER TABLE [dbo].[tPlanElementBooking]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementBooking_idParContingencyRate] FOREIGN KEY([idParContingencyRate])
REFERENCES [dbo].[tPlanParameter] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementBooking] CHECK CONSTRAINT [FK_tPlanElementBooking_idParContingencyRate]
GO
ALTER TABLE [dbo].[tPlanElementBooking]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementBooking_idParPrice1] FOREIGN KEY([idParPrice1])
REFERENCES [dbo].[tPlanParameter] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementBooking] CHECK CONSTRAINT [FK_tPlanElementBooking_idParPrice1]
GO
ALTER TABLE [dbo].[tPlanElementBooking]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementBooking_idParPrice2] FOREIGN KEY([idParPrice2])
REFERENCES [dbo].[tPlanParameter] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementBooking] CHECK CONSTRAINT [FK_tPlanElementBooking_idParPrice2]
GO
ALTER TABLE [dbo].[tPlanElementBooking]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementBooking_idPlanInstance] FOREIGN KEY([idPlanInstance])
REFERENCES [dbo].[tPlanElementInstance] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanElementBooking] CHECK CONSTRAINT [FK_tPlanElementBooking_idPlanInstance]
GO
ALTER TABLE [dbo].[tPlanElementContract]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementContract_idAccountAdvance] FOREIGN KEY([idAccountAdvance])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementContract] CHECK CONSTRAINT [FK_tPlanElementContract_idAccountAdvance]
GO
ALTER TABLE [dbo].[tPlanElementContract]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementContract_idAccountMain] FOREIGN KEY([idAccountMain])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementContract] CHECK CONSTRAINT [FK_tPlanElementContract_idAccountMain]
GO
ALTER TABLE [dbo].[tPlanElementContract]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementContract_idAllocationSchedule] FOREIGN KEY([idAllocationSchedule])
REFERENCES [dbo].[tPlanAllocationSchedule] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementContract] CHECK CONSTRAINT [FK_tPlanElementContract_idAllocationSchedule]
GO
ALTER TABLE [dbo].[tPlanElementContract]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementContract_idDepreciationRule] FOREIGN KEY([idDepreciationRule])
REFERENCES [dbo].[tDepreciationRule] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementContract] CHECK CONSTRAINT [FK_tPlanElementContract_idDepreciationRule]
GO
ALTER TABLE [dbo].[tPlanElementContract]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementContract_idDepreciationTrigger] FOREIGN KEY([idDepreciationTrigger])
REFERENCES [dbo].[tPlanParameter] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementContract] CHECK CONSTRAINT [FK_tPlanElementContract_idDepreciationTrigger]
GO
ALTER TABLE [dbo].[tPlanElementContract]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementContract_idInflationRule] FOREIGN KEY([idInflationRule])
REFERENCES [dbo].[tPlanInflationRule] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementContract] CHECK CONSTRAINT [FK_tPlanElementContract_idInflationRule]
GO
ALTER TABLE [dbo].[tPlanElementContract]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementContract_idParContingencyRate] FOREIGN KEY([idParContingencyRate])
REFERENCES [dbo].[tPlanParameter] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementContract] CHECK CONSTRAINT [FK_tPlanElementContract_idParContingencyRate]
GO
ALTER TABLE [dbo].[tPlanElementContract]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementContract_idParPrice1] FOREIGN KEY([idParPrice1])
REFERENCES [dbo].[tPlanParameter] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementContract] CHECK CONSTRAINT [FK_tPlanElementContract_idParPrice1]
GO
ALTER TABLE [dbo].[tPlanElementContract]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementContract_idParPrice2] FOREIGN KEY([idParPrice2])
REFERENCES [dbo].[tPlanParameter] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementContract] CHECK CONSTRAINT [FK_tPlanElementContract_idParPrice2]
GO
ALTER TABLE [dbo].[tPlanElementContract]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementContract_idParTriggerAdvance] FOREIGN KEY([idParTriggerAdvance])
REFERENCES [dbo].[tPlanParameter] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementContract] CHECK CONSTRAINT [FK_tPlanElementContract_idParTriggerAdvance]
GO
ALTER TABLE [dbo].[tPlanElementContract]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementContract_idPlanInstance] FOREIGN KEY([idPlanInstance])
REFERENCES [dbo].[tPlanElementInstance] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanElementContract] CHECK CONSTRAINT [FK_tPlanElementContract_idPlanInstance]
GO
ALTER TABLE [dbo].[tPlanElementContract]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementContract_idVATRule] FOREIGN KEY([idVATRule])
REFERENCES [dbo].[tVATRule] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementContract] CHECK CONSTRAINT [FK_tPlanElementContract_idVATRule]
GO
ALTER TABLE [dbo].[tPlanElementHR]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementHR_idExpenseGroup] FOREIGN KEY([idExpenseGroup])
REFERENCES [dbo].[tPlanHRExpenseGroup] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementHR] CHECK CONSTRAINT [FK_tPlanElementHR_idExpenseGroup]
GO
ALTER TABLE [dbo].[tPlanElementHR]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementHR_idInflationRule] FOREIGN KEY([idInflationRule])
REFERENCES [dbo].[tPlanInflationRule] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementHR] CHECK CONSTRAINT [FK_tPlanElementHR_idInflationRule]
GO
ALTER TABLE [dbo].[tPlanElementHR]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementHR_idPlanInstance] FOREIGN KEY([idPlanInstance])
REFERENCES [dbo].[tPlanElementInstance] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanElementHR] CHECK CONSTRAINT [FK_tPlanElementHR_idPlanInstance]
GO
ALTER TABLE [dbo].[tPlanElementHR]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementHR_idTariff] FOREIGN KEY([idTariff])
REFERENCES [dbo].[tPlanHRTariff] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementHR] CHECK CONSTRAINT [FK_tPlanElementHR_idTariff]
GO
ALTER TABLE [dbo].[tPlanElementInstance]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementInstance_idParTriggerDueDate] FOREIGN KEY([idParTriggerDueDate])
REFERENCES [dbo].[tPlanParameter] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementInstance] CHECK CONSTRAINT [FK_tPlanElementInstance_idParTriggerDueDate]
GO
ALTER TABLE [dbo].[tPlanElementInstance]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementInstance_idPlan] FOREIGN KEY([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanElementInstance] CHECK CONSTRAINT [FK_tPlanElementInstance_idPlan]
GO
ALTER TABLE [dbo].[tPlanElementInstance]  WITH CHECK ADD  CONSTRAINT [FK_tPlanElementInstance_idPlanElement] FOREIGN KEY([idPlanElement])
REFERENCES [dbo].[tPlanElement] ([Id])
GO
ALTER TABLE [dbo].[tPlanElementInstance] CHECK CONSTRAINT [FK_tPlanElementInstance_idPlanElement]
GO
ALTER TABLE [dbo].[tPlanGroup]  WITH CHECK ADD  CONSTRAINT [FK_tPlanGroup_idClient] FOREIGN KEY([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanGroup] CHECK CONSTRAINT [FK_tPlanGroup_idClient]
GO
ALTER TABLE [dbo].[tPlanHRExpense]  WITH CHECK ADD  CONSTRAINT [FK_tPlanHRExpense_idAccountExpense] FOREIGN KEY([idAccountExpense])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tPlanHRExpense] CHECK CONSTRAINT [FK_tPlanHRExpense_idAccountExpense]
GO
ALTER TABLE [dbo].[tPlanHRExpense]  WITH CHECK ADD  CONSTRAINT [FK_tPlanHRExpense_idCostCenterFixed] FOREIGN KEY([idCostCenterFixed])
REFERENCES [dbo].[tCostCenter] ([Id])
GO
ALTER TABLE [dbo].[tPlanHRExpense] CHECK CONSTRAINT [FK_tPlanHRExpense_idCostCenterFixed]
GO
ALTER TABLE [dbo].[tPlanHRExpense]  WITH CHECK ADD  CONSTRAINT [FK_tPlanHRExpense_idExpenseGroup] FOREIGN KEY([idExpenseGroup])
REFERENCES [dbo].[tPlanHRExpenseGroup] ([Id])
GO
ALTER TABLE [dbo].[tPlanHRExpense] CHECK CONSTRAINT [FK_tPlanHRExpense_idExpenseGroup]
GO
ALTER TABLE [dbo].[tPlanHRExpenseGroup]  WITH CHECK ADD  CONSTRAINT [FK_tPlanHRExpenseGroup_idPlan] FOREIGN KEY([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanHRExpenseGroup] CHECK CONSTRAINT [FK_tPlanHRExpenseGroup_idPlan]
GO
ALTER TABLE [dbo].[tPlanHRTariff]  WITH CHECK ADD  CONSTRAINT [FK_tPlanHRTariff_idAccountSalary] FOREIGN KEY([idAccountSalary])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tPlanHRTariff] CHECK CONSTRAINT [FK_tPlanHRTariff_idAccountSalary]
GO
ALTER TABLE [dbo].[tPlanHRTariff]  WITH CHECK ADD  CONSTRAINT [FK_tPlanHRTariff_idPlan] FOREIGN KEY([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanHRTariff] CHECK CONSTRAINT [FK_tPlanHRTariff_idPlan]
GO
ALTER TABLE [dbo].[tPlanHRTariffDetail]  WITH CHECK ADD  CONSTRAINT [FK_tPlanHRTariffDetail_idTariff] FOREIGN KEY([idTariff])
REFERENCES [dbo].[tPlanHRTariff] ([Id])
GO
ALTER TABLE [dbo].[tPlanHRTariffDetail] CHECK CONSTRAINT [FK_tPlanHRTariffDetail_idTariff]
GO
ALTER TABLE [dbo].[tPlanInflationRule]  WITH CHECK ADD  CONSTRAINT [FK_tPlanInflationRule_idPlan] FOREIGN KEY([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanInflationRule] CHECK CONSTRAINT [FK_tPlanInflationRule_idPlan]
GO
ALTER TABLE [dbo].[tPlanParameter]  WITH CHECK ADD  CONSTRAINT [FK_tPlanParameter_idPlan] FOREIGN KEY([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanParameter] CHECK CONSTRAINT [FK_tPlanParameter_idPlan]
GO
ALTER TABLE [dbo].[tPlanTransaction]  WITH CHECK ADD  CONSTRAINT [FK_tPlanTransaction_idBookTransaction] FOREIGN KEY([idBookTransaction])
REFERENCES [dbo].[tBookTransaction] ([Id])
GO
ALTER TABLE [dbo].[tPlanTransaction] CHECK CONSTRAINT [FK_tPlanTransaction_idBookTransaction]
GO
ALTER TABLE [dbo].[tPlanTransaction]  WITH CHECK ADD  CONSTRAINT [FK_tPlanTransaction_idPlan] FOREIGN KEY([idPlan])
REFERENCES [dbo].[tPlan] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tPlanTransaction] CHECK CONSTRAINT [FK_tPlanTransaction_idPlan]
GO
ALTER TABLE [dbo].[tReferenceCode]  WITH CHECK ADD  CONSTRAINT [FK_tReferenceCode_idClient] FOREIGN KEY([idClient])
REFERENCES [dbo].[tClient] ([Id])
GO
ALTER TABLE [dbo].[tReferenceCode] CHECK CONSTRAINT [FK_tReferenceCode_idClient]
GO
ALTER TABLE [dbo].[tReferenceCode]  WITH CHECK ADD  CONSTRAINT [FK_tReferenceCode_idReferenceGroup] FOREIGN KEY([idReferenceGroup])
REFERENCES [dbo].[tReferenceGroup] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tReferenceCode] CHECK CONSTRAINT [FK_tReferenceCode_idReferenceGroup]
GO
ALTER TABLE [dbo].[tReferenceGroup]  WITH CHECK ADD  CONSTRAINT [FK_tReferenceGroup_idClient] FOREIGN KEY([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tReferenceGroup] CHECK CONSTRAINT [FK_tReferenceGroup_idClient]
GO
ALTER TABLE [dbo].[tSession]  WITH CHECK ADD  CONSTRAINT [FK_tSession_idClient] FOREIGN KEY([idClient])
REFERENCES [dbo].[tClient] ([Id])
GO
ALTER TABLE [dbo].[tSession] CHECK CONSTRAINT [FK_tSession_idClient]
GO
ALTER TABLE [dbo].[tSession]  WITH CHECK ADD  CONSTRAINT [FK_tSession_idUser] FOREIGN KEY([idUser])
REFERENCES [dbo].[tUser] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tSession] CHECK CONSTRAINT [FK_tSession_idUser]
GO
ALTER TABLE [dbo].[tTypeCodeDef]  WITH CHECK ADD  CONSTRAINT [FK_tTypeCodeDef_idTypeGroupDef] FOREIGN KEY([idTypeGroupDef])
REFERENCES [dbo].[tTypeGroupDef] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tTypeCodeDef] CHECK CONSTRAINT [FK_tTypeCodeDef_idTypeGroupDef]
GO
ALTER TABLE [dbo].[tUser]  WITH CHECK ADD  CONSTRAINT [FK_tUser_idClientDefault] FOREIGN KEY([idClientDefault])
REFERENCES [dbo].[tClient] ([Id])
GO
ALTER TABLE [dbo].[tUser] CHECK CONSTRAINT [FK_tUser_idClientDefault]
GO
ALTER TABLE [dbo].[tVATRule]  WITH CHECK ADD  CONSTRAINT [FK_tVATRule_idAccountVATBalance] FOREIGN KEY([idAccountVATBalance])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tVATRule] CHECK CONSTRAINT [FK_tVATRule_idAccountVATBalance]
GO
ALTER TABLE [dbo].[tVATRule]  WITH CHECK ADD  CONSTRAINT [FK_tVATRule_idAccountVATInput] FOREIGN KEY([idAccountVATInput])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tVATRule] CHECK CONSTRAINT [FK_tVATRule_idAccountVATInput]
GO
ALTER TABLE [dbo].[tVATRule]  WITH CHECK ADD  CONSTRAINT [FK_tVATRule_idAccountVATOutput] FOREIGN KEY([idAccountVATOutput])
REFERENCES [dbo].[tAccount] ([Id])
GO
ALTER TABLE [dbo].[tVATRule] CHECK CONSTRAINT [FK_tVATRule_idAccountVATOutput]
GO
ALTER TABLE [dbo].[tVATRule]  WITH CHECK ADD  CONSTRAINT [FK_tVATRule_idClient] FOREIGN KEY([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tVATRule] CHECK CONSTRAINT [FK_tVATRule_idClient]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tAccount (dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 349
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccountGroup (dbo)"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 301
               Right = 514
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccountMainGroup (dbo)"
            Begin Extent = 
               Top = 6
               Left = 552
               Bottom = 309
               Right = 761
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccountSection (dbo)"
            Begin Extent = 
               Top = 6
               Left = 799
               Bottom = 304
               Right = 987
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2145
         Alias = 3885
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repAccountsWithSections'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repAccountsWithSections'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[7] 4[54] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "i"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e"
            Begin Extent = 
               Top = 6
               Left = 274
               Bottom = 136
               Right = 498
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 536
               Bottom = 136
               Right = 713
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 751
               Bottom = 136
               Right = 959
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4080
         Alias = 2340
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repElementsByPlan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repElementsByPlan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 255
               Bottom = 136
               Right = 459
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "r"
            Begin Extent = 
               Top = 6
               Left = 497
               Bottom = 136
               Right = 691
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repFinancialReportByRefID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repFinancialReportByRefID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tBookTransaction (dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 456
               Right = 278
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tBookRecord (dbo)"
            Begin Extent = 
               Top = 6
               Left = 316
               Bottom = 419
               Right = 538
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccount (dbo)"
            Begin Extent = 
               Top = 6
               Left = 576
               Bottom = 421
               Right = 780
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tReferenceCode (dbo)"
            Begin Extent = 
               Top = 6
               Left = 818
               Bottom = 447
               Right = 1028
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 19905
         Alias = 4470
         Table = 2070
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
        ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repFinancialReportByRefID2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repFinancialReportByRefID2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repFinancialReportByRefID2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[56] 4[15] 2[25] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "repTransactionGroupedByCostCenter (dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 463
               Right = 271
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repFinancialReportForecast'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repFinancialReportForecast'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "i"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 277
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "o"
            Begin Extent = 
               Top = 223
               Left = 450
               Bottom = 353
               Right = 648
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p0"
            Begin Extent = 
               Top = 6
               Left = 510
               Bottom = 136
               Right = 687
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 725
               Bottom = 136
               Right = 902
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e"
            Begin Extent = 
               Top = 316
               Left = 91
               Bottom = 446
               Right = 315
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repPlanElementInstanceOrigin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repPlanElementInstanceOrigin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tReferenceCode (dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 254
               Right = 226
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "tReferenceGroup (dbo)"
            Begin Extent = 
               Top = 6
               Left = 264
               Bottom = 136
               Right = 463
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3510
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repReferenceCodes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repReferenceCodes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[49] 4[27] 2[23] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -96
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tBookTransaction (dbo)"
            Begin Extent = 
               Top = 96
               Left = 8
               Bottom = 579
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccount (dbo)"
            Begin Extent = 
               Top = 189
               Left = 488
               Bottom = 566
               Right = 692
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccountGroup (dbo)"
            Begin Extent = 
               Top = 256
               Left = 739
               Bottom = 577
               Right = 973
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tBookRecord (dbo)"
            Begin Extent = 
               Top = 104
               Left = 243
               Bottom = 234
               Right = 465
            End
            DisplayFlags = 280
            TopColumn = 12
         End
         Begin Table = "AccountBooking"
            Begin Extent = 
               Top = 279
               Left = 242
               Bottom = 409
               Right = 446
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "tAccountMainGroup (dbo)"
            Begin Extent = 
               Top = 252
               Left = 993
               Bottom = 567
               Right = 1177
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccountSection (dbo)"
            Begin Extent = 
               Top = 259
               Left = 1203
               ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repTransactionDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'Bottom = 389
               Right = 1391
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tReferenceCode (dbo)"
            Begin Extent = 
               Top = 202
               Left = 1541
               Bottom = 497
               Right = 1735
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCostCenter (dbo)"
            Begin Extent = 
               Top = 416
               Left = 237
               Bottom = 546
               Right = 445
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 9660
         Alias = 3060
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repTransactionDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repTransactionDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[35] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tAccountSection (dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccount (dbo)"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 258
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccountMainGroup (dbo)"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccountGroup (dbo)"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 532
               Right = 288
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tBookTransaction (dbo)"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 664
               Right = 256
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 9120
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repTransactionGroupedByAccount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repTransactionGroupedByAccount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repTransactionGroupedByAccount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tAccountSection (dbo)"
            Begin Extent = 
               Top = 486
               Left = 38
               Bottom = 616
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccount (dbo)"
            Begin Extent = 
               Top = 618
               Left = 38
               Bottom = 748
               Right = 258
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccountMainGroup (dbo)"
            Begin Extent = 
               Top = 750
               Left = 38
               Bottom = 880
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccountGroup (dbo)"
            Begin Extent = 
               Top = 882
               Left = 38
               Bottom = 1012
               Right = 288
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tBookTransaction (dbo)"
            Begin Extent = 
               Top = 1014
               Left = 38
               Bottom = 1144
               Right = 256
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filt' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repTransactionGroupedByCostCenter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'er = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repTransactionGroupedByCostCenter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'repTransactionGroupedByCostCenter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tAccount"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 282
               Right = 234
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccountGroup"
            Begin Extent = 
               Top = 6
               Left = 272
               Bottom = 219
               Right = 506
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AccountReporting"
            Begin Extent = 
               Top = 218
               Left = 274
               Bottom = 348
               Right = 507
            End
            DisplayFlags = 280
            TopColumn = 8
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAccountAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAccountAll'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tAccountGroup"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 297
               Right = 314
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "tAccountMainGroup"
            Begin Extent = 
               Top = 6
               Left = 352
               Bottom = 256
               Right = 561
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccount"
            Begin Extent = 
               Top = 28
               Left = 886
               Bottom = 230
               Right = 1090
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2250
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAccountGroup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAccountGroup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tAccountMainGroup"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 305
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccountSection"
            Begin Extent = 
               Top = 6
               Left = 285
               Bottom = 309
               Right = 473
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAccountMainGroup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAccountMainGroup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[55] 4[41] 2[2] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tAccount"
            Begin Extent = 
               Top = 28
               Left = 686
               Bottom = 400
               Right = 914
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccountGroup"
            Begin Extent = 
               Top = 141
               Left = 275
               Bottom = 304
               Right = 541
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "AccountReporting"
            Begin Extent = 
               Top = 161
               Left = 1057
               Bottom = 324
               Right = 1285
            End
            DisplayFlags = 280
            TopColumn = 4
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2604
         Alias = 3540
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAccountPlanning'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAccountPlanning'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tAccountSection"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 316
               Right = 226
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAccountSection'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAccountSection'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[27] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tPlanElementInstance"
            Begin Extent = 
               Top = 189
               Left = 731
               Bottom = 352
               Right = 926
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanElement"
            Begin Extent = 
               Top = 287
               Left = 323
               Bottom = 450
               Right = 585
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "tBookRecord"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 351
               Right = 260
            End
            DisplayFlags = 280
            TopColumn = 12
         End
         Begin Table = "tClient"
            Begin Extent = 
               Top = 11
               Left = 339
               Bottom = 141
               Right = 533
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "tAccountCredit"
            Begin Extent = 
               Top = 30
               Left = 850
               Bottom = 157
               Right = 1046
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "tAccountDebit"
            Begin Extent = 
               Top = 10
               Left = 636
               Bottom = 140
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "tCostCenter"
            Begin Extent = 
               Top = 90
               Left = 496
               Bottom = 220
               Right = 672
       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vBookRecord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2070
         Alias = 2070
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vBookRecord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vBookRecord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[54] 4[36] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tBookTransaction"
            Begin Extent = 
               Top = 70
               Left = 439
               Bottom = 460
               Right = 636
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AccountReport"
            Begin Extent = 
               Top = 19
               Left = 34
               Bottom = 149
               Right = 288
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "tBookRecord"
            Begin Extent = 
               Top = 7
               Left = 736
               Bottom = 282
               Right = 958
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "AccountBooking"
            Begin Extent = 
               Top = 190
               Left = 34
               Bottom = 320
               Right = 289
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "tPlanElement"
            Begin Extent = 
               Top = 313
               Left = 743
               Bottom = 443
               Right = 967
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "tCostCenter"
            Begin Extent = 
               Top = 378
               Left = 31
               Bottom = 508
               Right = 303
            End
            DisplayFlags = 280
            TopColumn = 6
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vBookTransaction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'    Column = 3810
         Alias = 2115
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vBookTransaction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vBookTransaction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[28] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tClient"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 246
               Right = 232
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCurrency"
            Begin Extent = 
               Top = 6
               Left = 270
               Bottom = 136
               Right = 437
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vClient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vClient'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[32] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tCostCenter"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 298
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vCostCenter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vCostCenter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tCurrency"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 271
               Right = 243
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vCurrency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vCurrency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tCurrencyExchangeRate"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 276
               Right = 258
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCurrency"
            Begin Extent = 
               Top = 181
               Left = 379
               Bottom = 311
               Right = 546
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "tPlan"
            Begin Extent = 
               Top = 1
               Left = 316
               Bottom = 131
               Right = 493
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2010
         Alias = 1530
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vCurrencyExchangeRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vCurrencyExchangeRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[53] 4[44] 2[2] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tDepreciationRule (dbo)"
            Begin Extent = 
               Top = 9
               Left = 57
               Bottom = 206
               Right = 341
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AccountActivation"
            Begin Extent = 
               Top = 10
               Left = 378
               Bottom = 173
               Right = 606
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "AccountDepreciation"
            Begin Extent = 
               Top = 276
               Left = 390
               Bottom = 439
               Right = 618
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1180
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1360
         SortOrder = 1420
         GroupBy = 1350
         Filter = 1360
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDepreciationRule'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vDepreciationRule'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tJobReport"
            Begin Extent = 
               Top = 13
               Left = 481
               Bottom = 288
               Right = 683
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tJobReportItem"
            Begin Extent = 
               Top = 0
               Left = 826
               Bottom = 271
               Right = 1032
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tClient"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 214
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tUser"
            Begin Extent = 
               Top = 155
               Left = 249
               Bottom = 335
               Right = 443
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2775
         Alias = 2790
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vJobReport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vJobReport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tPlan"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 302
               Right = 215
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Baseplan"
            Begin Extent = 
               Top = 6
               Left = 253
               Bottom = 290
               Right = 430
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1545
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tPlanAccountFunction"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 265
               Right = 297
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccount"
            Begin Extent = 
               Top = 6
               Left = 335
               Bottom = 267
               Right = 531
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1980
         Alias = 2700
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanAccountFunction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanAccountFunction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[46] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tPlanAllocationSchedule"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 271
               Right = 300
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2955
         Alias = 3675
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanAllocationSchedule'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanAllocationSchedule'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tPlanAllocationScheduleItems"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 361
               Right = 312
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanAllocationSchedule"
            Begin Extent = 
               Top = 7
               Left = 360
               Bottom = 438
               Right = 612
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanAllocationScheduleItems'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanAllocationScheduleItems'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tPlanElement (dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 312
               Right = 262
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanGroup (dbo)"
            Begin Extent = 
               Top = 312
               Left = 313
               Bottom = 442
               Right = 518
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "tCurrency (dbo)"
            Begin Extent = 
               Top = 152
               Left = 359
               Bottom = 282
               Right = 529
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCostCenter (dbo)"
            Begin Extent = 
               Top = 85
               Left = 670
               Bottom = 215
               Right = 878
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "tTypeCodeDef (dbo)"
            Begin Extent = 
               Top = 6
               Left = 997
               Bottom = 136
               Right = 1172
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElement'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElement'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElement'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[49] 4[48] 2[3] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -384
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tReferenceCode (dbo)"
            Begin Extent = 
               Top = 898
               Left = 340
               Bottom = 1028
               Right = 534
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DueTrigger"
            Begin Extent = 
               Top = 496
               Left = 354
               Bottom = 626
               Right = 574
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCurrency (dbo)"
            Begin Extent = 
               Top = 715
               Left = 606
               Bottom = 845
               Right = 776
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PricePar1"
            Begin Extent = 
               Top = 280
               Left = 901
               Bottom = 410
               Right = 1121
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PricePar2"
            Begin Extent = 
               Top = 315
               Left = 629
               Bottom = 445
               Right = 849
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanElement (dbo)"
            Begin Extent = 
               Top = 655
               Left = 31
               Bottom = 970
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanElementInstance (dbo)"
            Begin Extent = 
               Top = 444
               Left = 37
               Bottom = 635
         ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElementBooking'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Right = 235
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanElementBooking (dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 421
               Right = 245
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCostCenter (dbo)"
            Begin Extent = 
               Top = 633
               Left = 367
               Bottom = 763
               Right = 575
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "tPlanInflationRule (dbo)"
            Begin Extent = 
               Top = 12
               Left = 837
               Bottom = 142
               Right = 1047
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AccountDebit"
            Begin Extent = 
               Top = 0
               Left = 343
               Bottom = 130
               Right = 539
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "ContingencyPar"
            Begin Extent = 
               Top = 358
               Left = 354
               Bottom = 488
               Right = 574
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AccountCredit"
            Begin Extent = 
               Top = 133
               Left = 578
               Bottom = 263
               Right = 774
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "tPlanAllocationSchedule (dbo)"
            Begin Extent = 
               Top = 162
               Left = 336
               Bottom = 292
               Right = 549
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanGroup (dbo)"
            Begin Extent = 
               Top = 852
               Left = 574
               Bottom = 982
               Right = 779
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlan (dbo)"
            Begin Extent = 
               Top = 561
               Left = 839
               Bottom = 691
               Right = 1016
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3510
         Alias = 3615
         Table = 5325
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElementBooking'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElementBooking'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[74] 4[19] 2[7] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PricePar1"
            Begin Extent = 
               Top = 367
               Left = 1340
               Bottom = 511
               Right = 1596
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PricePar2"
            Begin Extent = 
               Top = 361
               Left = 1619
               Bottom = 508
               Right = 1875
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "AccountMain"
            Begin Extent = 
               Top = 264
               Left = 570
               Bottom = 427
               Right = 771
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "tPlanElementContract (dbo)"
            Begin Extent = 
               Top = 102
               Left = 614
               Bottom = 232
               Right = 830
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanInflationRule (dbo)"
            Begin Extent = 
               Top = 234
               Left = 809
               Bottom = 364
               Right = 1019
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ContingencyPar"
            Begin Extent = 
               Top = 680
               Left = 1095
               Bottom = 843
               Right = 1307
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "AccountAdvance"
            Begin Extent = 
               Top = 175
               Left = 1354
               Bottom = 338
    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElementContract'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'           Right = 1604
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "DepreciationTrigger"
            Begin Extent = 
               Top = 181
               Left = 1625
               Bottom = 344
               Right = 1881
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "tVATRule (dbo)"
            Begin Extent = 
               Top = 366
               Left = 809
               Bottom = 496
               Right = 1015
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AdvanceTrigger"
            Begin Extent = 
               Top = 190
               Left = 1102
               Bottom = 353
               Right = 1302
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "tPlanAllocationSchedule (dbo)"
            Begin Extent = 
               Top = 498
               Left = 614
               Bottom = 628
               Right = 827
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tReferenceCode (dbo)"
            Begin Extent = 
               Top = 630
               Left = 614
               Bottom = 760
               Right = 808
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DueTrigger"
            Begin Extent = 
               Top = 455
               Left = 314
               Bottom = 618
               Right = 517
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "tCurrency (dbo)"
            Begin Extent = 
               Top = 102
               Left = 868
               Bottom = 232
               Right = 1038
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCostCenter (dbo)"
            Begin Extent = 
               Top = 762
               Left = 614
               Bottom = 892
               Right = 822
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanElement (dbo)"
            Begin Extent = 
               Top = 894
               Left = 614
               Bottom = 1024
               Right = 838
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanElementInstance (dbo)"
            Begin Extent = 
               Top = 170
               Left = 266
               Bottom = 299
               Right = 464
            End
            DisplayFlags = 280
            TopColumn = 10
         End
         Begin Table = "tPlanGroup (dbo)"
            Begin Extent = 
               Top = 1158
               Left = 614
               Bottom = 1288
               Right = 819
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tDepreciationRule (dbo)"
            Begin Extent = 
               Top = 1290
               Left = 614
               Bottom = 1420
               Right = 825
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlan (dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 215
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElementContract'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane3', @value=N' = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3090
         Alias = 3540
         Table = 2910
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElementContract'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=3 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElementContract'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[45] 4[43] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tCostCenter"
            Begin Extent = 
               Top = 9
               Left = 5
               Bottom = 139
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanElement"
            Begin Extent = 
               Top = 6
               Left = 239
               Bottom = 286
               Right = 463
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanElementInstance"
            Begin Extent = 
               Top = 65
               Left = 495
               Bottom = 481
               Right = 688
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanGroup"
            Begin Extent = 
               Top = 267
               Left = 0
               Bottom = 397
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "tPlanHRExpenseGroup"
            Begin Extent = 
               Top = 318
               Left = 987
               Bottom = 448
               Right = 1211
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "tPlanElementHR"
            Begin Extent = 
               Top = 66
               Left = 718
               Bottom = 417
               Right = 944
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanHRTariff"
            Begin Extent = 
               Top = 161
               Left = 983
               Bottom = 291
               Right = 1200
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElementHR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "tPlanInflationRule"
            Begin Extent = 
               Top = 6
               Left = 982
               Bottom = 136
               Right = 1203
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "DueTrigger"
            Begin Extent = 
               Top = 360
               Left = 246
               Bottom = 490
               Right = 466
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tReferenceCode"
            Begin Extent = 
               Top = 438
               Left = 0
               Bottom = 568
               Right = 207
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCurrency"
            Begin Extent = 
               Top = 140
               Left = 4
               Bottom = 270
               Right = 203
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2160
         Alias = 1905
         Table = 1995
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElementHR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElementHR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[59] 4[23] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tPlanElement (dbo)"
            Begin Extent = 
               Top = 19
               Left = 597
               Bottom = 325
               Right = 821
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanElementInstance (dbo)"
            Begin Extent = 
               Top = 0
               Left = 1028
               Bottom = 408
               Right = 1226
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCostCenter (dbo)"
            Begin Extent = 
               Top = 68
               Left = 100
               Bottom = 198
               Right = 308
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "tPlanGroup (dbo)"
            Begin Extent = 
               Top = 248
               Left = 115
               Bottom = 378
               Right = 320
            End
            DisplayFlags = 280
            TopColumn = 4
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 5025
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElementInstances'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElementInstances'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tPlanGroup"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 289
               Right = 288
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanGroup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanGroup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[30] 2[25] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tPlanHRExpense"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 280
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "tPlanHRExpenseGroup"
            Begin Extent = 
               Top = 6
               Left = 274
               Bottom = 136
               Right = 498
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "tAccount"
            Begin Extent = 
               Top = 45
               Left = 556
               Bottom = 175
               Right = 752
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "tCostCenter"
            Begin Extent = 
               Top = 205
               Left = 335
               Bottom = 335
               Right = 544
            End
            DisplayFlags = 280
            TopColumn = 4
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1845
         Alias = 2130
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanHRExpense'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanHRExpense'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tPlanHRExpenseGroup"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 278
               Right = 262
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2250
         Alias = 1530
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanHRExpenseGroup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanHRExpenseGroup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[32] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tPlanHRTariff"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 298
               Right = 215
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccount"
            Begin Extent = 
               Top = 6
               Left = 253
               Bottom = 136
               Right = 449
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1530
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanHRTariff'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanHRTariff'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[49] 2[8] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tPlanHRTariffDetail"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 338
               Right = 234
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanHRTariff"
            Begin Extent = 
               Top = 6
               Left = 272
               Bottom = 136
               Right = 449
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2205
         Alias = 2595
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanHRTariffDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanHRTariffDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tPlanInflationRule"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 297
               Right = 292
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanInflationRule'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanInflationRule'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tPlanParameter"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 308
               Right = 304
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanParameterContingency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanParameterContingency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tPlanParameter"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 304
               Right = 304
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanParameterDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanParameterDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tPlanParameter"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 313
               Right = 304
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanParameterPriceFactor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanParameterPriceFactor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tReferenceCode (dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 232
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "tReferenceGroup (dbo)"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vReferenceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vReferenceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[35] 2[6] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tReferenceGroup"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 297
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1875
         Alias = 1230
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vReferenceGroup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vReferenceGroup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tTypeCodeDef"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 249
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tTypeGroupDef"
            Begin Extent = 
               Top = 6
               Left = 252
               Bottom = 221
               Right = 419
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1260
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vTypeCodeDef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vTypeCodeDef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tTypeGroupDef"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 265
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vTypeGroupDef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vTypeGroupDef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tUser"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 287
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tClient"
            Begin Extent = 
               Top = 6
               Left = 265
               Bottom = 222
               Right = 459
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1455
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[61] 4[31] 2[3] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tVATRule"
            Begin Extent = 
               Top = 17
               Left = 805
               Bottom = 482
               Right = 1046
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AccountVATInput"
            Begin Extent = 
               Top = 38
               Left = 418
               Bottom = 201
               Right = 646
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "AccountVATOutput"
            Begin Extent = 
               Top = 255
               Left = 430
               Bottom = 418
               Right = 658
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "AccountVATBalance"
            Begin Extent = 
               Top = 156
               Left = 1138
               Bottom = 319
               Right = 1366
            End
            DisplayFlags = 280
            TopColumn = 4
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vVATRule'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vVATRule'
GO
USE [master]
GO
ALTER DATABASE [verum_Test] SET  READ_WRITE 
GO
