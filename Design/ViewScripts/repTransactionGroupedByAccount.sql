/****** Object:  View [dbo].[repTransactionGroupedByAccount]    Script Date: 02.01.2021 13:53:59 ******/
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

