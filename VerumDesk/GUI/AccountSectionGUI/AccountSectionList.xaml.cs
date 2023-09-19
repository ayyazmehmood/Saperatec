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
    /// Interaktionslogik für AccountSectionList.xaml
    /// </summary>
    public partial class AccountSectionList : Window
    {
        private BOCollection<AccountSection, tAccountSection> BOColl;
        private ObservableCollection<AccountSection> listItems;

        public AccountSectionList()
        {
            InitializeComponent();
            ListUpdate();
            InitTabElement();
        }

        ObservableCollection<AccountSection> colMainGroup;
        ObservableCollection<AccountSection> colSection;
        private void InitTabElement()
        {
            // init reference group combo box
        }

        private void btnCreate_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new AccountSectionEdit();
            wnd.ItemUpdated += ItemCreatedEventHandler;
            wnd.Show();
        }

        private void btnOpen_Click(object sender, RoutedEventArgs e)
        {
            if (dgMain.SelectedItem != null)
            {
                var wnd = new AccountSectionEdit((AccountSection)dgMain.SelectedItem);
                wnd.ItemUpdated += ItemUpdatedEventHandler;
                wnd.Show();
            }
        }

        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {

            AccountSection item;

            if (dgMain.SelectedItem != null)
            {
                item = (AccountSection)dgMain.SelectedItem;

                switch (item.Delete())
                {
                    case BOResult.AccountSectionCannotDelete:
                        System.Windows.MessageBox.Show("Die Kontogruppe konnte nicht gelöscht werden.", "Kontogruppe löschen", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                        break;

                    case BOResult.GeneralError:
                        System.Windows.MessageBox.Show("Unerwarteter Fehler beim Löschen der Kontogruppe.", "Kontogruppe löschen", MessageBoxButton.OK, MessageBoxImage.Error);
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
            BOColl = AccountSection.GetBOCollection();

            listItems = new ObservableCollection<AccountSection>();

            foreach (var BO in BOColl)
                listItems.Add(BO);

            //if (cbSection.SelectedItem != null)
            //{
            //    colMainGroup = new ObservableCollection<AccountSection>(from item in colMainGroup where item.idAccountSection == colSection.ElementAt(cbSection.SelectedIndex).Id select item);
            //}
            

            dgMain.ItemsSource = listItems.Distinct();
            dgMain.Items.SortDescriptions.Clear();
            // dgMain.Items.SortDescriptions.Add(new SortDescription("TitlePlan", ListSortDirection.Ascending));            
        }

        private void ItemCreatedEventHandler(object sender, AccountSection item)
        {
            //Dispatcher.BeginInvoke(new Action(() => { ctrlProgress.Value = e.ItemsComplete; }));
            listItems.Add(item);
        }

        private void ItemUpdatedEventHandler(object sender, AccountSection user)
        {
            ListUpdate();
        }
    }
}
