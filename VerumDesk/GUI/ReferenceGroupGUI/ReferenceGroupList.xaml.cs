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
    /// Interaktionslogik für ReferenceGroupList.xaml
    /// </summary>
    public partial class ReferenceGroupList : Window
    {
        private BOCollection<ReferenceGroup, tReferenceGroup> BOColl;
        private ObservableCollection<ReferenceGroup> listItems;

        public ReferenceGroupList()
        {
            InitializeComponent();
            ListUpdate();
        }

        private void btnCreate_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new ReferenceGroupEdit();
            wnd.ItemUpdated += ItemCreatedEventHandler;
            wnd.Show();
        }

        private void btnOpen_Click(object sender, RoutedEventArgs e)
        {
            if (dgMain.SelectedItem != null)
            {
                var wnd = new ReferenceGroupEdit((ReferenceGroup)dgMain.SelectedItem);
                wnd.ItemUpdated += ItemUpdatedEventHandler;
                wnd.Show();
            }
        }

        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {

            ReferenceGroup item;

            if (dgMain.SelectedItem != null)
            {
                item = (ReferenceGroup)dgMain.SelectedItem;

                switch (item.Delete())
                {
                    case BOResult.ReferenceGroupCannotDelete:
                        System.Windows.MessageBox.Show("Die Buchungsschlüsselgruppe konnte nicht gelöscht werden.", "Buchungsschlüsselgruppe löschen", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                        break;

                    case BOResult.GeneralError:
                        System.Windows.MessageBox.Show("Unerwarteter Fehler beim Löschen der Buchungsschlüsselgruppe.", "Buchungsschlüsselgruppe löschen", MessageBoxButton.OK, MessageBoxImage.Error);
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

            BOColl = ReferenceGroup.GetBOCollection();

            listItems = new ObservableCollection<ReferenceGroup>();

            foreach (var BO in BOColl)
                listItems.Add(BO);

            dgMain.ItemsSource = listItems;

            dgMain.Items.SortDescriptions.Clear();
            // dgMain.Items.SortDescriptions.Add(new SortDescription("TitlePlan", ListSortDirection.Ascending));            
        }

        private void ItemCreatedEventHandler(object sender, ReferenceGroup item)
        {
            //Dispatcher.BeginInvoke(new Action(() => { ctrlProgress.Value = e.ItemsComplete; }));
            listItems.Add(item);
        }

        private void ItemUpdatedEventHandler(object sender, ReferenceGroup user)
        {
            ListUpdate();
        }
    }
}
