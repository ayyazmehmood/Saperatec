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

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für ReferenceCodeList.xaml
    /// </summary>
    public partial class ReferenceCodeList : Window
    {
        private BOCollection<ReferenceCode, tReferenceCode> BOColl;
        private ObservableCollection<ReferenceCode> listItems;
        private PlanItemEdit planWindow;
        private bool? activeFilter;

        public ReferenceCodeList()
        {
            InitializeComponent();
            InitTabElement();
            ListUpdate();
            btnSelect.Visibility = Visibility.Collapsed;
        }

        public ReferenceCodeList(PlanItemEdit planWindow)
        {
            InitializeComponent();
            InitTabElement();
            ListUpdate();
            this.planWindow = planWindow;

            btnCreate.Visibility = Visibility.Collapsed;
            btnDelete.Visibility = Visibility.Collapsed;
            btnOpen.Visibility = Visibility.Collapsed;
        }

        ObservableCollection<ReferenceGroup> colReferenceGroup;
        private void InitTabElement()
        {
            // init reference group combo box
            colReferenceGroup = ReferenceGroup.GetBOCollection().GetObservableCollection();
            cbGroupFilter.ItemsSource = colReferenceGroup.Select(i => $"{i.TitleReferenceGroup}").Append("Alle");

            List<string> myList = new List<string>();
            myList.Add("Aktiv");
            myList.Add("Inaktiv");
            myList.Add("Alle");
            cbFilterActive.ItemsSource = myList;

            cbFilterActive.SelectedIndex = cbFilterActive.Items.Count - 1;
            cbGroupFilter.SelectedIndex = cbGroupFilter.Items.Count - 1;            
        }

        private void btnCreate_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new ReferenceCodeEdit();
            wnd.ItemUpdated += ItemCreatedEventHandler;
            wnd.Show();
        }

        private void btnOpen_Click(object sender, RoutedEventArgs e)
        {
            if(planWindow != null) btnSelect_Click(sender, e);
            else
            {
                if (dgMain.SelectedItem != null)
                {
                    var wnd = new ReferenceCodeEdit((ReferenceCode)dgMain.SelectedItem);
                    wnd.ItemUpdated += ItemUpdatedEventHandler;
                    wnd.Show();
                }
            }
        }

        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {
            
            ReferenceCode item;

            if (dgMain.SelectedItem != null)
            {
                item = (ReferenceCode)dgMain.SelectedItem;

                switch (item.Delete())
                {
                    case BOResult.ReferenceCodeCannotDelete:
                        System.Windows.MessageBox.Show("Der Buchungsschlüssel konnte nicht gelöscht werden.", "Buchungsschlüssel löschen", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                        break;

                    case BOResult.GeneralError:
                        System.Windows.MessageBox.Show("Unerwarteter Fehler beim Löschen des Buchungsschlüssel.", "Buchungsschlüssel löschen", MessageBoxButton.OK, MessageBoxImage.Error);
                        break;

                    case BOResult.Success:
                        listItems.Remove(item);
                        ListUpdate();
                        break;
                }
            }           
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void ListUpdate()
        {

            BOColl = ReferenceCode.GetBOCollection();

            listItems = new ObservableCollection<ReferenceCode>();

            foreach (var BO in BOColl)
                listItems.Add(BO);

            if(cbGroupFilter.SelectedIndex == -1) cbGroupFilter.SelectedIndex = cbGroupFilter.Items.Count -1;

            if ((string)cbGroupFilter.SelectedItem == "Alle")
            {
                if(activeFilter != null) listItems = new ObservableCollection<ReferenceCode>(from item in listItems where item.TitleRefCode.ToUpper().Contains(tbFilter.Text.ToUpper()) && item.FlagActive == activeFilter select item);
                else listItems = new ObservableCollection<ReferenceCode>(from item in listItems where item.TitleRefCode.ToUpper().Contains(tbFilter.Text.ToUpper()) select item);
            }

            //else listItems = new ObservableCollection<ReferenceCode>(from item in listItems where item.TitleRefCode.ToUpper().Contains(tbFilter.Text.ToUpper()) && item.FlagActive == cbFilterActive.IsChecked && item.ReferenceGroupParent.TitleReferenceGroup == (string)cbGroupFilter.SelectedItem select item);
            else if (activeFilter != null) listItems = new ObservableCollection<ReferenceCode>(from item in listItems where item.TitleRefCode.ToUpper().Contains(tbFilter.Text.ToUpper()) && item.FlagActive == activeFilter && item.idReferenceGroup == colReferenceGroup.ElementAt(cbGroupFilter.SelectedIndex).Id select item);
            else listItems = new ObservableCollection<ReferenceCode>(from item in listItems where item.TitleRefCode.ToUpper().Contains(tbFilter.Text.ToUpper()) && item.idReferenceGroup == colReferenceGroup.ElementAt(cbGroupFilter.SelectedIndex).Id select item);


            dgMain.ItemsSource = listItems;

            dgMain.Items.SortDescriptions.Clear();

            // dgMain.Items.SortDescriptions.Add(new SortDescription("TitlePlan", ListSortDirection.Ascending));            
        }

        private void ItemCreatedEventHandler(object sender, ReferenceCode item)
        {
            //Dispatcher.BeginInvoke(new Action(() => { ctrlProgress.Value = e.ItemsComplete; }));
            listItems.Add(item);
        }

        private void ItemUpdatedEventHandler(object sender, ReferenceCode user)
        {
            ListUpdate();
        }

        private void tbFilter_TextChanged(object sender, TextChangedEventArgs e)
        {
            ListUpdate();
        }

        private void cbFilterActive_Click(object sender, RoutedEventArgs e)
        {
            ListUpdate();
        }

        private void cbGroupFilter_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ListUpdate();
        }

        private void btnSelect_Click(object sender, RoutedEventArgs e)
        {
            if (dgMain.SelectedItem != null)
            {
                planWindow.tbReferenceID.Text = ((ReferenceCode)dgMain.SelectedItem).RefCode;
                this.Close();
            }   
        }

        private void cbFilterActive_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if((string)cbFilterActive.SelectedItem == "Aktiv") activeFilter = true;
            else if ((string)cbFilterActive.SelectedItem == "Inaktiv") activeFilter = false;
            else activeFilter = null;
            ListUpdate();
        }
    }
}
