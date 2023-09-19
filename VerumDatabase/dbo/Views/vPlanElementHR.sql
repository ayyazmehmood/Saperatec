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
               Right = 1200' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElementHR'
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
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElementHR'
GO