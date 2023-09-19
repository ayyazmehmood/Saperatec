USE [VerumDBDev]
GO

/****** Object:  View [dbo].[vPlanElementBooking]    Script Date: 20.06.2020 07:15:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vPlanElementBooking]
AS
SELECT        dbo.tPlanElementInstance.idPlan, dbo.tPlanGroup.TitlePlanGroup AS [Plan Group], dbo.tPlanElement.TitlePlanElement AS Title, dbo.tCostCenter.CostCenterCode AS [Cost Center], 
                         dbo.tPlanElement.ReferenceIDPlanElement AS Reference, AccountDebit.AccountCode AS [Debit Account], AccountCredit.AccountCode AS [Credit Account], dbo.tPlanElementBooking.Price, dbo.tCurrency.CurrencyCode AS Currency, 
                         dbo.tPlanElementInstance.DueDateDay AS [Due Day], dbo.tPlanElementInstance.DueDateMonth AS [Due Month], dbo.tPlanElementInstance.DueDateYear AS [Due Year], dbo.tPlanElement.PlanElementDescription AS Description, 
                         dbo.tPlanElementInstance.FlagDateOffset AS [Due Offset], DueTrigger.TitlePlanParameter AS [Due Trigger], dbo.tPlanElementBooking.TypeRepeat AS Repeat, dbo.tPlanElementInstance.UntilDateDay AS [Until Day], 
                         dbo.tPlanElementInstance.UntilDateMonth AS [Until Month], dbo.tPlanElementInstance.UntilDateYear AS [Until Year], dbo.tPlanAllocationSchedule.TitleAllocationSchedule AS Schedule, 
                         dbo.tPlanElementBooking.NumberOfUnits AS Units, PricePar1.TitlePlanParameter AS [Price Par 1], PricePar2.TitlePlanParameter AS [Price Par 2], ContingencyPar.TitlePlanParameter AS [Contingency Rule], 
                         dbo.tPlanInflationRule.TitleInflationRule AS [Inflation Rule], dbo.tPlanElementBooking.PriceDate AS [Price Date], dbo.tPlanElementBooking.FlagAccountOpening AS [Flag Account Opening], dbo.tPlanElementInstance.Assumptions, 
                         dbo.tPlanElementInstance.Revisions, dbo.tPlanElementBooking.Id
FROM            dbo.tPlanParameter AS PricePar1 RIGHT OUTER JOIN
                         dbo.tPlanParameter AS PricePar2 RIGHT OUTER JOIN
                         dbo.tAccount AS AccountDebit INNER JOIN
                         dbo.tPlanElementBooking ON AccountDebit.Id = dbo.tPlanElementBooking.idAccountDebit INNER JOIN
                         dbo.tPlanInflationRule ON dbo.tPlanElementBooking.idInflationRule = dbo.tPlanInflationRule.Id LEFT OUTER JOIN
                         dbo.tPlanParameter AS ContingencyPar ON dbo.tPlanElementBooking.idParContingencyRate = ContingencyPar.Id LEFT OUTER JOIN
                         dbo.tAccount AS AccountCredit ON dbo.tPlanElementBooking.idAccountCredit = AccountCredit.Id ON PricePar2.Id = dbo.tPlanElementBooking.idParPrice2 ON PricePar1.Id = dbo.tPlanElementBooking.idParPrice1 LEFT OUTER JOIN
                         dbo.tPlanAllocationSchedule ON dbo.tPlanElementBooking.idAllocationSchedule = dbo.tPlanAllocationSchedule.Id LEFT OUTER JOIN
                         dbo.tReferenceCode RIGHT OUTER JOIN
                         dbo.tPlanParameter AS DueTrigger RIGHT OUTER JOIN
                         dbo.tCurrency RIGHT OUTER JOIN
                         dbo.tCostCenter INNER JOIN
                         dbo.tPlanElement INNER JOIN
                         dbo.tPlanElementInstance ON dbo.tPlanElement.Id = dbo.tPlanElementInstance.idPlanElement INNER JOIN
                         dbo.tPlanGroup ON dbo.tPlanElement.idPlanGroup = dbo.tPlanGroup.Id ON dbo.tCostCenter.Id = dbo.tPlanElement.idCostCenterPlanElement ON dbo.tCurrency.Id = dbo.tPlanElement.idCurrency ON 
                         DueTrigger.Id = dbo.tPlanElementInstance.idParTriggerDueDate ON dbo.tReferenceCode.RefCode = dbo.tPlanElement.ReferenceIDPlanElement ON dbo.tPlanElementBooking.idPlanInstance = dbo.tPlanElementInstance.Id
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
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PricePar1"
            Begin Extent = 
               Top = 270
               Left = 1231
               Bottom = 400
               Right = 1451
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PricePar2"
            Begin Extent = 
               Top = 424
               Left = 1228
               Bottom = 554
               Right = 1448
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AccountDebit"
            Begin Extent = 
               Top = 27
               Left = 954
               Bottom = 157
               Right = 1150
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanElementBooking"
            Begin Extent = 
               Top = 38
               Left = 634
               Bottom = 586
               Right = 841
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanInflationRule"
            Begin Extent = 
               Top = 298
               Left = 946
               Bottom = 428
               Right = 1156
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "ContingencyPar"
            Begin Extent = 
               Top = 573
               Left = 1244
               Bottom = 703
               Right = 1464
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AccountCredit"
            Begin Extent = 
               Top = 168
               Left = 945
               Bottom = 298
               Righ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanElementBooking'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N't = 1141
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "tPlanAllocationSchedule"
            Begin Extent = 
               Top = 473
               Left = 364
               Bottom = 603
               Right = 578
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tReferenceCode"
            Begin Extent = 
               Top = 463
               Left = 8
               Bottom = 593
               Right = 196
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DueTrigger"
            Begin Extent = 
               Top = 636
               Left = 77
               Bottom = 766
               Right = 297
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCurrency"
            Begin Extent = 
               Top = 161
               Left = 10
               Bottom = 291
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tCostCenter"
            Begin Extent = 
               Top = 17
               Left = 7
               Bottom = 147
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanElement"
            Begin Extent = 
               Top = 77
               Left = 278
               Bottom = 207
               Right = 502
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "tPlanElementInstance"
            Begin Extent = 
               Top = 266
               Left = 328
               Bottom = 396
               Right = 527
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanGroup"
            Begin Extent = 
               Top = 311
               Left = 0
               Bottom = 441
               Right = 206
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

