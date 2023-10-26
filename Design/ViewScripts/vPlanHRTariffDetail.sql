USE [VerumDBDev]
GO

/****** Object:  View [dbo].[vPlanHRTariffDetail]    Script Date: 08.06.2020 16:53:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vPlanHRTariffDetail]
AS
SELECT        dbo.tPlanHRTariff.idPlan, dbo.tPlanHRTariff.TitleTariff AS [Tariff Title], dbo.tPlanHRTariffDetail.DateValidTo AS [Valid To], dbo.tPlanHRTariffDetail.WorkTimeWeekly AS [Work Hours per Week], 
                         dbo.tPlanHRTariffDetail.FTEFactor AS [FTE Factor], dbo.tPlanHRTariffDetail.RatioShiftNight AS [Ratio Night Shift], dbo.tPlanHRTariffDetail.RatioShiftSpecial AS [Ratio Special Shift], 
                         dbo.tPlanHRTariffDetail.RatioOvertime AS [Ratio Overtime], dbo.tPlanHRTariffDetail.AnnualLeave AS [Annual Days Leave], dbo.tPlanHRTariffDetail.StandardHolidays AS [Annual Holidays], 
                         dbo.tPlanHRTariffDetail.BaseSalaryMonthly AS [Base Salary per Month], dbo.tPlanHRTariffDetail.RateShiftNight AS [Rate Add Night Shift], dbo.tPlanHRTariffDetail.RateShiftSpecial AS [Rate Add Special Shift], 
                         dbo.tPlanHRTariffDetail.RateOvertime AS [Rate Overtime], dbo.tPlanHRTariffDetail.RateAnnualBonus AS [Rate Annual Bonus], dbo.tPlanHRTariffDetail.AnnualBonusMonth AS [Bonus Month], dbo.tPlanHRTariffDetail.Id
FROM            dbo.tPlanHRTariffDetail INNER JOIN
                         dbo.tPlanHRTariff ON dbo.tPlanHRTariffDetail.idTariff = dbo.tPlanHRTariff.Id
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[49] 2[8] 3) )"
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
         Begin Table = "tPlanHRTariffDetail"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 338
               Right = 234
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tPlanHRTariff"
            Begin Extent = 
               Top = 6
               Left = 272
               Bottom = 136
               Right = 449
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
         Column = 2205
         Alias = 2595
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanHRTariffDetail'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vPlanHRTariffDetail'
GO
