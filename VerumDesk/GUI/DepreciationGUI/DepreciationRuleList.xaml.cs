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
    /// Interaktionslogik für DepreciationRuleList.xaml
    /// </summary>
    public partial class DepreciationRuleList : Window
    {
        private BOCollection<DepreciationRule, tDepreciationRule> BOColl;
        private ObservableCollection<DepreciationRule> listItems;

        public DepreciationRuleList()
        {
            InitializeComponent();
            InitTabElement();
            ListUpdate();
        }

        ObservableCollection<ReferenceGroup> colReferenceGroup;
        private void InitTabElement()
        {
            // init reference group combo box
            colReferenceGroup = ReferenceGroup.GetBOCollection().GetObservableCollection();
        }

        private void btnCreate_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new DepreciationRuleEdit();
            wnd.ItemUpdated += ItemCreatedEventHandler;
            wnd.Show();
        }

        private void btnOpen_Click(object sender, RoutedEventArgs e)
        {
            if (dgMain.SelectedItem != null)
            {
                var wnd = new DepreciationRuleEdit((DepreciationRule)dgMain.SelectedItem);
                wnd.ItemUpdated += ItemUpdatedEventHandler;
                wnd.Show();
            }
        }

        private void btnDelete_Click(object sender, RoutedEventArgs e)
        {

            //DepreciationRule item;

            //if (dgMain.SelectedItem != null)
            //{
            //    item = (DepreciationRule)dgMain.SelectedItem;

            //    switch (item.Delete())
            //    {
            //        case BOResult.DepreciationRuleCannotDelete:
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

            BOColl = DepreciationRule.GetBOCollection();

            listItems = new ObservableCollection<DepreciationRule>();

            foreach (var BO in BOColl)
                listItems.Add(BO);

            dgMain.ItemsSource = listItems;
        }

        private void ItemCreatedEventHandler(object sender, DepreciationRule item)
        {
            //Dispatcher.BeginInvoke(new Action(() => { ctrlProgress.Value = e.ItemsComplete; }));
            listItems.Add(item);
        }

        private void ItemUpdatedEventHandler(object sender, DepreciationRule user)
        {
            ListUpdate();
        }
    }
}
