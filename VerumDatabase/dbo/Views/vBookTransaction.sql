CREATE VIEW [dbo].[vBookTransaction]
AS
SELECT        dbo.tBookTransaction.BookingDate AS [Booking Date], dbo.tBookTransaction.AccountCodeReport AS [Account Report Code], AccountReport.TitleLocalAccount AS [Account Report Title], 
                         AccountReport.TypeAccount AS [Type Account], dbo.tBookTransaction.FlagAccountOpening, dbo.tBookTransaction.CostCenterCode AS [Cost Center Code], dbo.tCostCenter.TitleCostCenter AS [Cost Center Title], 
                         dbo.tBookTransaction.AmountDebit AS [Amount Debit], dbo.tBookTransaction.AmountCredit AS [Amount Credit], dbo.tBookRecord.TitleBookRecord AS [Booking Title], dbo.tBookRecord.BookingDocument AS [Booking Document], 
                         dbo.tBookRecord.ReferenceIDBookRecord AS [Booking Reference], dbo.tBookRecord.BookRecordComment AS [Booking Comment], dbo.tBookTransaction.TypeBookRecord AS [Type Booking Record], 
                         dbo.tPlanElement.TitlePlanElement AS [Plan Element Title], AccountBooking.AccountCode AS [Account Booking Code], AccountBooking.TitleLocalAccount AS [Account Booking Title], 
                         dbo.tBookRecord.AccountCodeDebit AS [Booking Account Debit], dbo.tBookRecord.AccountCodeCredit AS [Booking Account Credit], dbo.tBookRecord.BookingRunCode AS [Booking Run Code], 
                         dbo.tBookRecord.BookingSequenceNum AS [Booking Sequence No], dbo.tBookRecord.DATEVBUCode AS [DATEV BU Code], dbo.tBookTransaction.MonthIndex AS [Month Index], dbo.tBookTransaction.Id, 
                         dbo.tBookTransaction.idClient, dbo.tBookTransaction.idPlan
FROM            dbo.tBookTransaction INNER JOIN
                         dbo.tAccount AS AccountReport ON dbo.tBookTransaction.idAccountReport = AccountReport.Id INNER JOIN
                         dbo.tBookRecord ON dbo.tBookTransaction.idBookingRecord = dbo.tBookRecord.Id INNER JOIN
                         dbo.tAccount AS AccountBooking ON dbo.tBookTransaction.idAccountBooking = AccountBooking.Id LEFT OUTER JOIN
                         dbo.tPlanElement ON dbo.tBookTransaction.idPlanElement = dbo.tPlanElement.Id LEFT OUTER JOIN
                         dbo.tCostCenter ON dbo.tBookTransaction.idCostCenter = dbo.tCostCenter.Id
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[54] 4[36] 2[9] 3) )"
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
         Begin Table = "tBookTransaction"
            Begin Extent = 
               Top = 70
               Left = 439
               Bottom = 460
               Right = 636
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AccountReport"
            Begin Extent = 
               Top = 19
               Left = 34
               Bottom = 149
               Right = 288
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "tBookRecord"
            Begin Extent = 
               Top = 7
               Left = 736
               Bottom = 282
               Right = 958
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "AccountBooking"
            Begin Extent = 
               Top = 190
               Left = 34
               Bottom = 320
               Right = 289
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "tPlanElement"
            Begin Extent = 
               Top = 313
               Left = 743
               Bottom = 443
               Right = 967
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "tCostCenter"
            Begin Extent = 
               Top = 378
               Left = 31
               Bottom = 508
               Right = 303
            End
            DisplayFlags = 280
            TopColumn = 6
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
     ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vBookTransaction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'    Column = 3810
         Alias = 2115
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vBookTransaction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vBookTransaction'