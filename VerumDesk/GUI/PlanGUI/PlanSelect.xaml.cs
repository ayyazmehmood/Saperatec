namespace VerumDesk.GUI
{
    using System;
    using System.Collections.ObjectModel;
    using System.ComponentModel;
    using System.Windows;
    using System.Windows.Controls;
    using System.Windows.Data;
    using System.Windows.Documents;
    using System.Windows.Media;
    using VerumBusinessObjects;
    using VerumBusinessObjects.Framework;

    /// <summary>
    /// Interaktionslogik für PlanSelect.xaml
    /// </summary>
    public partial class PlanSelect : Window
    {
		public bool FlagCancel = false;
		public Plan SelectedPlan = null;

		private BOCollection<Plan, tPlan> plans;
		private ObservableCollection<User> users = new ObservableCollection<User>();
		private GridViewColumnHeader listViewSortCol = null;
		private SortAdorner listViewSortAdorner = null;
		private ObservableCollection<Plan> listItems;
		private bool modeSelect;

		public PlanSelect(bool flagSelect = false)
        {
			modeSelect = flagSelect;
            InitializeComponent();

			if (flagSelect)
            {
				btnOpenPlan.Visibility = Visibility.Collapsed;
				btnCreatePlan.Visibility = Visibility.Collapsed;
				btnDeletePlan.Visibility = Visibility.Collapsed;
				btnImportPlan.Visibility = Visibility.Collapsed;
				btnPlanToForecast.Visibility = Visibility.Collapsed;
				btnPlanToBudget.Visibility = Visibility.Collapsed;
				btnClose.Visibility = Visibility.Collapsed;
			}
			else
            {
				btnCancel.Visibility = Visibility.Collapsed;
				btnSelect.Visibility = Visibility.Collapsed;
            }

			PlanListUpdate();
		}

		//private bool UserFilter(object item)
		//{
		//	if (String.IsNullOrEmpty(txtFilter.Text))
		//		return true;
		//	else
		//		return ((item as User).Name.IndexOf(txtFilter.Text, StringComparison.OrdinalIgnoreCase) >= 0);
		//}

		//private void txtFilter_TextChanged(object sender, System.Windows.Controls.TextChangedEventArgs e)
		//{
		//	CollectionViewSource.GetDefaultView(lbPlans.ItemsSource).Refresh();
		//}

		private void lvUsersColumnHeader_Click(object sender, RoutedEventArgs e)
		{
			GridViewColumnHeader column = (sender as GridViewColumnHeader);
			string sortBy = column.Tag.ToString();

			if (listViewSortCol != null)
			{
				AdornerLayer.GetAdornerLayer(listViewSortCol).Remove(listViewSortAdorner);
				lbPlans.Items.SortDescriptions.Clear();
			}

			ListSortDirection newDir = ListSortDirection.Ascending;
			if (listViewSortCol == column && listViewSortAdorner.Direction == newDir)
				newDir = ListSortDirection.Descending;

			listViewSortCol = column;
			listViewSortAdorner = new SortAdorner(listViewSortCol, newDir);
			AdornerLayer.GetAdornerLayer(listViewSortCol).Add(listViewSortAdorner);
			lbPlans.Items.SortDescriptions.Add(new SortDescription(sortBy, newDir));
		}

		private void btnCreatePlan_Click(object sender, RoutedEventArgs e)
		{
			var wnd = new PlanNew();
			wnd.PlanCreated += PlanCreatedEventHandler;
			wnd.Show();
		}

		private void btnOpenPlan_Click(object sender, RoutedEventArgs e)
		{
			if (lbPlans.SelectedItem != null)
			{
				if (modeSelect)
				{
					SelectedPlan = (Plan)lbPlans.SelectedItem;
					Close();
				}
				else
				{
					var wnd = new PlanEdit((Plan)lbPlans.SelectedItem);
					wnd.Show();
				}
			}
		}

		private void btnDeletePlan_Click(object sender, RoutedEventArgs e)
		{
			Plan plan;

			if (lbPlans.SelectedItem != null)
            {
				plan = (Plan)lbPlans.SelectedItem;

				switch (plan.Delete())
                {
					case BOResult.PlanAppliedCannotDelete:
						System.Windows.MessageBox.Show("Der Plan ist als Budget festgeschrieben und kann daher nicht mehr gelöscht werden.", "Plan löschen", MessageBoxButton.OK, MessageBoxImage.Exclamation);
						break;

					case BOResult.GeneralError:
						System.Windows.MessageBox.Show("Unerwarteter Fehler beim Löschen des Planes.", "Plan löschen", MessageBoxButton.OK, MessageBoxImage.Error);
						break;

                    case BOResult.Success:
						listItems.Remove(plan);
						PlanListUpdate();
						break;
				}
			}
		}

		private void PlanCreatedEventHandler(object sender, Plan plan)
		{
			//Dispatcher.BeginInvoke(new Action(() => { ctrlProgress.Value = e.ItemsComplete; }));
			listItems.Add(plan);
		}

		private void PlanUpdatedEventHandler(object sender, Plan plan)
		{
			PlanListUpdate();
		}

		private void btnImportPlan_Click(object sender, RoutedEventArgs e)
        {
			if (lbPlans.SelectedItem != null)
			{
				var plan = (Plan)lbPlans.SelectedItem;
				var wnd = new PlanImport();
				wnd.txtPlanGuid.Text = plan.Id.ToString();
				wnd.Show();
			}
        }

        private void btnPlanToForecast_Click(object sender, RoutedEventArgs e)
        {
			if (lbPlans.SelectedItem != null)
			{
				var plan = (Plan)lbPlans.SelectedItem;

				var wnd = new PlanToForecast(plan);
				wnd.PlanForecastDone += PlanUpdatedEventHandler;
				wnd.Show();
			}
		}

		private void PlanListUpdate()
		{
			plans = Plan.GetBOCollection();

			listItems = new ObservableCollection<Plan>();

			foreach (var plan in plans)
				listItems.Add(plan);
			lbPlans.ItemsSource = listItems;

			lbPlans.Items.SortDescriptions.Clear();
			lbPlans.Items.SortDescriptions.Add(new SortDescription("TitlePlan", ListSortDirection.Ascending));

		}

        private void btnPlanToBudget_Click(object sender, RoutedEventArgs e)
        {
			if (lbPlans.SelectedItem != null)
			{
				var plan = (Plan)lbPlans.SelectedItem;

				if (plan.TypeStatus == (short)TypePlanStatusEnum.Baseline)
					System.Windows.MessageBox.Show("Der Plan ist als Budget festgeschrieben und kann nicht nochmals budgetiert werden.", "Budgetieren", MessageBoxButton.OK, MessageBoxImage.Exclamation);

				if (plan.TypeStatus == (short)TypePlanStatusEnum.Historical)
					System.Windows.MessageBox.Show("Der Plan ist hat den Status Historisch und kann nicht rebudgetiert werden.", "Budgetieren", MessageBoxButton.OK, MessageBoxImage.Exclamation);

				if (plan.TypeStatus == (short)TypePlanStatusEnum.Obsolete)
					System.Windows.MessageBox.Show("Der Plan ist hat den Status Gelöscht und kann nicht rebudgetiert werden.", "Budgetieren", MessageBoxButton.OK, MessageBoxImage.Exclamation);

				else
				{
					var wnd = new PlanToBudget(plan);
					wnd.PlanDone += PlanUpdatedEventHandler;
					wnd.Show();
				}
			}
		}

		private void btnClose_Click(object sender, RoutedEventArgs e)
        {
			FlagCancel = true;
			this.Close();
        }

    }
}

