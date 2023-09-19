USE [VerumDBDev]
GO

/****** Object:  View [dbo].[vAccountPlanning]    Script Date: 08.06.2020 09:13:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vAccountPlanning]
AS
SELECT dbo.tAccount.idClient, dbo.tAccountGroup.TitleLocalAccountGroup AS [Group], dbo.tAccount.AccountCode AS Code, dbo.tAccount.TitleLocalAccount AS [Title local], dbo.tAccount.TitleEnglishAccount AS [Title english], 
                  dbo.tAccount.TypeAccount AS Type, AccountReporting.AccountCode AS [Report Account], dbo.tAccount.FlagPlan AS Planning, dbo.tAccount.Id
FROM     dbo.tAccount LEFT OUTER JOIN
                  dbo.tAccountGroup ON dbo.tAccount.idAccountGroup = dbo.tAccountGroup.Id LEFT OUTER JOIN
                  dbo.tAccount AS AccountReporting ON dbo.tAccount.idAccountReporting = AccountReporting.Id
WHERE  (dbo.tAccount.FlagPlan = 1)
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[55] 4[41] 2[2] 3) )"
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
         Begin Table = "tAccount"
            Begin Extent = 
               Top = 28
               Left = 686
               Bottom = 400
               Right = 914
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tAccountGroup"
            Begin Extent = 
               Top = 141
               Left = 275
               Bottom = 304
               Right = 541
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "AccountReporting"
            Begin Extent = 
               Top = 161
               Left = 1057
               Bottom = 324
               Right = 1285
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
         Column = 2604
         Alias = 3540
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAccountPlanning'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAccountPlanning'
GO

