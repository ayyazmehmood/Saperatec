/****** Object:  View [dbo].[vPlanElementInstances]    Script Date: 03.12.2020 15:35:19 ******/
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

