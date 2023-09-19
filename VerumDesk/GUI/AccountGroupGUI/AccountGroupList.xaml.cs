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
    /// Interaktionslogik für AccountGroupList.xaml
    /// </summary>
    public partial class AccountGroupList : Window
    {
        private BOCollection<AccountGroup, tAccountGroup> BOColl;
        private ObservableCollection<AccountGroup> listItems;

        public AccountGroupList()
        {
            InitializeComponent();
            ListUpdate();
            InitTabElement();
        }

        ObservableCollection<AccountMainGroup> colMainGroup;
        ObservableCollection<AccountSection> colSection;
        private void InitTabElement()
        {
            // init reference group combo box
            colMainGroup = AccountMainGroup.GetBOCollection().GetObservableCollection();
            colSection = AccountSection.GetBOCollection().GetObservableCollection();

            cbMainGroup.ItemsSource = colMainGroup.Select(i => $"{i.TitleLocalMainGroup}");
            cbSection.ItemsSource = colSection.Select(i => $"{i.TitleLocalSection}");

            //cbGroup.SelectedIndex = 0;
            //cbMainGroup.SelectedIndex = 0;
            //cbSection.SelectedIndex = 0;



            //cbSection.SelectedIndex = cbSection.Items.Count - 1;
            //cbMainGroup.SelectedIndex = cbMainGroup.Items.Count - 1;
            //cbGroup.SelectedIndex = cbGroup.Items.Count - 1;



        }

        private void btnCreate_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new AccountGroupEdit();
            wnd.ItemUpdated += ItemCreatedEventHandler;
            wnd.Show();
        }

        private void btnOpen_Click(object sender, RoutedEventArgs e)
        {
            if (dgMain.SelectedItem != null)
            {
                var wnd = new AccountGroupEdit((AccountGroup)dgMain.SelectedItem);
                wnd.ItemUpdated += ItemUpdatedEventHandler;
                wnd.Show();
            }
        }

        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {

            AccountGroup item;

            if (dgMain.SelectedItem != null)
            {
                item = (AccountGroup)dgMain.SelectedItem;

                switch (item.Delete())
                {
                    case BOResult.AccountGroupCannotDelete:
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
            BOColl = AccountGroup.GetBOCollection();

            listItems = new ObservableCollection<AccountGroup>();

            foreach (var BO in BOColl)
                listItems.Add(BO);

            //if (cbSection.SelectedItem != null)
            //{
            //    colMainGroup = new ObservableCollection<AccountMainGroup>(from item in colMainGroup where item.idAccountSection == colSection.ElementAt(cbSection.SelectedIndex).Id select item);
            //}
            if (cbMainGroup.SelectedItem != null)
            {
                //listItems = (ObservableCollection<Account>)listItems.Union<Account>(new ObservableCollection<Account>(from item in listItems where item.idAccountMainGroup == colMainGroup.ElementAt(cbMainGroup.SelectedIndex).Id select item));
                listItems = new ObservableCollection<AccountGroup>(from item in listItems where item.idAccountMainGroup == colMainGroup.ElementAt(cbMainGroup.SelectedIndex).Id select item);
            }

            dgMain.ItemsSource = listItems.Distinct();
            dgMain.Items.SortDescriptions.Clear();
            // dgMain.Items.SortDescriptions.Add(new SortDescription("TitlePlan", ListSortDirection.Ascending));            
        }

        private void ItemCreatedEventHandler(object sender, AccountGroup item)
        {
            //Dispatcher.BeginInvoke(new Action(() => { ctrlProgress.Value = e.ItemsComplete; }));
            listItems.Add(item);
        }

        private void ItemUpdatedEventHandler(object sender, AccountGroup user)
        {
            ListUpdate();
        }

        private void cbMainGroup_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            //if(cbMainGroup.SelectedIndex != (cbMainGroup.SelectedIndex = cbMainGroup.Items.Count - 1))
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
            }
            ListUpdate();
        }
    }


}
