namespace VerumDesk.GUI
{
    using System;
    using System.Linq;
    using System.Windows;
    using System.Windows.Controls;
    using System.Windows.Input;
    using VerumBusinessObjects.Views;
    using VerumBusinessObjects;
    using System.Collections.ObjectModel;
    using VerumBusinessObjects.Framework;
    using VerumDesk.GUI.PlanGUI;
    using System.Data;
    using VerumDesk.Controller;
    /// <summary>
    /// Interaktionslogik für PlanItemEdit.xaml
    /// </summary>
    public partial class PlanItemEdit : Window
    {
        private PlanElement planElement;
        private IPlanItem planItemChild;
        private PlanElementContract planContract;
        private PlanElementBooking planBooking;
        private PlanElementHR planHR;
        private PlanElementInstance elementInstance;

        public PlanItemEdit(PlanElementInstance elementInstance)
        {
            // obtain data reference
            planElement = new PlanElement(elementInstance.idPlanElement);
            planItemChild = elementInstance.PlanItemChild;
            this.elementInstance = elementInstance;

            if (planItemChild != null)
            {
                switch (planItemChild.ItemType)
                {
                    case (TypePlanElementEnum.BookingRule):
                        planBooking = (PlanElementBooking)planItemChild;
                        break;

                    case (TypePlanElementEnum.Purchase):
                        planContract = (PlanElementContract)planItemChild;
                        break;

                    case (TypePlanElementEnum.Sale):
                        planContract = (PlanElementContract)planItemChild;
                        break;

                    case (TypePlanElementEnum.Personnel):
                        planHR = (PlanElementHR)planItemChild;
                        break;
                }

                // Init UI
                InitializeComponent();
                InitTabAdvance();
                InitTabContract();
                InitTabBooking();
                InitTabHR();
                InitTabDepreciation();
                InitTabElement();
                InitTabExtended();
                InitTabInstance();
                InitTabSchedule();
                InitTabTransactions();

                this.Title = this.Title + " " + planElement.TitlePlanElement;

            }
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (elementInstance != null && (ReferenceCode.CheckCodeExists(tbReferenceID.Text) || tbReferenceID.Text == ""))
                {
                    planElement.CommitChanges();
                    elementInstance.CommitChanges();

                    var wnd = new PlanUpdateInProgress();
                    wnd.Show();
                    elementInstance.ImplementPlanElementInstance();
                    InitTabTransactions();
                    wnd.Close();
                    OnRaiseItemUpdated();
                    this.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Unerwarteter Fehler beim Anlegen der Buchungen: " + ex.Message, "Planelement buchen", MessageBoxButton.OK, MessageBoxImage.Error);
                this.Close();
            }
        }

        private void btnUpdate_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new PlanUpdateInProgress();
            try
            {
                if (elementInstance != null && (ReferenceCode.CheckCodeExists(tbReferenceID.Text) || tbReferenceID.Text == ""))
                {
                    planElement.CommitChanges();
                    elementInstance.CommitChanges();

                    wnd.Show();
                    elementInstance.ImplementPlanElementInstance(true);
                    InitTabTransactions();
                    wnd.Close();
                    OnRaiseItemUpdated();
                    MessageBox.Show("Buchungen anlegen erfolgreich abgeschlossen.", "Planelement buchen", MessageBoxButton.OK, MessageBoxImage.Information);
                }
            }
            catch (Exception ex)
            {
                wnd.Close();
                MessageBox.Show("Unerwarteter Fehler beim Anlegen der Buchungen: "+ex.Message, "Planelement buchen", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        public event EventHandler<PlanElementInstance> ItemUpdated;
        protected virtual void OnRaiseItemUpdated()
        {
            // Raise event if event handler is set (i.e. not null)
            ItemUpdated?.Invoke(this, elementInstance);
        }

        // Tab Control

        private void TabControl_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var tc = sender as TabControl;

            if (tc != null)
            {
                TabItem item = (TabItem)tc.SelectedItem;

                switch (item.Name)
                {
                    case "tiElement":
                        break;
                    case "tiInstance":
                        break;
                }
            }
        }

        /// <summary>
        /// Tab Element
        /// </summary>

        ObservableCollection<PlanGroup> colPlanGroups;
        ObservableCollection<CostCenter> colCostCenters;

        private void InitTabElement()
        {
            tiElement.DataContext = planElement;
            tiElement.Visibility = Visibility.Visible;
            tiElement.IsSelected = true;

            // init plan group combo box
            colPlanGroups = PlanGroup.GetBOCollection().GetObservableCollection();
            cbPlanGroup.ItemsSource = colPlanGroups.Select(i => i.TitlePlanGroup);
            cbPlanGroup.SelectedIndex = colPlanGroups.IndexOf(colPlanGroups.FirstOrDefault(b => b.Id == planElement.idPlanGroup));

            // init cost center combo box
            colCostCenters = CostCenter.GetBOCollection().GetObservableCollection();
            cbCostCenter.ItemsSource = colCostCenters.Select(i => $"{i.CostCenterCode} {i.TitleCostCenter}");
            cbCostCenter.SelectedIndex = colCostCenters.IndexOf(colCostCenters.FirstOrDefault(b => b.Id == planElement.idCostCenterPlanElement));
        }

        private void cbPlanGroup_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if(cbPlanGroup.SelectedIndex >= 0)
            {
                planElement.idPlanGroup = colPlanGroups.ElementAt(cbPlanGroup.SelectedIndex).Id;
                OnRaiseItemUpdated();
            }            
        }

        private void cbCostCenter_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            planElement.idCostCenterPlanElement = colCostCenters.ElementAt(cbCostCenter.SelectedIndex).Id;
            OnRaiseItemUpdated();
        }

        private void btnReferenceIDSelect_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new ReferenceCodeList(this);
            //wnd.ItemUpdated += ItemCreatedEventHandler;
            wnd.ShowDialog();
        }





        /// <summary>
        /// Tab Instance 
        /// </summary>

        private void InitTabInstance()
        {
            // assign data context
            tiInstance.DataContext = elementInstance;
            tiInstance.Visibility = Visibility.Visible;

            // init trigger date combo box
            if (elementInstance.idParTriggerDueDate == null)
                chkTriggerEnable.IsChecked = false;
            else
                chkTriggerEnable.IsChecked = true;

            DueTriggerUpdateCombo();
        }

        private void DueTriggerUpdateCombo()
        {
            if ((bool)chkTriggerEnable.IsChecked)
            {
                // init trigger date combo box
                var parTrigger = PlanParameter.GetBOCollection(elementInstance.idPlan, TypePlanParameterEnum.TriggerDate).GetObservableCollection();
                cbTriggerDate.ItemsSource = parTrigger;
                cbTriggerDate.IsEnabled = true;
                btnNewTriggerDate.IsEnabled = true;

                if (elementInstance.idParTriggerDueDate == null)
                    btnEditTriggerDate.IsEnabled = false;
                else
                {
                    cbTriggerDate.SelectedItem = parTrigger.FirstOrDefault(b => b.Id == elementInstance.idParTriggerDueDate);

                    if (cbTriggerDate.SelectedItem == null)
                        btnEditTriggerDate.IsEnabled = false;
                    else
                        btnEditTriggerDate.IsEnabled = true;
                }
            }
            else
            {
                cbTriggerDate.IsEnabled = false;
                btnNewTriggerDate.IsEnabled = false;
                btnEditTriggerDate.IsEnabled = false;
            }
        }

        private void cbTriggerDate_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbTriggerDate.SelectedItem == null)
                btnEditTriggerDate.IsEnabled = false;
            else
            {
                btnEditTriggerDate.IsEnabled = true;
                elementInstance.idParTriggerDueDate = ((PlanParameter)cbTriggerDate.SelectedItem).Id;
            }
        }

        private void chkTriggerEnable_Checked(object sender, RoutedEventArgs e)
        {
            cbTriggerDate.IsEnabled = true;
            btnNewTriggerDate.IsEnabled = true;

            if (cbTriggerDate.SelectedItem != null)
                btnEditTriggerDate.IsEnabled = true;
        }

        private void chkTriggerEnable_Unchecked(object sender, RoutedEventArgs e)
        {
            cbTriggerDate.SelectedItem = null;
            cbTriggerDate.IsEnabled = false;
            btnNewTriggerDate.IsEnabled = false;
            btnEditTriggerDate.IsEnabled = false;
        }

        private void btnNewTriggerDate_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new ParameterEdit(TypePlanParameterEnum.TriggerDate, elementInstance.idPlan);
            wnd.ItemUpdated += DueTriggerCreatedEventHandler;
            wnd.Show();
        }

        private void btnEditTriggerDate_Click(object sender, RoutedEventArgs e)
        {
            if (cbTriggerDate.SelectedItem != null)
            {
                var wnd = new ParameterEdit((PlanParameter)cbTriggerDate.SelectedItem);
                wnd.ItemUpdated += DueTriggerUpdatedEventHandler;
                wnd.Show();
            }
        }

        private void DueTriggerCreatedEventHandler(object sender, PlanParameter item)
        {
            elementInstance.idParTriggerDueDate = item.Id;
            DueTriggerUpdateCombo();
            OnRaiseItemUpdated();
        }

        private void DueTriggerUpdatedEventHandler(object sender, PlanParameter item)
        {
            DueTriggerUpdateCombo();
            OnRaiseItemUpdated();
        }

        /// <summary>
        /// Tab Contract
        /// </summary>

        ObservableCollection<TypeSelector> colRepeatTypes;
        ObservableCollection<VATRule> colVATRules;

        private void InitTabContract()
        {
            if (planContract != null)
            {
                tiContract.DataContext = planContract;
                tiContract.Visibility = Visibility.Visible;
                tbAccountMainCode.Value = planContract.AccountMainParent.AccountCode;

                switch (planItemChild.ItemType)
                {
                    case (TypePlanElementEnum.Purchase):
                        rbContractPurchase.IsChecked = true;
                        break;

                    case (TypePlanElementEnum.Sale):
                        rbContractSales.IsChecked = true;
                        break;
                }

                // Init Combo Box Repeat
                {
                    colRepeatTypes = new ObservableCollection<TypeSelector>();
                    colRepeatTypes.Add(new TypeSelector((short)TypeRepeatEnum.NoRepeat, "Ohne"));
                    colRepeatTypes.Add(new TypeSelector((short)TypeRepeatEnum.Annually, "Jährlich"));
                    colRepeatTypes.Add(new TypeSelector((short)TypeRepeatEnum.Monthly, "Monatlich"));
                    colRepeatTypes.Add(new TypeSelector((short)TypeRepeatEnum.Quarterly, "Quartalsweise"));
                    colRepeatTypes.Add(new TypeSelector((short)TypeRepeatEnum.Schedule, "Zahlungsplan"));
                    cbRepeat.ItemsSource = colRepeatTypes.Select(b => b.Title);
                    cbRepeat.SelectedIndex = colRepeatTypes.IndexOf(colRepeatTypes.FirstOrDefault(b => b.TypeCode == planContract.TypeRepeat));
                }

                // Init Combo VAT Rules
                {
                    colVATRules = VATRule.GetBOCollection().GetObservableCollection();
                    cbVATRule.ItemsSource = colVATRules.Select(i => $"{i.VATRuleCode} {i.TitleVATRule}");

                    if (planContract.idVATRule == Guid.Empty)
                    {
                        chkVATRule.IsChecked = false;
                        cbVATRule.IsEnabled = false;
                    }
                    else
                    {
                        chkVATRule.IsChecked = true;
                        cbVATRule.IsEnabled = true;
                        cbVATRule.SelectedIndex = colVATRules.IndexOf(colVATRules.FirstOrDefault(b => b.Id == planContract.idVATRule));
                    }
                }

                // Init Combo Inflation Rule #####TO DO#####
                {
                    chkInflationEnable.IsChecked = false;
                    cbInflation.IsEnabled = false;
                    dpPriceDate.IsEnabled = false;
                }
            }
            else
                tiContract.Visibility = Visibility.Collapsed;
        }

        private void btnAccountMainSelect_Click(object sender, RoutedEventArgs e)
        {

        }

        private void tbAccountMainCode_ValueChanged(object sender, RoutedPropertyChangedEventArgs<object> e)
        {
            var account = new Account();

            if (e.NewValue != null && account.SelectViaKey((int)e.NewValue))
            {
                    lbAccountMainTitle.Content = account.TitleLocalAccount;
                planContract.idAccountMain = account.Id;
            }
            else
                lbAccountMainTitle.Content = "n/a";
        }

        private void chkVATRule_Checked(object sender, RoutedEventArgs e)
        {
            cbVATRule.IsEnabled = true;
        }

        private void chkVATRule_Unchecked(object sender, RoutedEventArgs e)
        {
            cbVATRule.IsEnabled = false;
            planContract.idVATRule = null;
            cbVATRule.SelectedItem = null;
        }

        private void cbVATRule_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbVATRule.SelectedItem == null)
                planContract.idVATRule = null;
            else
                planContract.idVATRule = colVATRules.ElementAt(cbVATRule.SelectedIndex).Id;
        }

        private void cbRepeat_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            planContract.TypeRepeat = colRepeatTypes.ElementAt(cbRepeat.SelectedIndex).TypeCode;
        }

        /// <summary>
        /// Tab Booking
        /// </summary>

        private void InitTabBooking()
        {
            if (planBooking != null)
            {
                tiBooking.DataContext = planBooking;
                tiBooking.Visibility = Visibility.Visible;
                tbAccountDebitCode.Value = planBooking.AccountDebitParent.AccountCode;
                tbAccountCreditCode.Value = planBooking.AccountCreditParent.AccountCode;

                // Init Combo Box Repeat
                {
                    colRepeatTypes = new ObservableCollection<TypeSelector>();
                    colRepeatTypes.Add(new TypeSelector((short)TypeRepeatEnum.NoRepeat, "Ohne"));
                    colRepeatTypes.Add(new TypeSelector((short)TypeRepeatEnum.Annually, "Jährlich"));
                    colRepeatTypes.Add(new TypeSelector((short)TypeRepeatEnum.Monthly, "Monatlich"));
                    colRepeatTypes.Add(new TypeSelector((short)TypeRepeatEnum.Quarterly, "Quartalsweise"));
                    colRepeatTypes.Add(new TypeSelector((short)TypeRepeatEnum.Schedule, "Zahlungsplan"));
                    cbRepeatBooking.ItemsSource = colRepeatTypes.Select(b => b.Title);
                    cbRepeatBooking.SelectedIndex = colRepeatTypes.IndexOf(colRepeatTypes.FirstOrDefault(b => b.TypeCode == planBooking.TypeRepeat));
                }

                // Init Combo Inflation Rule #####TO DO#####
                {
                    chkInflationBookingEnable.IsChecked = false;
                    cbInflationBooking.IsEnabled = false;
                    dpPriceDateBooking.IsEnabled = false;
                }
            }
            else
                tiBooking.Visibility = Visibility.Collapsed;
        }

        private void btnAccountDebitSelect_Click(object sender, RoutedEventArgs e)
        {

        }

        private void tbAccountDebitCode_ValueChanged(object sender, RoutedPropertyChangedEventArgs<object> e)
        {
            var account = new Account();

            if (e.NewValue != null && account.SelectViaKey((int)e.NewValue))
            {
                lbAccountDebitTitle.Content = account.TitleLocalAccount;
                planBooking.idAccountDebit = account.Id;
            }
            else
                lbAccountDebitTitle.Content = "n/a";
        }

        private void btnAccountCreditSelect_Click(object sender, RoutedEventArgs e)
        {

        }

        private void tbAccountCreditCode_ValueChanged(object sender, RoutedPropertyChangedEventArgs<object> e)
        {
            var account = new Account();

            if (e.NewValue != null && account.SelectViaKey((int)e.NewValue))
            {
                lbAccountCreditTitle.Content = account.TitleLocalAccount;
                planBooking.idAccountCredit = account.Id;
            }
            else
                lbAccountCreditTitle.Content = "n/a";
        }

        private void cbRepeatBooking_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            planBooking.TypeRepeat = colRepeatTypes.ElementAt(cbRepeatBooking.SelectedIndex).TypeCode;
        }

        private void chkInflationBookingEnable_Checked(object sender, RoutedEventArgs e)
        {

        }

        private void chkInflationBookingEnable_Unchecked(object sender, RoutedEventArgs e)
        {

        }

        private void cbInflationBooking_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        /// <summary>
        /// Tab HR
        /// </summary>

        ObservableCollection<PlanHRTariff> colHRTariffs;
        ObservableCollection<PlanHRExpenseGroup> colHRExpenseGroup;

        private void InitTabHR()
        {
            if (planHR != null)
            {
                tiElementHR.DataContext = planHR;
                tiElementHR.Visibility = Visibility.Visible;

                UpdateComboTariff();
                UpdateComboExpenseGroup();

                // Init Combo Inflation Rule #####TO DO#####
                {
                    chkInflationHREnable.IsChecked = false;
                    cbInflationHR.IsEnabled = false;
                }
            }
            else
                tiElementHR.Visibility = Visibility.Collapsed;
        }

        private void UpdateComboTariff()
        {
            if (colHRTariffs is null)
            {
                colHRTariffs = PlanHRTariff.GetBOCollection(elementInstance.idPlan).GetObservableCollection();

                cbTariff.ItemsSource = colHRTariffs;
                cbTariff.IsEnabled = true;
                btnNewTariff.IsEnabled = true;

                if (planHR.idTariff == null)
                    btnEditTariff.IsEnabled = false;
                else
                {
                    cbTariff.SelectedItem = colHRTariffs.FirstOrDefault(b => b.Id == planHR.idTariff);

                    if (cbTariff.SelectedItem == null)
                        btnEditTariff.IsEnabled = false;
                    else
                        btnEditTariff.IsEnabled = true;
                }
            }
            else
            {
                cbTariff.IsEnabled = true;
                btnNewTariff.IsEnabled = true;

                if (cbTariff.SelectedItem == null)
                    btnEditTariff.IsEnabled = false;
                else
                    btnEditTariff.IsEnabled = true;
            }
        }

        private void UpdateComboExpenseGroup()
        {
            if (colHRExpenseGroup is null)
            {
                colHRExpenseGroup = PlanHRExpenseGroup.GetBOCollection(elementInstance.idPlan).GetObservableCollection();

                cbExpenseGroup.ItemsSource = colHRExpenseGroup;
                cbExpenseGroup.IsEnabled = true;
                btnNewExpenseGroup.IsEnabled = true;

                if (planHR.idExpenseGroup == null)
                    btnEditExpenseGroup.IsEnabled = false;
                else
                {
                    cbExpenseGroup.SelectedItem = colHRExpenseGroup.FirstOrDefault(b => b.Id == planHR.idExpenseGroup);

                    if (cbExpenseGroup.SelectedItem == null)
                        btnEditExpenseGroup.IsEnabled = false;
                    else
                        btnEditExpenseGroup.IsEnabled = true;
                }
            }
            else
            {
                cbExpenseGroup.IsEnabled = true;
                btnNewExpenseGroup.IsEnabled = true;

                if (cbExpenseGroup.SelectedItem == null)
                    btnEditExpenseGroup.IsEnabled = false;
                else
                    btnEditExpenseGroup.IsEnabled = true;
            }
        }

        private void cbTariff_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbTariff.SelectedItem == null)
                MessageBox.Show("Bitte wählen Sie einen gültigen Tarif auf dem Register HR.", "HR Tarif nicht gewählt", MessageBoxButton.OK, MessageBoxImage.Error);
            else
                planHR.idTariff = colHRTariffs.ElementAt(cbTariff.SelectedIndex).Id;

            UpdateComboTariff();
        }

        private void btnNewTariff_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new HRTariffEdit(planHR.PlanParent, planElement.TitlePlanElement, false);
            wnd.ShowDialog();

            if (!wnd.FlagCancel)
            {
                planHR.idTariff = wnd.item.Id;
                UpdateComboTariff();
            }
        }

        private void btnEditTariff_Click(object sender, RoutedEventArgs e)
        {
            if (cbTariff.SelectedItem != null)
            {
                var wnd = new HRTariffEdit((PlanHRTariff)cbTariff.SelectedItem);
                wnd.ShowDialog();
                UpdateComboTariff();
            }

        }

        private void cbExpenseGroup_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbExpenseGroup.SelectedItem == null)
                MessageBox.Show("Bitte wählen Sie eine gültige Nebenkostengruppe auf dem Register HR.", "HR Nebenkosten nicht gewählt", MessageBoxButton.OK, MessageBoxImage.Error);
            else
                planHR.idExpenseGroup = colHRExpenseGroup.ElementAt(cbExpenseGroup.SelectedIndex).Id;

            UpdateComboExpenseGroup();
        }

        private void btnNewExpenseGroup_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnEditExpenseGroup_Click(object sender, RoutedEventArgs e)
        {

        }

        private void chkInflationHREnable_Checked(object sender, RoutedEventArgs e)
        {

        }

        private void chkInflationHREnable_Unchecked(object sender, RoutedEventArgs e)
        {

        }

        private void cbInflationHR_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }


        /// <summary>
        /// Tab Schedule
        /// </summary>

        ObservableCollection<PlanAllocationSchedule> colAllocationSchedules;
        ObservableCollection<PlanAllocationScheduleItems> colAllocationScheduleItems;

        private void InitTabSchedule()
        {
            if (planContract != null)
            {
                tiSchedule.DataContext = planContract;
                tiSchedule.Visibility = Visibility.Visible;

                if (planContract.idAllocationSchedule == Guid.Empty)
                    chkScheduleEnable.IsChecked = false;
                else
                    chkScheduleEnable.IsChecked = true;

                UpdateTabSchedule();
            }
            else if (planBooking != null)
            {
                tiSchedule.DataContext = planBooking;
                tiSchedule.Visibility = Visibility.Visible;

                if (planBooking.idAllocationSchedule == Guid.Empty)
                    chkScheduleEnable.IsChecked = false;
                else
                    chkScheduleEnable.IsChecked = true;

                UpdateTabSchedule();
            }
            else
                tiSchedule.Visibility = Visibility.Collapsed;
        }

        private void UpdateTabSchedule()
        {

            // Init Allocation Schedules Controls

            if ((bool)chkScheduleEnable.IsChecked)
            {
                // init schedule combo box
                colAllocationSchedules = PlanAllocationSchedule.GetBOCollection(elementInstance.idPlan).GetObservableCollection();
                cbAllocationSchedule.ItemsSource = colAllocationSchedules.Select(i => i.TitleAllocationSchedule);

                cbAllocationSchedule.IsEnabled = true;
                btnNewAllocationSchedule.IsEnabled = true;

                if (planElement.TypePlanElement == (short)TypePlanElementEnum.BookingRule)
                {
                    if (planBooking.idAllocationSchedule == Guid.Empty)
                    {
                        btnEditAllocationSchedule.IsEnabled = false;
                        dgSchedule.IsEnabled = false;
                        dgSchedule.ItemsSource = null;
                    }
                    else
                    {
                        cbAllocationSchedule.SelectedIndex = colAllocationSchedules.IndexOf(colAllocationSchedules.FirstOrDefault(b => b.Id == planBooking.idAllocationSchedule));
                        btnEditAllocationSchedule.IsEnabled = true;

                        if (planBooking.AllocationScheduleParent.FlagAuto)
                        {
                            dgSchedule.IsEnabled = false;
                            dgSchedule.ItemsSource = null;
                        }
                        else
                        {
                            colAllocationScheduleItems = planBooking.AllocationScheduleParent.PlanAllocationScheduleChildren().GetObservableCollection();
                            dgSchedule.ItemsSource = colAllocationScheduleItems;
                            dgSchedule.IsEnabled = true;
                        }
                    }
                }
                else
                {
                    if (planContract.idAllocationSchedule == Guid.Empty)
                    {
                        btnEditAllocationSchedule.IsEnabled = false;
                        dgSchedule.IsEnabled = false;
                        dgSchedule.ItemsSource = null;
                    }
                    else
                    {
                        cbAllocationSchedule.SelectedIndex = colAllocationSchedules.IndexOf(colAllocationSchedules.FirstOrDefault(b => b.Id == planContract.idAllocationSchedule));
                        btnEditAllocationSchedule.IsEnabled = true;

                        if (planContract.AllocationScheduleParent.FlagAuto)
                        {
                            dgSchedule.IsEnabled = false;
                            dgSchedule.ItemsSource = null;
                        }
                        else
                        {
                            colAllocationScheduleItems = planContract.AllocationScheduleParent.PlanAllocationScheduleChildren().GetObservableCollection();
                            dgSchedule.ItemsSource = colAllocationScheduleItems;
                            dgSchedule.IsEnabled = true;
                        }
                    }
                }
            }
            else
            {
                cbAllocationSchedule.IsEnabled = false;
                btnNewAllocationSchedule.IsEnabled = false;
                btnEditAllocationSchedule.IsEnabled = false;
                dgSchedule.IsEnabled = false;
                dgSchedule.ItemsSource = null;
            }
        }

        private void chkScheduleEnable_Checked(object sender, RoutedEventArgs e)
        {
            UpdateTabSchedule();
        }

        private void chkScheduleEnable_Unchecked(object sender, RoutedEventArgs e)
        {
            cbAllocationSchedule.SelectedItem = null;
            UpdateTabSchedule();
        }

        private void cbAllocationSchedule_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (planElement.TypePlanElement == (short)TypePlanElementEnum.BookingRule)
            {
                if (cbAllocationSchedule.SelectedItem == null)
                    planBooking.idAllocationSchedule = null;
                else
                    planBooking.idAllocationSchedule = colAllocationSchedules.ElementAt(cbAllocationSchedule.SelectedIndex).Id;
            }
            else
            {
                if (cbAllocationSchedule.SelectedItem == null)
                    planContract.idAllocationSchedule = null;
                else
                    planContract.idAllocationSchedule = colAllocationSchedules.ElementAt(cbAllocationSchedule.SelectedIndex).Id;
            }

            UpdateTabSchedule();
        }

        private void btnNewAllocationSchedule_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new AllocationScheduleEdit(elementInstance.idPlan, planElement.TitlePlanElement);
            wnd.ItemUpdated += ScheduleCreatedEventHandler;
            wnd.Show();
        }

        private void btnEditAllocationSchedule_Click(object sender, RoutedEventArgs e)
        {
            AllocationScheduleEdit wnd;

            if (planElement.TypePlanElement == (short)TypePlanElementEnum.BookingRule)
            {
                wnd = new AllocationScheduleEdit(planBooking.AllocationScheduleParent);
            }
            else
            {
                wnd = new AllocationScheduleEdit(planContract.AllocationScheduleParent);
            }

            wnd.ItemUpdated += ScheduleUpdatedEventHandler;
            wnd.Show();
        }

        private void ScheduleCreatedEventHandler(object sender, PlanAllocationSchedule item)
        {
            if (planElement.TypePlanElement == (short)TypePlanElementEnum.BookingRule)
                planBooking.idAllocationSchedule = item.Id;
            else
                planContract.idAllocationSchedule = item.Id;

            UpdateTabSchedule();
            OnRaiseItemUpdated();
        }

        private void ScheduleUpdatedEventHandler(object sender, PlanAllocationSchedule item)
        {
            UpdateTabSchedule();
            OnRaiseItemUpdated();
        }

        private void dgSchedule_AddingNewItem(object sender, AddingNewItemEventArgs e)
        {
            var item = new PlanAllocationScheduleItems();
            item.New();

            if (planElement.TypePlanElement == (short)TypePlanElementEnum.BookingRule)
            {
                item.idPlanAllocationSchedule = planBooking.idAllocationSchedule.GetValueOrDefault();
            }
            else
            {
                item.idPlanAllocationSchedule = planContract.idAllocationSchedule.GetValueOrDefault();
            }

            if (colAllocationScheduleItems.Count == 0)
                item.OrderNum = 1;
            else
                item.OrderNum = colAllocationScheduleItems.Max(b => b.OrderNum) + 1;

            item.ItemRate = 0;
            item.CommitChanges();
            e.NewItem = item;
        }

        private void dgSchedule_PreviewExecuted(object sender, ExecutedRoutedEventArgs e)
        {
            if (e.Command == DataGrid.DeleteCommand)
                if (((PlanAllocationScheduleItems)dgSchedule.SelectedItem).Delete() != BOResult.Success)
                MessageBox.Show("Fehler beim Löschen des Eintrags.", "Element eines Zahlungsplanes löschen", MessageBoxButton.OK, MessageBoxImage.Error);
        }

        /// <summary>
        /// Tab Advance
        /// </summary>
        private void InitTabAdvance()
        {
            if (planContract != null)
            {
                tiAdvance.DataContext = planContract;

                if (planContract.idAccountAdvance != null && planContract.idAccountAdvance != Guid.Empty)
                    chkAdvanceEnable.IsChecked = true;
                else
                    chkDepreciationEnable.IsChecked = false;

                tiAdvance.Visibility = Visibility.Visible;
                UpdateTabAdvance();
            }
            else
                tiAdvance.Visibility = Visibility.Collapsed;

        }

        private void UpdateTabAdvance()
        {
            if (planContract.AccountAdvanceParent == null)
                tbAccountAdvanceCode.Value = null;
            else
                tbAccountAdvanceCode.Value = planContract.AccountAdvanceParent.AccountCode;

            if (chkAdvanceEnable.IsChecked.GetValueOrDefault())
            {
                tbAccountAdvanceCode.IsEnabled = true;
                tbAdvanceDelay.IsEnabled = true;
                chkAdvanceTriggerEnable.IsEnabled = true;
                AdvanceTriggerUpdateCombo();
            }
            else
            {
                tbAccountAdvanceCode.IsEnabled = false;
                tbAdvanceDelay.IsEnabled = false;
                chkAdvanceTriggerEnable.IsEnabled = false;
                cbAdvanceTrigger.IsEnabled = false;
                btnNewAdvanceTrigger.IsEnabled = false;
                btnEditAdvanceTrigger.IsEnabled = false;
            }
        }

        private void AdvanceTriggerUpdateCombo(bool force = false)
        {
            if (colTriggerDates == null || force)
                colTriggerDates = PlanParameter.GetBOCollection(planContract.idPlan, TypePlanParameterEnum.TriggerDate).GetObservableCollection();

            cbAdvanceTrigger.ItemsSource = colTriggerDates.Select(i => i.TitlePlanParameter);

            if (planContract.idParTriggerAdvance != null && planContract.idParTriggerAdvance != Guid.Empty)
            {
                cbAdvanceTrigger.SelectedIndex = colTriggerDates.IndexOf(colTriggerDates.FirstOrDefault(b => b.Id == planContract.idParTriggerAdvance));
                chkAdvanceTriggerEnable.IsChecked = true;
            }

            if (chkAdvanceTriggerEnable.IsChecked.GetValueOrDefault())
            {
                cbAdvanceTrigger.IsEnabled = true;
                btnNewAdvanceTrigger.IsEnabled = true;
                //tbAdvanceDelay.IsEnabled = false;

                if (cbAdvanceTrigger.SelectedIndex > -1)
                    btnEditAdvanceTrigger.IsEnabled = true;
                else
                    btnEditAdvanceTrigger.IsEnabled = false;
            }
            else
            {
                chkAdvanceTriggerEnable.IsChecked = false;
                cbAdvanceTrigger.SelectedIndex = -1;
                cbAdvanceTrigger.IsEnabled = false;
                btnNewAdvanceTrigger.IsEnabled = false;
                btnEditAdvanceTrigger.IsEnabled = false;

                if (chkAdvanceEnable.IsChecked.GetValueOrDefault())
                    tbAdvanceDelay.IsEnabled = true;
            }
        }

        private void chkAdvanceEnable_Checked(object sender, RoutedEventArgs e)
        {
            UpdateTabAdvance();
        }

        private void chkAdvanceEnable_Unchecked(object sender, RoutedEventArgs e)
        {
            planContract.idAccountAdvance = null;
            planContract.idParTriggerAdvance = null;
            planContract.AdvanceDelay = 0;
            UpdateTabAdvance();
        }

        private void chkAdvanceTriggerEnable_Checked(object sender, RoutedEventArgs e)
        {
            //planContract.AdvanceDelay = 0;
            UpdateTabAdvance();
        }

        private void chkAdvanceTriggerEnable_Unchecked(object sender, RoutedEventArgs e)
        {
            cbAdvanceTrigger.SelectedItem = null;
            UpdateTabAdvance();
        }

        private void cbAdvanceTrigger_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbAdvanceTrigger.SelectedIndex == -1)
            {
                planContract.idParTriggerAdvance = null;
                btnEditAdvanceTrigger.IsEnabled = false;
            }
            else
            {
                planContract.idParTriggerAdvance = colTriggerDates.ElementAt(cbAdvanceTrigger.SelectedIndex).Id;
                btnEditAdvanceTrigger.IsEnabled = true;
            }
        }

        private void btnNewAdvanceTrigger_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new ParameterEdit(TypePlanParameterEnum.TriggerDate, elementInstance.idPlan, planElement.TitlePlanElement + " Trigger");
            wnd.ItemUpdated += AdvanceTriggerUpdatedEventHandler;
            wnd.Show();
        }

        private void btnEditAdvanceTrigger_Click(object sender, RoutedEventArgs e)
        {
            if (cbAdvanceTrigger.SelectedItem != null)
            {
                var wnd = new ParameterEdit((PlanParameter)colTriggerDates.ElementAt(cbAdvanceTrigger.SelectedIndex));
                wnd.ItemUpdated += AdvanceTriggerUpdatedEventHandler;
                wnd.Show();
            }
        }

        private void AdvanceTriggerUpdatedEventHandler(object sender, PlanParameter item)
        {
            if (item != null && planContract.idParTriggerAdvance != item.Id)
                planContract.idParTriggerAdvance = item.Id;

            AdvanceTriggerUpdateCombo(true);
            OnRaiseItemUpdated();
        }

        private void btnAccountAdvanceSelect_Click(object sender, RoutedEventArgs e)
        {

        }

        private void tbAccountAdvanceCode_ValueChanged(object sender, RoutedPropertyChangedEventArgs<object> e)
        {
            var account = new Account();
            
            if (e.NewValue != null && account.SelectViaKey((int)e.NewValue))
            {
                lbAccountAdvanceTitle.Content = account.TitleLocalAccount;
                planContract.idAccountAdvance = account.Id;
            }
            else
                lbAccountAdvanceTitle.Content = "n/a";
        }

        /// <summary>
        /// Tab Depreciation
        /// </summary>

        ObservableCollection<DepreciationRule> colDepreciationRules;
        ObservableCollection<PlanParameter> colTriggerDates;

        private void InitTabDepreciation()
        {
            if (planContract != null && planElement.TypePlanElement == (short)TypePlanElementEnum.Purchase)
            {
                tiDepreciation.DataContext = planContract;


                // Init Depreciation Rules combo
                {
                    colDepreciationRules = DepreciationRule.GetBOCollection().GetObservableCollection();
                    cbDepreciationRule.ItemsSource = colDepreciationRules.Select(i => i.TitleDepreciationRule);

                    if (planContract.idDepreciationRule != null && planContract.idDepreciationRule != Guid.Empty)
                    {
                        chkDepreciationEnable.IsChecked = true;
                        cbDepreciationRule.SelectedIndex = colDepreciationRules.IndexOf(colDepreciationRules.FirstOrDefault(b => b.Id == planContract.idDepreciationRule));
                    }
                    else
                        chkDepreciationEnable.IsChecked = false;
                }

                // Init Depreciation Trigger combo
                DepreciationTriggerUpdateCombo();

                tiDepreciation.Visibility = Visibility.Visible;
            }
            else
                tiDepreciation.Visibility = Visibility.Collapsed;

            UpdateTabDepreciation();
        }

        private void UpdateTabDepreciation()
        {
            if (chkDepreciationEnable.IsChecked.GetValueOrDefault())
            {
                cbDepreciationRule.IsEnabled = true;
                btnNewDepreciationRule.IsEnabled = true;

                if (cbDepreciationRule.SelectedIndex > -1)
                    btnEditDepreciationRule.IsEnabled = true;
                else
                    btnEditDepreciationRule.IsEnabled = false;

                tbDepreciationDelay.IsEnabled = true;

                DepreciationTriggerUpdateCombo();
            }
            else
            {
                cbDepreciationRule.IsEnabled = false;
                btnNewDepreciationRule.IsEnabled = false;
                btnEditDepreciationRule.IsEnabled = false;

                tbDepreciationStartDay.IsEnabled = false;
                tbDepreciationStartMonth.IsEnabled = false;
                tbDepreciationStartYear.IsEnabled = false;
                tbDepreciationDelay.IsEnabled = false;

                cbDepreciationTrigger.IsEnabled = false;
                chkDepreciationTriggerEnable.IsEnabled = false;
                btnNewDepreciationTrigger.IsEnabled = false;
                btnEditDepreciationTrigger.IsEnabled = false;
            }
        }

        private void DepreciationTriggerUpdateCombo(bool force = false)
        {
            if (colTriggerDates == null || force)
                colTriggerDates = PlanParameter.GetBOCollection(planContract.idPlan, TypePlanParameterEnum.TriggerDate).GetObservableCollection();

            cbDepreciationTrigger.ItemsSource = colTriggerDates.Select(i => i.TitlePlanParameter);

            if (planContract.idDepreciationTrigger != null && planContract.idDepreciationTrigger != Guid.Empty)
            {
                cbDepreciationTrigger.SelectedIndex = colTriggerDates.IndexOf(colTriggerDates.FirstOrDefault(b => b.Id == planContract.idDepreciationTrigger));
                chkDepreciationTriggerEnable.IsChecked = true;
            }

            if (chkDepreciationTriggerEnable.IsChecked.GetValueOrDefault())
            {
                cbDepreciationTrigger.IsEnabled = true;
                btnNewDepreciationTrigger.IsEnabled = true;
                tbDepreciationStartDay.IsEnabled = false;
                tbDepreciationStartMonth.IsEnabled = false;
                tbDepreciationStartYear.IsEnabled = false;

                if (cbDepreciationTrigger.SelectedIndex > -1)
                    btnEditDepreciationTrigger.IsEnabled = true;
                else
                    btnEditDepreciationTrigger.IsEnabled = false;
            }
            else
            {
                chkDepreciationTriggerEnable.IsChecked = false;
                cbDepreciationTrigger.SelectedIndex = -1;
                cbDepreciationTrigger.IsEnabled = false;
                btnNewDepreciationTrigger.IsEnabled = false;
                btnEditDepreciationTrigger.IsEnabled = false;

                if (chkDepreciationEnable.IsChecked.GetValueOrDefault())
                {
                    tbDepreciationStartDay.IsEnabled = true;
                    tbDepreciationStartMonth.IsEnabled = true;
                    tbDepreciationStartYear.IsEnabled = true;
                }
            }
        }

        private void chkDepreciationEnable_Checked(object sender, RoutedEventArgs e)
        {
            UpdateTabDepreciation();
        }

        private void chkDepreciationEnable_Unchecked(object sender, RoutedEventArgs e)
        {
            planContract.idDepreciationRule = null;
            cbDepreciationRule.SelectedItem = null;
            planContract.idDepreciationTrigger = null;
            cbDepreciationTrigger.SelectedItem = null;
            planContract.DepreciationStartDay = 0;
            planContract.DepreciationStartMonth = 0;
            planContract.DepreciationStartYear = 0;
            planContract.DepreciationDelay = 0;
            UpdateTabDepreciation();
        }

        private void cbDepreciationRule_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbDepreciationRule.SelectedIndex == -1)
            {
                btnEditDepreciationTrigger.IsEnabled = false;
                planContract.idDepreciationRule = null;
            }
            else
            {
                btnEditDepreciationTrigger.IsEnabled = true;
                planContract.idDepreciationRule = colDepreciationRules.ElementAt(cbDepreciationRule.SelectedIndex).Id;
            }
        }

        private void btnNewDepreciationRule_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnEditDepreciationRule_Click(object sender, RoutedEventArgs e)
        {

        }

        private void chkDepreciationTriggerEnable_Checked(object sender, RoutedEventArgs e)
        {
            planContract.DepreciationStartDay = 0;
            planContract.DepreciationStartMonth = 0;
            planContract.DepreciationStartYear = 0;
            UpdateTabDepreciation();
        }

        private void chkDepreciationTriggerEnable_Unchecked(object sender, RoutedEventArgs e)
        {
            cbDepreciationTrigger.SelectedItem = null;
            UpdateTabDepreciation();
        }

        private void cbDepreciationTrigger_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbDepreciationTrigger.SelectedIndex == -1)
                planContract.idDepreciationTrigger= null;
            else
                planContract.idDepreciationTrigger = colTriggerDates.ElementAt(cbDepreciationTrigger.SelectedIndex).Id;
        }

        private void btnNewDepreciationTrigger_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new ParameterEdit(TypePlanParameterEnum.TriggerDate, elementInstance.idPlan, planElement.TitlePlanElement + " Trigger");
            wnd.ItemUpdated += DepreciationTriggerCreatedEventHandler;
            wnd.Show();
        }

        private void btnEditDepreciationTrigger_Click(object sender, RoutedEventArgs e)
        {
            if (cbDepreciationTrigger.SelectedItem != null)
            {
                var wnd = new ParameterEdit((PlanParameter)colTriggerDates.ElementAt(cbDepreciationTrigger.SelectedIndex));
                wnd.ItemUpdated += DepreciationTriggerUpdatedEventHandler;
                wnd.Show();
            }
        }

        private void DepreciationTriggerCreatedEventHandler(object sender, PlanParameter item)
        {
            if (item != null && planContract.idDepreciationTrigger != item.Id)
                planContract.idDepreciationTrigger = item.Id;

            DepreciationTriggerUpdateCombo(true);
            OnRaiseItemUpdated();
        }

        private void DepreciationTriggerUpdatedEventHandler(object sender, PlanParameter item)
        {
            DepreciationTriggerUpdateCombo();
            OnRaiseItemUpdated();
        }

        /// <summary>
        /// Tab Extended Contract
        /// </summary>
        private void InitTabExtended()
        {
            if (planContract != null)
            {
                tiExtended.DataContext = planContract;
                tiExtended.Visibility = Visibility.Collapsed;
            }
            else
                tiExtended.Visibility = Visibility.Collapsed;
        }

        private void chkPricePar1Enable_Checked(object sender, RoutedEventArgs e)
        {

        }

        private void chkPricePar1Enable_Unchecked(object sender, RoutedEventArgs e)
        {

        }

        private void cbPricePar1_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void btnNewPricePar1_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnEditPricePar1_Click(object sender, RoutedEventArgs e)
        {

        }

        private void chkPricePar2Enable_Checked(object sender, RoutedEventArgs e)
        {

        }

        private void chkPricePar2Enable_Unchecked(object sender, RoutedEventArgs e)
        {

        }

        private void cbPricePar2_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void btnNewPricePar2_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnEditPricePar2_Click(object sender, RoutedEventArgs e)
        {

        }

        private void cbContingency_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void btnNewContingency_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnEditContigency_Click(object sender, RoutedEventArgs e)
        {

        }

        private void chkInflationEnable_Checked(object sender, RoutedEventArgs e)
        {

        }

        private void chkInflationEnable_Unchecked(object sender, RoutedEventArgs e)
        {

        }

        private void cbInflation_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void chkContingencyEnable_Unchecked(object sender, RoutedEventArgs e)
        {

        }

        private void chkContingencyEnable_Checked(object sender, RoutedEventArgs e)
        {

        }

        /// <summary>
        /// Tab Transactions
        /// </summary>
        private void InitTabTransactions()
        {
            if (elementInstance != null)
            {
                var transactions = elementInstance.GetBookTransactions().GetObservableCollection();
                tiTransactions.DataContext = elementInstance;
                dgTransactions.ItemsSource = transactions;

                tiTransactions.Visibility = Visibility.Visible;
            }
            else
                tiTransactions.Visibility = Visibility.Collapsed;
        }

        private void tbReferenceID_LostFocus(object sender, RoutedEventArgs e)
        {
            //var obj = VerumInstance.Context.tReferenceCode.Where(b => b.RefCode == txtReferenceID.Text && b.idClient == VerumInstance.IdClient);
            var obj = ReferenceCode.GetBOCollection().GetObservableCollection();

            if (!obj.Any(x => x.RefCode == tbReferenceID.Text) && tbReferenceID.Text != "") 
            { 
                tbReferenceID.Focus();
                AddRefCode wnd = new AddRefCode(tbReferenceID.Text, this);
                wnd.Show();
            }
        }

        

        private void btnImportAllocationSchedule_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new ImportAllocationSchedule(elementInstance);
            wnd.Show();
            //ImportPlanAllocationScheduleItems();
            //ImportPlanAllocationSchedule();
        }
    }
}


