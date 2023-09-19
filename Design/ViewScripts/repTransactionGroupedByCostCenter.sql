/****** Object:  View [dbo].[repTransactionGroupedByCostCenter]    Script Date: 02.01.2021 13:54:15 ******/
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

