using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Forms;
using VerumBusinessObjects;
using VerumBusinessObjects.Framework;
using VerumBusinessObjects.Views;

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für PlanEdit.xaml
    /// </summary>
    public partial class PlanEdit : Window
    {
        Plan Plan;
        private GridViewColumnHeader listViewSortCol = null;
        private SortAdorner listViewSortAdorner = null;
        private System.Windows.Controls.ListView CurrentListView = null;

        public PlanEdit(Plan plan)
        {
            InitializeComponent();
            Plan = plan;
            this.DataContext = plan;
            this.Title = this.Title + " " + plan.TitlePlan;

            UpdateLists();
        }

        private void UpdateLists()
        {
            //lbElements.ItemsSource = Plan.GetPlanElements();
            UpdatePlanElementsList();
            lbParameters.ItemsSource = Plan.GetParameters();
            lbAllocationSchedule.ItemsSource = Plan.GetAllocationSchedules();
            lbInflation.ItemsSource = Plan.GetInflationRules();
            lbHRTariff.ItemsSource = Plan.GetHRTariffs();
            lbHRExpenses.ItemsSource = Plan.GetHRExpenseGroups();
            lbExchangeRates.ItemsSource = Plan.GetExchangeRates();

            UpdateCounts();
        }

        private void UpdatePlanElementsList()
        {
            lbElements.ItemsSource = new ObservableCollection<vPlanElementInstances>(from item in Plan.GetPlanElements()
                                                                           where (item.TitlePlanElement.ToUpper().Contains(tbFilter.Text.ToUpper())) || (item.ReferenceIDPlanElement != null && item.ReferenceIDPlanElement.ToUpper().Contains(tbFilter.Text.ToUpper())) || (item.TitlePlanGroup != null && item.TitlePlanGroup.ToUpper().Contains(tbFilter.Text.ToUpper())) || (item.CostCenterCode != null && item.CostCenterCode.ToUpper().Contains(tbFilter.Text.ToUpper())) || item.TypePlanElement.ToString().ToUpper().Contains(tbFilter.Text.ToUpper()) || (item.UntilDateYear != null && item.UntilDateMonth != null && item.UntilDateDay != null) && String.Format("{0}-{1}-{2}", item.UntilDateYear, item.UntilDateMonth, item.UntilDateDay).ToUpper().Contains(tbFilter.Text.ToUpper()) select item);
        }

        private void UpdateCounts()
        {
            tbCount.Text = String.Format("Anzahl: {0} - davon ohne Transaktionen: {1}", Plan.GetPlanElements().Count, GetElementsWithountTransaction().Count());
            tbCountZahlungsplan.Text = String.Format("Anzahl: {0}", Plan.GetAllocationSchedules().Count);
            tbCountHR.Text = String.Format("Anzahl: {0}", Plan.GetHRTariffs().Count);
        }

        private ObservableCollection<vPlanElementInstances> GetElementsWithountTransaction()
        {
            var planElements = new ObservableCollection<vPlanElementInstances>();
            var BOColl = BookTransaction.GetBOCollection(Plan.Id);

            var transactions = new ObservableCollection<BookTransaction>();

            foreach (var BO in BOColl)
                transactions.Add(BO);

            var transactionPlanElementIDs = new ObservableCollection<Guid?>(from item in transactions select item.idPlanElement).Distinct();

            foreach (var item in Plan.GetPlanElements())
            {
                if (transactionPlanElementIDs.Where(t => t == item.idPlanElement).FirstOrDefault() == null) planElements.Add(item);
            }
            return planElements;
        }

        private void OnSelectionChanged(Object sender, SelectionChangedEventArgs args)
        {
            if (args.Source is System.Windows.Controls.TabControl)
            {
                var tc = sender as System.Windows.Controls.TabControl;

                if (tc != null)
                {
                    TabItem item = (TabItem)tc.SelectedItem;

                    switch (item.Name)
                    {
                        case "Elements":
                            CurrentListView = lbElements;
                            lbElements.Items.SortDescriptions.Add(new SortDescription("TitlePlanElement", ListSortDirection.Ascending));
                            break;
                        case "Parameters":
                            CurrentListView = lbParameters;
                            lbParameters.Items.SortDescriptions.Add(new SortDescription("TitlePlanParameter", ListSortDirection.Ascending));
                            break;
                        case "Allocation":
                            CurrentListView = lbAllocationSchedule;
                            lbAllocationSchedule.Items.SortDescriptions.Add(new SortDescription("TitleAllocationSchedule", ListSortDirection.Ascending));
                            break;
                    }
                }
            }
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

        private void btnPlanToForecast_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new PlanToForecast(Plan);
            wnd.PlanForecastDone += PlanUpdatedEventHandler;
            wnd.Show();
        }

        private void btnPlanToBudget_Click(object sender, RoutedEventArgs e)
        {
            if (Plan.TypeStatus == (short)TypePlanStatusEnum.Baseline)
                System.Windows.MessageBox.Show("Der Plan ist als Budget festgeschrieben und kann nicht nochmals budgetiert werden.", "Budgetieren", MessageBoxButton.OK, MessageBoxImage.Exclamation);

            if (Plan.TypeStatus == (short)TypePlanStatusEnum.Historical)
                System.Windows.MessageBox.Show("Der Plan ist hat den Status Historisch und kann nicht rebudgetiert werden.", "Budgetieren", MessageBoxButton.OK, MessageBoxImage.Exclamation);

            if (Plan.TypeStatus == (short)TypePlanStatusEnum.Obsolete)
                System.Windows.MessageBox.Show("Der Plan ist hat den Status Gelöscht und kann nicht rebudgetiert werden.", "Budgetieren", MessageBoxButton.OK, MessageBoxImage.Exclamation);

            else
            {
                var wnd = new PlanToBudget(Plan);
                wnd.PlanDone += PlanUpdatedEventHandler;
                wnd.Show();
            }
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void btnPlanCopy_Click(object sender, RoutedEventArgs e)
        {
            int cnt = 0;
            var wnd = new PlanSelect(true);
            wnd.ShowDialog();

            if (!wnd.FlagCancel)
            {
                if (Plan.Id == wnd.SelectedPlan.Id)
                    System.Windows.MessageBox.Show("Sie können nur Elemente aus einem anderen Plan kopieren.", "Information");
                else
                {
                    var wnd2 = new PlanCopy(wnd.SelectedPlan);
                    wnd2.ShowDialog();

                    if (!wnd2.FlagCancel && wnd2.CurrentListView.SelectedItems.Count > 0)
                    {
                        foreach (vPlanElementInstances item in wnd2.CurrentListView.SelectedItems)
                        {
                            PlanElementInstance o = new PlanElementInstance(item.Id);
                            if (o.Copy(Plan) == BOResult.Success)
                                cnt++;
                        }

                        UpdateLists();
                        System.Windows.MessageBox.Show($"{cnt} Elemente kopiert.");
                    }
                }
            }
        }


        private void PlanUpdatedEventHandler(object sender, Plan plan)
        {
            this.Activate();
        }

        private void PlanItemUpdatedEventHandler(object sender, PlanElementInstance element)
        {
            UpdateLists();
        }

        private void btnElementEdit_Click(object sender, RoutedEventArgs e)
        {
            PlanItemEdit wnd;

            if (lbElements.SelectedItem != null)
            {

                vPlanElementInstances element = (vPlanElementInstances)lbElements.SelectedItem;
                var planInstance = new PlanElementInstance(element.Id);

                if (planInstance != null)
                {
                    var planItemChild = planInstance.PlanItemChild;

                    if (planItemChild == null)
                    {
                        var result = System.Windows.MessageBox.Show("Das Planelement ist fehlerhaft und sollte gelöscht werden. Wollen Sie das Element löschen?", "Planelement bearbeiten ...",
                                                MessageBoxButton.YesNo, MessageBoxImage.Warning);

                        if (result == MessageBoxResult.Yes)
                            planInstance.DeletePlanInstance(true);
                    }
                    else
                    {
                        wnd = new PlanItemEdit(planInstance);
                        wnd.ItemUpdated += PlanItemUpdatedEventHandler;
                        wnd.Show();
                    }
                }
            }
        }

        private void btnElementNew_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new PlanItemNew(Plan);
            wnd.ItemUpdated += PlanItemCreatedEventHandler;
            wnd.Show();
        }

        private void btnElementDelete_Click(object sender, RoutedEventArgs e)
        {
            if (lbElements.SelectedIndex == -1)
                return;

            var result = System.Windows.MessageBox.Show("Wollen Sie das ausgewählte Planelement im geöffneten Plan löschen?", "Planelement löschen", MessageBoxButton.YesNo, MessageBoxImage.Question);

            if (result == MessageBoxResult.Yes)
            {
                var item = (vPlanElementInstances)lbElements.SelectedItem;
                lbElements.SelectedItem = null;

                var instance = new PlanElementInstance(item.Id);

                if (instance.DeletePlanInstance(true) != BOResult.Success)
                    System.Windows.MessageBox.Show("Unerwarteter Fehler beim Löschen des Planelementes", "Planelement löschen", MessageBoxButton.OK, MessageBoxImage.Error);

                UpdateLists();
            }
        }

        private void PlanItemCreatedEventHandler(object sender, PlanElementInstance instance)
        {
            var items = (ObservableCollection<vPlanElementInstances>)lbElements.ItemsSource;

            if (items.Count > 0)
            {
                lbElements.SelectedItem = items.Select(b => b.Id == instance.Id);
            }
        }

        private void btnParameterEdit_Click(object sender, RoutedEventArgs e)
        {
            if (lbParameters.SelectedItem != null)
            {
                var wnd = new ParameterEdit(new PlanParameter(((tPlanParameter)lbParameters.SelectedItem).Id));
                wnd.ItemUpdated += ParameterUpdatedEventHandler;
                wnd.Show();
            }
        }

        private void btnParameterCreate_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new ParameterEdit(Plan.Id);
            wnd.ItemUpdated += ParameterUpdatedEventHandler;
            wnd.Show();
        }

        private void ParameterUpdatedEventHandler(object sender, PlanParameter item)
        {
            lbParameters.ItemsSource = Plan.GetParameters();
            lbParameters.SelectedItem = item;
        }

        private void btnHRTariffEdit_Click(object sender, RoutedEventArgs e)
        {
            if (lbHRTariff.SelectedItem != null)
            {
                var wnd = new HRTariffEdit(new PlanHRTariff(((tPlanHRTariff)lbHRTariff.SelectedItem).Id));
                wnd.ItemUpdated += PlanHRTariffUpdatedEventHandler;
                wnd.Show();
            }
        }

        private void btnHRTariffNew_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new HRTariffEdit(Plan, "", true);
            wnd.ItemUpdated += PlanHRTariffUpdatedEventHandler;
            wnd.Show();
        }

        private void btnHRTariffDelete_Click(object sender, RoutedEventArgs e)
        {
            if (lbHRTariff.SelectedIndex == -1)
                return;

            var result = System.Windows.MessageBox.Show("Wollen Sie den ausgewählten Tarif im geöffneten Plan löschen?", "Tarif löschen", MessageBoxButton.YesNo, MessageBoxImage.Question);

            if (result == MessageBoxResult.Yes)
            {
                var item = new PlanHRTariff(((tPlanHRTariff)lbHRTariff.SelectedItem).Id);
                lbHRTariff.SelectedItem = null;

                if (item.Delete() != BOResult.Success)
                    System.Windows.MessageBox.Show("Unerwarteter Fehler beim Löschen des Tarifs", "Tarif löschen", MessageBoxButton.OK, MessageBoxImage.Error);

                UpdateLists();
            }
        }

        private void PlanHRTariffUpdatedEventHandler(object sender, PlanHRTariff item)
        {
            lbHRTariff.ItemsSource = Plan.GetHRTariffs();
            lbHRTariff.SelectedItem = item;
        }

        private void btnPlanUpdate_Click(object sender, RoutedEventArgs e)
        {
            DialogResult dialogResult = System.Windows.Forms.MessageBox.Show("Aktualisieren aller Elemente erzwingen?", "Plan aktualisieren", MessageBoxButtons.YesNoCancel);
            if (!(dialogResult == System.Windows.Forms.DialogResult.Cancel))
            {
                try
                {
                    if (Plan != null)
                    {
                        Plan.CommitChanges();
                        HttpClient client = new HttpClient();
                        string force;
                        if (dialogResult == System.Windows.Forms.DialogResult.Yes) force = "true";
                        else force = "false";
                        string data = "?IdPlan=" + Plan.IdString + "&force=" + force;
                        //var values = new Dictionary<string, string>
                        //{
                        //    { "IdPlan", Plan.IdString },
                        //    { "force", force }
                        //};
                        //var content = new FormUrlEncodedContent(values);

                        var response = client.PostAsync("https://dotnetappsqldb20220517165205.azurewebsites.net/bookplan" + data, null);
                        //var responseString = response.Result.ToString();
                        System.Windows.MessageBox.Show("Buchungsprozess gestartet.", "Plan buchen", MessageBoxButton.OK, MessageBoxImage.Information);
                    }
                }
                catch (Exception)
                {
                    System.Windows.MessageBox.Show("Unerwarteter Fehler beim Anlegen der Buchungen.", "Plan buchen", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }

        //private void btnPlanUpdate_Click(object sender, RoutedEventArgs e)
        //{
        //    DialogResult dialogResult = System.Windows.Forms.MessageBox.Show("Aktualisieren aller Elemente erzwingen?", "Plan aktualisieren", MessageBoxButtons.YesNoCancel);
        //    if (!(dialogResult == System.Windows.Forms.DialogResult.Cancel))
        //    {
        //        try
        //        {
        //            if (Plan != null)
        //            {
        //                Plan.CommitChanges();

        //                var wnd = new PlanUpdateInProgress();
        //                wnd.Show();

        //                if (dialogResult == System.Windows.Forms.DialogResult.Yes) Plan.ImplementPlan(true);
        //                else Plan.ImplementPlan(false);
        //                wnd.Close();
        //                System.Windows.MessageBox.Show("Buchungen anlegen erfolgreich abgeschlossen.", "Plan buchen", MessageBoxButton.OK, MessageBoxImage.Information);
        //            }
        //        }
        //        catch (Exception)
        //        {
        //            System.Windows.MessageBox.Show("Unerwarteter Fehler beim Anlegen der Buchungen.", "Plan buchen", MessageBoxButton.OK, MessageBoxImage.Error);
        //        }
        //    }
        //}

        private void tbFilter_TextChanged(object sender, TextChangedEventArgs e)
        {
            UpdatePlanElementsList(); 
        }

        private void btnFilterWithoutTransaction_Click(object sender, RoutedEventArgs e)
        {
            lbElements.ItemsSource = lbElements.ItemsSource = GetElementsWithountTransaction();
        }
    }
}
