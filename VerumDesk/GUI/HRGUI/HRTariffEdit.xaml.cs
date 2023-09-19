using System;
using System.Collections.ObjectModel;
using System.Windows;
using VerumBusinessObjects;
using VerumBusinessObjects.Framework;

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für HRTariffEdit.xaml
    /// </summary>
    public partial class HRTariffEdit : Window
    {
        public bool FlagCancel = false;
        public PlanHRTariff item;
        ObservableCollection<tPlanHRTariffDetail> itemCollection;

        /// <summary>
        /// Constructor for new tariff
        /// </summary>
        /// <param name="idPlan"></param>
        /// <param name="title"></param>
        public HRTariffEdit(Plan plan, string title = "", bool flagShared = false)
        {
            item = new PlanHRTariff();
            item.New();
            item.idPlan = plan.Id;
            item.TitleTariff = title;
            item.FlagShared = flagShared;
            item.PayDay = 28;
            item.AccountSalaryParent = new PlanAccountFunction().SalaryDefault();

            Init();
        }

        public HRTariffEdit(PlanHRTariff tariff)
        {
            item = tariff;
            Init();
        }

        void Init()
        {
            DataContext = item;
            InitializeComponent();
            tbAccountCode.Value = item.AccountSalaryParent.AccountCode;
            UpdateLists();
        }

        private void UpdateLists()
        {
            itemCollection = item.GetTariffDetails();
            dgDetails.ItemsSource = itemCollection;
        }

        private void tbAccountCode_ValueChanged(object sender, RoutedPropertyChangedEventArgs<object> e)
        {
            var account = new Account();

            if (e.NewValue != null && account.SelectViaKey((int)e.NewValue))
            {
                lbAccountTitle.Content = account.TitleLocalAccount;
                item.idAccountSalary = account.Id;
            }
            else
                lbAccountTitle.Content = "n/a";
        }

        private void btnAccountSelect_Click(object sender, RoutedEventArgs e)
        {

        }

        private void chkFlagShared_Checked(object sender, RoutedEventArgs e)
        {

        }

        private void chkFlagShared_Unchecked(object sender, RoutedEventArgs e)
        {

        }

        private void cmdOK_Click(object sender, RoutedEventArgs e)
        {
            if (item.Validate() == BOResult.Success)
            {
                FlagCancel = false;
                item.CommitChanges();
                Close();
            }
            else
                MessageBox.Show("Eingaben nicht gültig.","Eingabefehler");
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            FlagCancel = true;
            Close();
        }

        public event EventHandler<PlanHRTariff> ItemUpdated;

        protected virtual void OnRaiseItemUpdated()
        {
            ItemUpdated?.Invoke(this, item);
        }

        private void cmdDetailEdit_Click(object sender, RoutedEventArgs e)
        {
            if (dgDetails.SelectedItem != null)
            {
                var recordDetail = (tPlanHRTariffDetail)dgDetails.SelectedItem;
                var itemDetail = new PlanHRTariffDetail(recordDetail.Id);
                var wnd = new HRTariffDetailEdit(itemDetail);
                wnd.ShowDialog();
                UpdateLists();
            }
        }

        private void cmdDetailNew_Click(object sender, RoutedEventArgs e)
        {
            PlanHRTariffDetail itemDetail = null;

            if (dgDetails.SelectedItem != null)
            {
                var recordDetail = (tPlanHRTariffDetail)dgDetails.SelectedItem;
                itemDetail = new PlanHRTariffDetail(recordDetail.Id);
            }

            // item must be saved to db before child
            if (!item.Bound && item.Validate() == BOResult.Success)
                item.CommitChanges();

            if (item.Bound)
            {
                var wnd = new HRTariffDetailEdit(item, itemDetail);
                wnd.ShowDialog();
                UpdateLists();
            }
            else
                MessageBox.Show("Eingaben nicht gültig.", "Eingabefehler");

        }

        private void cmdDetailDelete_Click(object sender, RoutedEventArgs e)
        {
            if (dgDetails.SelectedItem != null)
            {
                var recordDetail = (tPlanHRTariffDetail)dgDetails.SelectedItem;
                var itemDetail = new PlanHRTariffDetail(recordDetail.Id);
                itemDetail.Delete();
                UpdateLists();
            }
        }
    }
}
