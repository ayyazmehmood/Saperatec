/****** Object:  View [dbo].[repTransactionDetail]    Script Date: 02.01.2021 13:53:30 ******/
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
                         dbo.tBookRecord.BookingDocument, dbo.tBookRecord.ReferenceIDBookRecord, dbo.tBookRecord.BookRecordComment, dbo.tBookRecord.BookingRunCode, dbo.tBookRecord.BookingSequenceNum, 
                         dbo.tBookRecord.AccountCodeDebit, dbo.tBookRecord.AccountCodeCredit, dbo.tBookRecord.DATEVBUCode, dbo.tAccountSection.SectionOrder, dbo.tAccountSection.TitleLocalSection, dbo.tAccountMainGroup.MainGroupOrder, 
                         dbo.tAccountMainGroup.TitleLocalMainGroup, dbo.tAccountGroup.AccountGroupOrder, dbo.tAccountGroup.TitleLocalAccountGroup, dbo.tBookTransaction.ReviewComment, dbo.tBookTransaction.idClient, 
                         dbo.tBookTransaction.idPlan
FROM            dbo.tBookTransaction INNER JOIN
                         dbo.tAccount ON dbo.tBookTransaction.idAccountReport = dbo.tAccount.Id INNER JOIN
                         dbo.tAccountGroup ON dbo.tAccount.idAccountGroup = dbo.tAccountGroup.Id INNER JOIN
                         dbo.tAccountMainGroup ON dbo.tAccount.idAccountMainGroup = dbo.tAccountMainGroup.Id INNER JOIN
                         dbo.tAccountSection ON dbo.tAccount.idAccountSection = dbo.tAccountSection.Id INNER JOIN
                         dbo.tBookRecord ON dbo.tBookTransaction.idBookingRecord = dbo.tBookRecord.Id INNER JOIN
                         dbo.tAccount AS AccountBooking ON dbo.tBookTransaction.idAccountBooking = AccountBooking.Id LEFT OUTER JOIN
                         dbo.tCostCenter ON dbo.tBookTransaction.idCostCenter = dbo.tCostCenter.Id
WHERE        (dbo.tBookTransaction.FlagForecast = 1) OR
                         (dbo.tBookTransaction.TypeBookRecord = 0) OR
                         (dbo.tBookTransaction.TypeBookRecord = 1)
GO

