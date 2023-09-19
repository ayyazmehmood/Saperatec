USE [VerumTest]
GO

SELECT f.idClient, f.RefID, r.TitleRefCode, f.CostCenterCode, a.AccountCode, a.TitleLocalAccount As AccountTitle, f.MonthIndex/12 As Year, f.MonthIndex % 12 + 1 As Month , f.Actual, f.Baseline, f.Budget FROM 
(
SELECT u.idClient, u.RefID, u.CostCenterCode, u.idAccountReport, u.MonthIndex, Sum(u.Actual) As Actual, Sum(u.Baseline) As Baseline, Sum(u.Budget) As Budget FROM
(
	SELECT 
		t.idClient, 
		t.ReferenceIDBookTransaction As RefID,
		t.CostCenterCode, 
		t.idAccountReport,
		t.MonthIndex,
		Sum(t.AmountCredit-t.AmountDebit) AS Actual, 
		0 AS Baseline, 
		0 AS Budget
	FROM dbo.tBookTransaction t
	GROUP BY t.idClient, t.ReferenceIDBookTransaction, t.CostCenterCode, t.idAccountReport, t.MonthIndex, t.TypeBookRecord
	HAVING (((t.TypeBookRecord)=0))
	UNION SELECT
		t.idClient, 
		t.ReferenceIDBookTransaction  As RefID,
		t.CostCenterCode, 
		t.idAccountReport, 
		t.MonthIndex,
		0 AS Actual,
		Sum(t.AmountCredit-t.AmountDebit)  AS Baseline, 
		0 AS Budget
	FROM dbo.tBookTransaction t
	GROUP BY t.idClient, t.ReferenceIDBookTransaction, t.CostCenterCode, t.idAccountReport, t.MonthIndex, t.FlagBaseline
	HAVING (((t.FlagBaseline)=1))
	UNION SELECT
		t.idClient, 
		t.ReferenceIDBookTransaction  As RefID,
		t.CostCenterCode, 
		t.idAccountReport, 
		t.MonthIndex,
		0 AS Actual, 
		0 AS Baseline, 
		Sum(t.AmountCredit-t.AmountDebit) AS Budget
	FROM dbo.tBookTransaction t
	GROUP BY t.idClient, t.ReferenceIDBookTransaction, t.CostCenterCode, t.idAccountReport, t.MonthIndex, t.TypeBookRecord
	HAVING (((t.TypeBookRecord)=1))
) u
GROUP BY u.idClient, u.RefID, u.CostCenterCode, u.idAccountReport, u.MonthIndex
) f
INNER JOIN dbo.tAccount a ON f.idAccountReport = a.Id
LEFT OUTER JOIN dbo.tReferenceCode r ON r.idClient = f.idClient AND r.RefCode = f.RefID


GO
