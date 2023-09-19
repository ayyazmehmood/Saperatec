using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using VerumBusinessObjects;
using System.Collections.ObjectModel;

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für AllocationScheduleEdit.xaml
    /// </summary>
    public partial class AllocationScheduleEdit : Window
    {
        ObservableCollection<TypeSelector> colPeriod;
        PlanAllocationSchedule item;

        public AllocationScheduleEdit(Guid idPlan, string title = "")
        {
            item = new PlanAllocationSchedule();
            item.New();
            item.idPlan = idPlan;
            item.MonthsBetweenItems = (short)TypeRegularPeriods.Monthly;
            item.TitleAllocationSchedule = title;
            item.FlagScheduleShared = false;
            item.FlagAuto = false;
            item.FlagAbsoluteRates = true;

            InitializeWindow();
        }

        public AllocationScheduleEdit(PlanAllocationSchedule item)
        {
            this.item = item;
            InitializeWindow();
        }

        private void InitializeWindow()
        {
            InitializeComponent();
            this.DataContext = item;

            // init period combo
            {
                colPeriod = new ObservableCollection<TypeSelector>();
                colPeriod.Add(new TypeSelector((short)TypeRegularPeriods.Annually, "Jährlich"));
                colPeriod.Add(new TypeSelector((short)TypeRegularPeriods.Semiannually, "Halbjährlich"));
                colPeriod.Add(new TypeSelector((short)TypeRegularPeriods.Quarterly, "Quartalsweise"));
                colPeriod.Add(new TypeSelector((short)TypeRegularPeriods.Monthly, "Monatlich"));
                cbMonthsBetween.ItemsSource = colPeriod.Select(b => b.Title);
                cbMonthsBetween.SelectedIndex = colPeriod.IndexOf(colPeriod.FirstOrDefault(b => b.TypeCode == item.MonthsBetweenItems));
            }

            if ((bool)chkFlagShared.IsChecked)
                tbTitle.IsEnabled = true;
            else
                tbTitle.IsEnabled = false;

            FormatValueFields();
            InitAutoplan();
        }

        private void cmdOK_Click(object sender, RoutedEventArgs e)
        {

            if (tbTitle.Text.Trim() == "")
            {
                System.Windows.MessageBox.Show("Einem Zahlungsplan muss ein Titel zugewiesen werden.", "Zahlungsplan erstellen", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            try
            {
                item.CommitChanges();
                OnRaiseItemUpdated();
                this.Close();
            }
            catch (Exception ex)
            {
                System.Windows.MessageBox.Show("Unerwarteter Fehler beim Bearbeiten eines Zahlungsplans.", "Zahlungsplan bearbeiten", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            item.RollbackChanges();
            OnRaiseItemUpdated();
            this.Close();
        }

        public event EventHandler<PlanAllocationSchedule> ItemUpdated;

        protected virtual void OnRaiseItemUpdated()
        {
            ItemUpdated?.Invoke(this, item);
        }

        private void cbMonthsBetween_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            item.MonthsBetweenItems = colPeriod.ElementAt(cbMonthsBetween.SelectedIndex).TypeCode;
        }

        private void chkFlagShared_Checked(object sender, RoutedEventArgs e)
        {
            tbTitle.IsEnabled = true;
        }

        private void chkFlagShared_Unchecked(object sender, RoutedEventArgs e)
        {
            tbTitle.IsEnabled = false;
        }

        private void chkAutoplan_Changed(object sender, RoutedEventArgs e)
        {
            InitAutoplan();
        }

        private void chkFlagAbsolute_Changed(object sender, RoutedEventArgs e)
        {
            FormatValueFields();
        }

        private void InitAutoplan()
        {
            if ((bool)chkAutoplan.IsChecked)
            {
                tbPeriod1.IsEnabled = true;
                tbPeriod2.IsEnabled = true;
                tbPeriod3.IsEnabled = true;
                tbRate1.IsEnabled = true;
                tbRate2.IsEnabled = true;
                tbRate3.IsEnabled = true;
            }
            else
            {
                tbPeriod1.IsEnabled = false;
                tbPeriod2.IsEnabled = false;
                tbPeriod3.IsEnabled = false;
                tbRate1.IsEnabled = false;
                tbRate2.IsEnabled = false;
                tbRate3.IsEnabled = false;
            }
        }

        private void FormatValueFields()
        {
            if ((bool)chkFlagAbsolute.IsChecked)
            {
                tbPerpetualRate.FormatString = "C2";
                tbRate1.FormatString = "C2";
                tbRate2.FormatString = "C2";
                tbRate3.FormatString = "C2";
            }
            else
            {
                tbPerpetualRate.FormatString = "P2";
                tbRate1.FormatString = "P2";
                tbRate2.FormatString = "P2";
                tbRate3.FormatString = "P2";
            }

        }

    }
}
