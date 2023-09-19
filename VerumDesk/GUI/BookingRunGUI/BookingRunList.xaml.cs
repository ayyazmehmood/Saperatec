using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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
using VerumBusinessObjects.Framework;
using VerumDesk.GUI.BookingRunGUI;
using VerumDesk.Controller;
using System.ComponentModel;
using System.IO.Packaging;
using System.Windows.Forms;
using System.Net;
using System.IO;

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für BookingRunList.xaml
    /// </summary>
    public partial class BookingRunList : Window
    {
        private BOCollection<BookingRun, tBookingRun> BOColl;
        private ObservableCollection<BookingRun> listItems;
        private PlanItemEdit planWindow;
        private bool? activeFilter;
        public Task myTask=null;

        public BookingRunList()
        {
            InitializeComponent();
            ListUpdate();
            InitTabElement();
        }

        ObservableCollection<ReferenceGroup> colReferenceGroup;
        private void InitTabElement()
        {
            // init reference group combo box
            colReferenceGroup = ReferenceGroup.GetBOCollection().GetObservableCollection();
            
            foreach (var item in listItems)
            {
                if(!cbYear.Items.Contains(item.PeriodYear)) cbYear.Items.Add(item.PeriodYear);
            }
            
        }
        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {

            //BookingRun item;

            //if (dgMain.SelectedItem != null)
            //{
            //    item = (BookingRun)dgMain.SelectedItem;

            //    switch (item.Delete())
            //    {
            //        case BOResult.BookingRunCannotDelete:
            //            System.Windows.MessageBox.Show("Der Buchungsschlüssel konnte nicht gelöscht werden.", "Buchungsschlüssel löschen", MessageBoxButton.OK, MessageBoxImage.Exclamation);
            //            break;

            //        case BOResult.GeneralError:
            //            System.Windows.MessageBox.Show("Unerwarteter Fehler beim Löschen des Buchungsschlüssel.", "Buchungsschlüssel löschen", MessageBoxButton.OK, MessageBoxImage.Error);
            //            break;

            //        case BOResult.Success:
            //            listItems.Remove(item);
            //            ListUpdate();
            //            break;
            //    }
            //}
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void ListUpdate()
        {

            BOColl = BookingRun.GetBOCollection();

            listItems = new ObservableCollection<BookingRun>();

            foreach (var BO in BOColl)
                listItems.Add(BO);

            if(cbYear.SelectedItem != null) listItems = new ObservableCollection<BookingRun>(from item in listItems where (int)cbYear.SelectedValue == item.PeriodYear select item);
            if(cbMonth.SelectedItem != null) listItems = new ObservableCollection<BookingRun>(from item in listItems where (short)cbMonth.SelectedValue == item.PeriodMonth select item);
            if(cbPreliminary.IsChecked != null) listItems = new ObservableCollection<BookingRun>(from item in listItems where item.StatusPreliminary == cbPreliminary.IsChecked select item);
            dgMain.ItemsSource = listItems;

            // dgMain.Items.SortDescriptions.Add(new SortDescription("TitlePlan", ListSortDirection.Ascending));            
        }

        private void ItemCreatedEventHandler(object sender, BookingRun item)
        {
            //Dispatcher.BeginInvoke(new Action(() => { ctrlProgress.Value = e.ItemsComplete; }));
            listItems.Add(item);
        }

        private void ItemUpdatedEventHandler(object sender, BookingRun user)
        {
            ListUpdate();
        }
        private void cbYear_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ListUpdate();
            cbMonth.Items.Clear();
            foreach (var item in listItems)
            {
                if (!cbMonth.Items.Contains(item.PeriodMonth)) cbMonth.Items.Add(item.PeriodMonth);
            }
            //cbMonth.Items.SortDescriptions.Add(new System.ComponentModel.SortDescription("PeriodMonth", System.ComponentModel.ListSortDirection.Ascending));
        }
        private void cbMonth_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ListUpdate();
        }

        private void cbPreliminary_Click(object sender, RoutedEventArgs e)
        {
            ListUpdate();
        }

        private void btnImport_Click(object sender, RoutedEventArgs e)
        {
            ImportDATEVJournals wnd = new ImportDATEVJournals();
            wnd.Show();
        }

        private void btnStatus_Click(object sender, RoutedEventArgs e)
        {
            ChangeStatus wnd = new ChangeStatus((BookingRun)dgMain.SelectedItem);
            wnd.Show();
        }

        private void btnOpen_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new BookTransactionList(((BookingRun)dgMain.SelectedItem).Id);
            wnd.Show();
        }

        private void btnUpdate_Click(object sender, RoutedEventArgs e)
        {
            BCBookingUpdate bcw = new BCBookingUpdate();
            bcw.Show();
        }
    }
}
