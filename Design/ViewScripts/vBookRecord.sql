USE [VerumDBDev]
GO

/****** Object:  View [dbo].[vBookRecord]    Script Date: 20.06.2020 07:10:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vBookRecord]
AS
SELECT        TOP (100) PERCENT dbo.tBookRecord.idClient, dbo.tPlanElement.TitlePlanElement, dbo.tBookRecord.BookingDate, tAccountDebit.AccountCode AS AccountCodeDebit, tAccountDebit.TitleLocalAccount AS AccountTitleDebit, 
                         tAccountCredit.AccountCode AS AccountCodeCredit, tAccountCredit.TitleLocalAccount AS AccountTitleCredit, dbo.tBookRecord.Amount, dbo.tBookRecord.TitleBookRecord, dbo.tCostCenter.CostCenterCode, 
                         dbo.tCostCenter.TitleCostCenter, dbo.tBookRecord.TypeBookRecord, dbo.tBookRecord.BookingDocument, dbo.tBookRecord.ReferenceIDBookRecord, dbo.tBookRecord.BookRecordComment, dbo.tBookRecord.Id
FROM            dbo.tPlanElementInstance RIGHT OUTER JOIN
                         dbo.tPlanElement ON dbo.tPlanElementInstance.idPlanElement = dbo.tPlanElement.Id RIGHT OUTER JOIN
                         dbo.tBookRecord INNER JOIN
                         dbo.tClient ON dbo.tBookRecord.idClient = dbo.tClient.Id INNER JOIN
                         dbo.tAccount AS tAccountCredit ON dbo.tBookRecord.idAccountCredit = tAccountCredit.Id INNER JOIN
                         dbo.tAccount AS tAccountDebit ON dbo.tBookRecord.idAccountDebit = tAccountDebit.Id INNER JOIN
                         dbo.tCostCenter ON dbo.tBookRecord.idCostCenterBookRecord = dbo.tCostCenter.Id ON dbo.tPlanElementInstance.Id = dbo.tBookRecord.idPlanElementInstance
ORDER BY dbo.tPlanElement.TitlePlanElement, dbo.tBookRecord.BookingDate, AccountCodeDebit, AccountCodeCredit
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[27] 2[13] 3) )"
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
         Begin Table = "tPlanElementInstance"
            Begin Extent = 
               Top = 189
               Left = 731
               Bottom = 352
               Right = 926
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanElement"
            Begin Extent = 
               Top = 287
               Left = 323
               Bottom = 450
               Right = 585
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "tBookRecord"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 351
               Right = 260
            End
            DisplayFlags = 280
            TopColumn = 12
         End
         Begin Table = "tClient"
            Begin Extent = 
               Top = 11
               Left = 339
               Bottom = 141
               Right = 533
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "tAccountCredit"
            Begin Extent = 
               Top = 30
               Left = 850
               Bottom = 157
               Right = 1046
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "tAccountDebit"
            Begin Extent = 
               Top = 10
               Left = 636
               Bottom = 140
               Right = 832
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "tCostCenter"
            Begin Extent = 
               Top = 90
               Left = 496
               Bottom = 220
               Right = 672
       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vBookRecord'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     End
            DisplayFlags = 280
            TopColumn = 3
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
         Column = 2070
         Alias = 2070
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vBookRecord'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vBookRecord'
GO

