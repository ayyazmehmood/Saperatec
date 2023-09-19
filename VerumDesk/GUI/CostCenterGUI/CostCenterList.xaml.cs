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
    /// Interaktionslogik für CostCenterList.xaml
    /// </summary>
    public partial class CostCenterList : Window
    {
        private BOCollection<CostCenter, tCostCenter> BOColl;
        private ObservableCollection<CostCenter> listItems;

        public CostCenterList()
        {
            InitializeComponent();
            ListUpdate();
        }

		private void btnCreate_Click(object sender, RoutedEventArgs e)
		{
			var wnd = new CostCenterEdit();
			wnd.ItemUpdated += ItemCreatedEventHandler;
			wnd.Show();
		}

		private void btnOpen_Click(object sender, RoutedEventArgs e)
		{
			if (dgMain.SelectedItem != null)
			{
				var wnd = new CostCenterEdit((CostCenter)dgMain.SelectedItem);
				wnd.ItemUpdated += ItemUpdatedEventHandler;
				wnd.Show();
			}
		}

		private void btnDelete_Click(object sender, RoutedEventArgs e)
		{
			CostCenter item;

			if (dgMain.SelectedItem != null)
			{
				item = (CostCenter)dgMain.SelectedItem;

				switch (item.Delete())
                {
                    case BOResult.CostCenterCannotDelete:
                        System.Windows.MessageBox.Show("Die Kostenstelle ist bereits bebucht und kann nicht mehr gelöscht werden.", "Kostenstelle löschen", MessageBoxButton.OK, MessageBoxImage.Exclamation);
                        break;

                    case BOResult.GeneralError:
                        System.Windows.MessageBox.Show("Unerwarteter Fehler beim Löschen der Kostenstelle.", "Kostenstelle löschen", MessageBoxButton.OK, MessageBoxImage.Error);
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
            BOColl = CostCenter.GetBOCollection();

            listItems = new ObservableCollection<CostCenter>();

            foreach (var BO in BOColl)
                listItems.Add(BO);

            dgMain.ItemsSource = listItems;

            dgMain.Items.SortDescriptions.Clear();
            // dgMain.Items.SortDescriptions.Add(new SortDescription("TitlePlan", ListSortDirection.Ascending));
        }

		private void ItemCreatedEventHandler(object sender, CostCenter item)
		{
			//Dispatcher.BeginInvoke(new Action(() => { ctrlProgress.Value = e.ItemsComplete; }));
			listItems.Add(item);
		}

		private void ItemUpdatedEventHandler(object sender, CostCenter user)
		{
			ListUpdate();
		}

	}
}
