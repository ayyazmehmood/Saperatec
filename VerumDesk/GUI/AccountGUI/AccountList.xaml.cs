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
    /// Interaktionslogik für AccountList.xaml
    /// </summary>
    public partial class AccountList : Window
    {
        private BOCollection<Account, tAccount> BOColl;
        private ObservableCollection<Account> listItems;

        public AccountList()
        {
            InitializeComponent();
            ListUpdate();
            InitTabElement();
        }

        ObservableCollection<AccountGroup> colGroup;
        ObservableCollection<AccountMainGroup> colMainGroup;
        ObservableCollection<AccountSection> colSection;
        private void InitTabElement() 
        {
            // init reference group combo box
            colGroup = AccountGroup.GetBOCollection().GetObservableCollection();
            colMainGroup = AccountMainGroup.GetBOCollection().GetObservableCollection();
            colSection = AccountSection.GetBOCollection().GetObservableCollection();


            cbGroup.ItemsSource = colGroup.Select(i => $"{i.TitleLocalAccountGroup}");
            cbMainGroup.ItemsSource = colMainGroup.Select(i => $"{i.TitleLocalMainGroup}");
            cbSection.ItemsSource = colSection.Select(i => $"{i.TitleLocalSection}");
        }

        private void btnCreate_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new AccountEdit();
            wnd.ItemUpdated += ItemCreatedEventHandler;
            wnd.Show();
        }

        private void btnOpen_Click(object sender, RoutedEventArgs e)
        {
            if (dgMain.SelectedItem != null)
            {
                var wnd = new AccountEdit((Account)dgMain.SelectedItem);
                wnd.ItemUpdated += ItemUpdatedEventHandler;
                wnd.Show();
            }
        }

        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {

            Account item;

            if (dgMain.SelectedItem != null)
            {
                item = (Account)dgMain.SelectedItem;

                switch (item.Delete())
                {
                    case BOResult.AccountCannotDelete:
                        System.Windows.MessageBox.Show("Das Konto konnte nicht gelöscht werden.", "Konto löschen", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                        break;

                    case BOResult.GeneralError:
                        System.Windows.MessageBox.Show("Unerwarteter Fehler beim Löschen des Kontos.", "Konto löschen", MessageBoxButton.OK, MessageBoxImage.Error);
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

            BOColl = Account.GetBOCollection();

            listItems = new ObservableCollection<Account>();

            foreach (var BO in BOColl)
                    listItems.Add(BO);
                
            if(cbSection.SelectedItem != null) 
            {
                listItems = new ObservableCollection<Account>(from item in listItems where item.idAccountSection == colSection.ElementAt(cbSection.SelectedIndex).Id select item);
            }
            if(cbMainGroup.SelectedItem != null)
            {
                listItems = new ObservableCollection<Account>(from item in listItems where item.idAccountMainGroup == colMainGroup.ElementAt(cbMainGroup.SelectedIndex).Id select item);
            }
            if(cbGroup.SelectedItem != null)
            {
                listItems = new ObservableCollection<Account>(from item in listItems where item.idAccountGroup == colGroup.ElementAt(cbGroup.SelectedIndex).Id select item);
            }

            listItems = new ObservableCollection<Account>(from item in listItems where item.TitleLocalAccount.ToUpper().Contains(tbFilter.Text.ToUpper()) select item);

            if(cbPlan.IsChecked != null) listItems = new ObservableCollection<Account>(from item in listItems where item.FlagPlan = (bool)cbPlan.IsChecked select item);

            dgMain.ItemsSource = listItems.Distinct();
            dgMain.Items.SortDescriptions.Clear();
            // dgMain.Items.SortDescriptions.Add(new SortDescription("TitlePlan", ListSortDirection.Ascending));            
        }

        private void ItemCreatedEventHandler(object sender, Account item)
        {
            //Dispatcher.BeginInvoke(new Action(() => { ctrlProgress.Value = e.ItemsComplete; }));
            listItems.Add(item);
        }

        private void ItemUpdatedEventHandler(object sender, Account user)
        {
            ListUpdate();
        }

        private void cbGroup_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ListUpdate();
        }

        private void cbMainGroup_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            //if(cbMainGroup.SelectedIndex != (cbMainGroup.SelectedIndex = cbMainGroup.Items.Count - 1))
            if(cbMainGroup.SelectedIndex != -1)
            {
                colGroup = new ObservableCollection<AccountGroup>(from item in AccountGroup.GetBOCollection().GetObservableCollection() where item.idAccountMainGroup == colMainGroup.ElementAt(cbMainGroup.SelectedIndex).Id select item);
                cbGroup.ItemsSource = colGroup.Select(i => $"{i.TitleLocalAccountGroup}");
                cbGroup.SelectedItem = null;
            }
            ListUpdate();
        }

        private void cbSection_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            //if (cbSection.SelectedIndex != (cbSection.SelectedIndex = cbSection.Items.Count - 1))
            if (cbSection.SelectedIndex != -1)
            {
                colMainGroup = new ObservableCollection<AccountMainGroup>(from item in AccountMainGroup.GetBOCollection().GetObservableCollection() where item.idAccountSection == colSection.ElementAt(cbSection.SelectedIndex).Id select item);
                cbMainGroup.ItemsSource = colMainGroup.Select(i => $"{i.TitleLocalMainGroup}");
                cbMainGroup.SelectedItem = null;
                cbGroup.SelectedItem = null;
            }
            ListUpdate();
        }

        private void tbFilter_TextChanged(object sender, TextChangedEventArgs e)
        {
            ListUpdate();
        }

        private void cbPlan_Click(object sender, RoutedEventArgs e)
        {
            ListUpdate();
        }

    }
}
