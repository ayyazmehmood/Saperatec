USE [VerumDBDev]
GO

/****** Object:  View [dbo].[vPlanElementContract]    Script Date: 17.06.2020 07:48:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vPlanElementContract]
AS
SELECT        dbo.tPlanElementInstance.idPlan, dbo.tPlanGroup.TitlePlanGroup AS [Plan Group], dbo.tPlanElement.TitlePlanElement AS Title, dbo.tPlanElement.TypePlanElement AS Type, dbo.tCostCenter.CostCenterCode AS [Cost Center], 
                         dbo.tPlanElement.ReferenceIDPlanElement AS Reference, AccountMain.AccountCode AS Account, dbo.tPlanElementContract.Price, dbo.tCurrency.CurrencyCode AS Currency, dbo.tPlanElementInstance.DueDateDay AS [Due Day], 
                         dbo.tPlanElementInstance.DueDateMonth AS [Due Month], dbo.tPlanElementInstance.DueDateYear AS [Due Year], dbo.tPlanElement.PlanElementDescription AS Description, 
                         dbo.tPlanElementInstance.FlagDateOffset AS [Due Offset], DueTrigger.TitlePlanParameter AS [Due Trigger], dbo.tPlanElementContract.TypeRepeat AS Repeat, dbo.tPlanElementInstance.UntilDateDay AS [Until Day], 
                         dbo.tPlanElementInstance.UntilDateMonth AS [Until Month], dbo.tPlanElementInstance.UntilDateYear AS [Until Year], dbo.tPlanAllocationSchedule.TitleAllocationSchedule AS Schedule, dbo.tVATRule.VATRuleCode AS [VAT Rule], 
                         dbo.tPlanElementContract.PaymentTerm AS [Payment Term], dbo.tPlanElementContract.AdvanceDelay AS [Advance Delay], AccountAdvance.AccountCode AS [Advance Account], 
                         AdvanceTrigger.TitlePlanParameter AS [Advance Trigger], dbo.tDepreciationRule.TitleDepreciationRule AS [Depreciation Rule], dbo.tPlanElementContract.DepreciationStartDay AS [Depreciation Start Day], 
                         dbo.tPlanElementContract.DepreciationStartMonth AS [Depreciation Start Month], dbo.tPlanElementContract.DepreciationStartYear AS [Depreciation Start Year], 
                         dbo.tPlanElementContract.DepreciationDelay AS [Depreciation Delay], DepreciationTrigger.TitlePlanParameter AS [Depreciation Trigger], dbo.tPlanElementContract.NumberOfUnits AS Units, 
                         PricePar1.TitlePlanParameter AS [Price Par 1], PricePar2.TitlePlanParameter AS [Price Par 2], ContingencyPar.TitlePlanParameter AS [Contingency Rule], dbo.tPlanInflationRule.TitleInflationRule AS [Inflation Rule], 
                         dbo.tPlanElementContract.PriceDate AS [Price Date], dbo.tPlanElementInstance.Assumptions, dbo.tPlanElementInstance.Revisions, dbo.tPlanElementContract.Id
FROM            dbo.tPlanParameter AS PricePar1 RIGHT OUTER JOIN
                         dbo.tPlanParameter AS PricePar2 RIGHT OUTER JOIN
                         dbo.tAccount AS AccountMain INNER JOIN
                         dbo.tPlanElementContract ON AccountMain.Id = dbo.tPlanElementContract.idAccountMain LEFT OUTER JOIN
                         dbo.tPlanInflationRule ON dbo.tPlanElementContract.idInflationRule = dbo.tPlanInflationRule.Id LEFT OUTER JOIN
                         dbo.tPlanParameter AS ContingencyPar ON dbo.tPlanElementContract.idParContingencyRate = ContingencyPar.Id LEFT OUTER JOIN
                         dbo.tAccount AS AccountAdvance ON dbo.tPlanElementContract.idAccountAdvance = AccountAdvance.Id LEFT OUTER JOIN
                         dbo.tPlanParameter AS DepreciationTrigger ON dbo.tPlanElementContract.idDepreciationTrigger = DepreciationTrigger.Id ON PricePar2.Id = dbo.tPlanElementContract.idParPrice2 ON 
                         PricePar1.Id = dbo.tPlanElementContract.idParPrice1 LEFT OUTER JOIN
                         dbo.tVATRule ON dbo.tPlanElementContract.idVATRule = dbo.tVATRule.Id LEFT OUTER JOIN
                         dbo.tPlanParameter AS AdvanceTrigger ON dbo.tPlanElementContract.idParTriggerAdvance = AdvanceTrigger.Id LEFT OUTER JOIN
                         dbo.tPlanAllocationSchedule ON dbo.tPlanElementContract.idAllocationSchedule = dbo.tPlanAllocationSchedule.Id LEFT OUTER JOIN
                         dbo.tReferenceCode RIGHT OUTER JOIN
                         dbo.tPlanParameter AS DueTrigger RIGHT OUTER JOIN
                         dbo.tCurrency RIGHT OUTER JOIN
                         dbo.tCostCenter RIGHT OUTER JOIN
                         dbo.tPlanElement INNER JOIN
                         dbo.tPlanElementInstance ON dbo.tPlanElement.Id = dbo.tPlanElementInstance.idPlanElement INNER JOIN
                         dbo.tPlanGroup ON dbo.tPlanElement.idPlanGroup = dbo.tPlanGroup.Id ON dbo.tCostCenter.Id = dbo.tPlanElement.idCostCenterPlanElement ON dbo.tCurrency.Id = dbo.tPlanElement.idCurrency ON 
                         DueTrigger.Id = dbo.tPlanElementInstance.idParTriggerDueDate ON dbo.tReferenceCode.RefCode = dbo.tPlanElement.ReferenceIDPlanElement ON 
                         dbo.tPlanElementContract.idPlanInstance = dbo.tPlanElementInstance.Id LEFT OUTER JOIN
                         dbo.tDepreciationRule ON dbo.tPlanElementContract.idDepreciationRule = dbo.tDepreciationRule.Id
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
         Top = -96
         Left = -576
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
         Begin Table = "tPlanElementContract"
            Begin Extent = 
               Top = 0
               Left = 805
               Bottom = 844
               Right = 1047
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanInflationRule"
            Begin Extent = 
               Top = 522
               Left = 1334
               Bottom = 685
               Right = 1578
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

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'    Right = 1604
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
         Begin Table = "tVATRule"
            Begin Extent = 
               Top = 415
               Left = 1118
               Bottom = 559
               Right = 1324
            End
            DisplayFlags = 280
            TopColumn = 7
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
         Begin Table = "tPlanAllocationSchedule"
            Begin Extent = 
               Top = 21
               Left = 1103
               Bottom = 184
               Right = 1303
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "tReferenceCode"
            Begin Extent = 
               Top = 529
               Left = 20
               Bottom = 692
               Right = 273
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "DueTrigger"
            Begin Extent = 
               Top = 455
               Left = 314
               Bottom = 618
               Right = 517
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCurrency"
            Begin Extent = 
               Top = 177
               Left = 24
               Bottom = 340
               Right = 231
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "tCostCenter"
            Begin Extent = 
               Top = 6
               Left = 21
               Bottom = 169
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "tPlanElement"
            Begin Extent = 
               Top = 51
               Left = 297
               Bottom = 399
               Right = 538
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanElementInstance"
            Begin Extent = 
               Top = 24
               Left = 572
               Bottom = 249
               Right = 767
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "tPlanGroup"
            Begin Extent = 
               Top = 344
               Left = 26
               Bottom = 507
               Right = 252
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "tDepreciationRule"
            Begin Extent = 
               Top = 0
               Left = 1627
               Bottom = 163
               Right = 1882
            End
            DisplayFlags = 280
            TopColumn = 7
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
         Column = 3090
         Alias = 3540
         Table = 2910
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElementContract'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane3', @value=N'         Filter = 1350
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

