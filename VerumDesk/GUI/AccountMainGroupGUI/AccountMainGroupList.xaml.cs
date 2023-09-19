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
    /// Interaktionslogik für AccountMainGroupList.xaml
    /// </summary>
    public partial class AccountMainGroupList : Window
    {
        private BOCollection<AccountMainGroup, tAccountMainGroup> BOColl;
        private ObservableCollection<AccountMainGroup> listItems;

        public AccountMainGroupList()
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
            colSection = AccountSection.GetBOCollection().GetObservableCollection();
            cbSection.ItemsSource = colSection.Select(i => $"{i.TitleLocalSection}");
        }

        private void btnCreate_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new AccountMainGroupEdit();
            wnd.ItemUpdated += ItemCreatedEventHandler;
            wnd.Show();
        }

        private void btnOpen_Click(object sender, RoutedEventArgs e)
        {
            if (dgMain.SelectedItem != null)
            {
                var wnd = new AccountMainGroupEdit((AccountMainGroup)dgMain.SelectedItem);
                wnd.ItemUpdated += ItemUpdatedEventHandler;
                wnd.Show();
            }
        }

        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {

            AccountMainGroup item;

            if (dgMain.SelectedItem != null)
            {
                item = (AccountMainGroup)dgMain.SelectedItem;

                switch (item.Delete())
                {
                    case BOResult.AccountMainGroupCannotDelete:
                        System.Windows.MessageBox.Show("Die Kontohauptgruppe konnte nicht gelöscht werden.", "Kontohauptgruppe löschen", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                        break;

                    case BOResult.GeneralError:
                        System.Windows.MessageBox.Show("Unerwarteter Fehler beim Löschen der Kontohauptgruppe.", "Kontohauptgruppe löschen", MessageBoxButton.OK, MessageBoxImage.Error);
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
            BOColl = AccountMainGroup.GetBOCollection();

            listItems = new ObservableCollection<AccountMainGroup>();

            foreach (var BO in BOColl)
                listItems.Add(BO);

            //if (cbSection.SelectedItem != null)
            //{
            //    colMainGroup = new ObservableCollection<AccountMainGroup>(from item in colMainGroup where item.idAccountSection == colSection.ElementAt(cbSection.SelectedIndex).Id select item);
            //}
            if (cbSection.SelectedItem != null)
            {
                //listItems = (ObservableCollection<Account>)listItems.Union<Account>(new ObservableCollection<Account>(from item in listItems where item.idAccountMainGroup == colMainGroup.ElementAt(cbMainGroup.SelectedIndex).Id select item));
                listItems = new ObservableCollection<AccountMainGroup>(from item in listItems where item.Id == colMainGroup.ElementAt(cbSection.SelectedIndex).Id select item);
            }

            dgMain.ItemsSource = listItems.Distinct();
            dgMain.Items.SortDescriptions.Clear();
            // dgMain.Items.SortDescriptions.Add(new SortDescription("TitlePlan", ListSortDirection.Ascending));            
        }

        private void ItemCreatedEventHandler(object sender, AccountMainGroup item)
        {
            //Dispatcher.BeginInvoke(new Action(() => { ctrlProgress.Value = e.ItemsComplete; }));
            listItems.Add(item);
        }

        private void ItemUpdatedEventHandler(object sender, AccountMainGroup user)
        {
            ListUpdate();
        }

        private void cbSection_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            //if (cbSection.SelectedIndex != (cbSection.SelectedIndex = cbSection.Items.Count - 1))
            if (cbSection.SelectedIndex != -1)
            {
                colMainGroup = new ObservableCollection<AccountMainGroup>(from item in AccountMainGroup.GetBOCollection().GetObservableCollection() where item.idAccountSection == colSection.ElementAt(cbSection.SelectedIndex).Id select item);
                cbSection.ItemsSource = colMainGroup.Select(i => $"{i.TitleLocalMainGroup}");
                cbSection.SelectedItem = null;
            }
            ListUpdate();
        }
    }


}
