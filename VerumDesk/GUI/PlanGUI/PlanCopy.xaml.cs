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
using VerumBusinessObjects.Views;
using System.ComponentModel;

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für PlanCopy.xaml
    /// </summary>
    public partial class PlanCopy : Window
    {
        public ListView CurrentListView = null;
        public bool FlagCancel = false;
        private ObservableCollection<vPlanElementInstances> elements;
        private GridViewColumnHeader listViewSortCol = null;
        private SortAdorner listViewSortAdorner = null;

        public PlanCopy(Plan plan)
        {
            elements = plan.GetPlanElements();
            InitializeComponent();
            CurrentListView = lbElements;
            CurrentListView.ItemsSource = elements;
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            FlagCancel = true;
            this.Close();
        }

        private void btnContinue_Click(object sender, RoutedEventArgs e)
        {

            FlagCancel = false;
            this.Close();
        }

        private void OnUncheckItem(object sender, RoutedEventArgs e)
        {
            selectAll.IsChecked = false;
        }

        private void OnSelectAllChanged(object sender, RoutedEventArgs e)
        {
            if (selectAll.IsChecked.HasValue && selectAll.IsChecked.Value)
                CurrentListView.SelectAll();
            else
                CurrentListView.UnselectAll();
        }

        private void lvListColumnHeader_Click(object sender, RoutedEventArgs e)
        {
            GridViewColumnHeader column = (sender as GridViewColumnHeader);
            string sortBy = column.Tag.ToString();
            if (listViewSortCol != null)
            {
                AdornerLayer.GetAdornerLayer(listViewSortCol).Remove(listViewSortAdorner);
                CurrentListView.Items.SortDescriptions.Clear();
            }

            ListSortDirection newDir = ListSortDirection.Ascending;
            if (listViewSortCol == column && listViewSortAdorner.Direction == newDir)
                newDir = ListSortDirection.Descending;

            listViewSortCol = column;
            listViewSortAdorner = new SortAdorner(listViewSortCol, newDir);
            AdornerLayer.GetAdornerLayer(listViewSortCol).Add(listViewSortAdorner);
            CurrentListView.Items.SortDescriptions.Add(new SortDescription(sortBy, newDir));
        }

        private void ListViewItem_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {

        }

    }
}