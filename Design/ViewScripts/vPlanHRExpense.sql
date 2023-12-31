USE [VerumDBDev]
GO

/****** Object:  View [dbo].[vPlanHRExpense]    Script Date: 17.06.2020 11:20:20 ******/
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

