USE [VerumTest]
GO

SELECT [Id]
      ,[idPlanElement]
      ,[idPlan]
      ,[FlagUpdate]
      ,[FlagBaseline]
      ,[FlagDateOffset]
      ,[DueDateYear]
      ,[DueDateMonth]
      ,[DueDateDay]
      ,[UntilDateYear]
      ,[UntilDateMonth]
      ,[UntilDateDay]
      ,[idParTriggerDueDate]
      ,[Assumptions]
      ,[Revisions]
  FROM [dbo].[tPlanElementInstance]
  WHERE Id=Cast('f53b568e-05d3-4b71-97e6-e83c23d3e6b6' as uniqueidentifier)

GO


