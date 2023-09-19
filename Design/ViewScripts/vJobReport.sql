USE [VerumDBDev]
GO

/****** Object:  View [dbo].[vJobReport]    Script Date: 08.06.2020 09:26:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vJobReport]
AS
SELECT        dbo.tUser.UserName AS [User Name], dbo.tClient.TitleClient AS [Client Name], dbo.tJobReport.DateJobStart AS [Job Start Time], dbo.tJobReport.DateJobEnd AS [Job End Time], dbo.tJobReport.TypeJob AS [Type of Job], 
                         dbo.tJobReport.TypeJobSuccess AS [Job Success], dbo.tJobReportItem.Timestamp AS [Item Timestamp], dbo.tJobReportItem.TypeJobSuccess AS [Item Success], dbo.tJobReportItem.ResultCode AS [Item Result], 
                         dbo.tJobReportItem.ObjectTitle AS Object, dbo.tJobReportItem.ContextInfo AS Context, dbo.tJobReportItem.Message, dbo.tJobReport.idClient, dbo.tJobReport.idUser, dbo.tJobReportItem.idJobReport
FROM            dbo.tJobReport INNER JOIN
                         dbo.tJobReportItem ON dbo.tJobReport.Id = dbo.tJobReportItem.idJobReport INNER JOIN
                         dbo.tClient ON dbo.tJobReport.idClient = dbo.tClient.Id INNER JOIN
                         dbo.tUser ON dbo.tJobReport.idUser = dbo.tUser.Id
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "tJobReport"
            Begin Extent = 
               Top = 13
               Left = 481
               Bottom = 288
               Right = 683
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tJobReportItem"
            Begin Extent = 
               Top = 0
               Left = 826
               Bottom = 271
               Right = 1032
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tClient"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 214
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tUser"
            Begin Extent = 
               Top = 155
               Left = 249
               Bottom = 335
               Right = 443
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
         Column = 2775
         Alias = 2790
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vJobReport'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vJobReport'
GO

