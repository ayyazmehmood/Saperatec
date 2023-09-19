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
    /// Interaktionslogik für PlanItemNew.xaml
    /// </summary>
    public partial class PlanItemNew : Window
    {
        ObservableCollection<PlanGroup> colPlanGroups;
        ObservableCollection<PlanElement> colPlanElements;
        ObservableCollection<PlanHRExpenseGroup> colPlanHRExpenseGroup;
        ObservableCollection<PlanHRTariff> colPlanHRTariff;
        ObservableCollection<TypeSelector> colElementTypes;
        Account selectedDebitAccount;
        Account selectedCreditAccount;
        Plan plan;
        PlanElementInstance instance;

        public PlanItemNew(Plan plan)
        {
            this.plan = plan;

            InitializeComponent();

            // init plan group combo box
            colPlanGroups = PlanGroup.GetBOCollection().GetObservableCollection();
            cbPlanGroup.ItemsSource = colPlanGroups.Select(i => i.TitlePlanGroup);

            // init plan element combo box
            colPlanElements = PlanElement.GetBOCollection().GetObservableCollection();
            cbPlanElement.ItemsSource = colPlanElements.Select(i => i.TitlePlanElement);

            // init plan HR Expense Group combo box
            colPlanHRExpenseGroup = PlanHRExpenseGroup.GetBOCollection(plan.Id).GetObservableCollection();
            cbExpenseGroup.ItemsSource = colPlanHRExpenseGroup;

            // init plan HR Tariff combo box
            colPlanHRTariff = PlanHRTariff.GetBOCollection(plan.Id).GetObservableCollection();
            cbTariff.ItemsSource = colPlanHRTariff;

            // Init Combo Box Plan Element Type
            {
                colElementTypes = new ObservableCollection<TypeSelector>();
                colElementTypes.Add(new TypeSelector((short)TypePlanElementEnum.BookingRule, "Buchung"));
                colElementTypes.Add(new TypeSelector((short)TypePlanElementEnum.Purchase, "Einkauf"));
                colElementTypes.Add(new TypeSelector((short)TypePlanElementEnum.Personnel, "Personal"));
                colElementTypes.Add(new TypeSelector((short)TypePlanElementEnum.Sale, "Vertrieb"));
                cbElementType.ItemsSource = colElementTypes.Select(b => b.Title);
                cbElementType.SelectedIndex = 1;
            }
        }

        private void cbPlanGroup_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void cbPlanElement_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbPlanElement.SelectedIndex == -1)
            {
                cbPlanGroup.IsEnabled = true;
                cbElementType.IsEnabled = true;
                cbElementType.SelectedIndex = 0;
            }
            else
            {
                cbPlanGroup.IsEnabled = false;
                cbPlanGroup.SelectedIndex = colPlanGroups.IndexOf(colPlanGroups.FirstOrDefault(b => b.Id == colPlanElements.ElementAt(cbPlanElement.SelectedIndex).idPlanGroup));
                cbElementType.IsEnabled = false;
                cbElementType.SelectedIndex = colElementTypes.IndexOf(colElementTypes.FirstOrDefault(b => b.TypeCode == colPlanElements.ElementAt(cbPlanElement.SelectedIndex).TypePlanElement));
            }
        }

        private void tbAccountMainCode_ValueChanged(object sender, RoutedPropertyChangedEventArgs<object> e)
        {
            var account = new Account();

            if (account.SelectViaKey(tbAccountMainCode.Value.GetValueOrDefault()))
            {
                lbAccountMainTitle.Content = account.TitleLocalAccount;
                selectedDebitAccount = account;
            }
            else
            {
                lbAccountMainTitle.Content = "n/a";
                selectedDebitAccount = null;
            }
        }

        private void tbAccountCreditCode_ValueChanged(object sender, RoutedPropertyChangedEventArgs<object> e)
        {
            var account = new Account();

            if (account.SelectViaKey(tbAccountCreditCode.Value.GetValueOrDefault()))
            {
                lbAccountCreditTitle.Content = account.TitleLocalAccount;
                selectedCreditAccount = account;
            }
            else
            {
                lbAccountMainTitle.Content = "n/a";
                selectedCreditAccount = null;
            }
        }

        private void btnAccountMainSelect_Click(object sender, RoutedEventArgs e)
        {

        }

        private void cmdOK_Click(object sender, RoutedEventArgs e)
        {
            bool bCreate = true;
            PlanElement element = null;

            try
            {
                if (cbPlanGroup.SelectedItem == null)
                {
                    MessageBox.Show("Bitte wählen Sie die Plangruppe des Elements aus.", "Planelement erstellen", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                if (cbPlanElement.Text == "")
                {
                    MessageBox.Show("Bitte wählen Sie ein Planelement aus, oder geben Sie einen neuen Titel ein.", "Planelement erstellen", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return;
                }

                if (selectedDebitAccount == null && colElementTypes.ElementAt(cbElementType.SelectedIndex).TypeCode != (short)TypePlanElementEnum.Personnel)
                {
                    if (colElementTypes.ElementAt(cbElementType.SelectedIndex).TypeCode == (short)TypePlanElementEnum.BookingRule)
                        MessageBox.Show("Bitte wählen Sie ein Sollkonto aus.", "Planelement erstellen", MessageBoxButton.OK, MessageBoxImage.Warning);
                    else
                        MessageBox.Show("Bitte wählen Sie ein Buchungskonto aus.", "Planelement erstellen", MessageBoxButton.OK, MessageBoxImage.Warning);

                    return;
                }

                if (colElementTypes.ElementAt(cbElementType.SelectedIndex).TypeCode == (short)TypePlanElementEnum.BookingRule && selectedCreditAccount == null)
                {
                    MessageBox.Show("Bitte wählen Sie ein Habenkonto aus.", "Planelement erstellen", MessageBoxButton.OK, MessageBoxImage.Warning);

                    return;
                }

                if (cbExpenseGroup.SelectedItem == null && colElementTypes.ElementAt(cbElementType.SelectedIndex).TypeCode == (short)TypePlanElementEnum.Personnel)
                {
                    MessageBox.Show("Bitte wählen Sie eine Nebenkosten-Gruppe aus.", "Planelement erstellen", MessageBoxButton.OK, MessageBoxImage.Warning);

                    return;
                }

                if (cbTariff.SelectedItem == null && colElementTypes.ElementAt(cbElementType.SelectedIndex).TypeCode == (short)TypePlanElementEnum.Personnel)
                {
                    MessageBox.Show("Bitte wählen Sie einen Tarif aus.", "Planelement erstellen", MessageBoxButton.OK, MessageBoxImage.Warning);

                    return;
                }

                if (cbPlanElement.SelectedIndex == -1)
                {
                    MessageBoxResult result = MessageBox.Show("Wollen Sie ein neues Planelement für Ihren Mandanten anlegen?", "PlanElement anlegen", MessageBoxButton.YesNo, MessageBoxImage.Question);

                    switch (result)
                    {
                        case MessageBoxResult.Yes:
                            bCreate = true;
                            element = new PlanElement();
                            element.New();
                            element.idClient = plan.idClient;
                            element.TypePlanElement = colElementTypes.ElementAt(cbElementType.SelectedIndex).TypeCode;
                            element.idPlanGroup = colPlanGroups.ElementAt(cbPlanGroup.SelectedIndex).Id;
                            element.TitlePlanElement = cbPlanElement.Text;
                            element.CommitChanges();
                            break;
                        case MessageBoxResult.No:
                            return;
                    }
                }
                else 
                {
                    element = colPlanElements.ElementAt(cbPlanElement.SelectedIndex);

                    if (element.PlanElementInstanceExists(plan) == BOResult.PlanElementInstanceExists)
                    {
                        MessageBox.Show("Das ausgewählte Planelement wird in diesem Plan bereits verwendet.", "Planelement erstellen", MessageBoxButton.OK, MessageBoxImage.Warning);
                        return;
                    }
                }

                if (bCreate && (element != null))
                {
                    instance = new PlanElementInstance();
                    instance.New();
                    instance.idPlan = plan.Id;
                    instance.idPlanElement = element.Id;
                    instance.CommitChanges();

                    switch ((TypePlanElementEnum)colElementTypes.ElementAt(cbElementType.SelectedIndex).TypeCode)
                    {
                        case TypePlanElementEnum.BookingRule:
                            PlanElementBooking booking = new PlanElementBooking();
                            booking.New();
                            booking.idPlanInstance = instance.Id;
                            booking.Price = 0;
                            booking.idAccountDebit = selectedDebitAccount.Id;
                            booking.idAccountCredit = selectedCreditAccount.Id;
                            booking.CommitChanges();
                            break;
                        case TypePlanElementEnum.Personnel:
                            var group = colPlanHRExpenseGroup.ElementAt(cbExpenseGroup.SelectedIndex);
                            var tariff = colPlanHRTariff.ElementAt(cbTariff.SelectedIndex);

                            PlanElementHR hr = new PlanElementHR();
                            hr.New();
                            hr.idPlanInstance = instance.Id;
                            hr.idExpenseGroup = group.Id;
                            hr.idTariff = tariff.Id;
                            hr.CommitChanges();
                            break;
                        case TypePlanElementEnum.Purchase:
                        case TypePlanElementEnum.Sale:
                            PlanElementContract contract = new PlanElementContract();
                            contract.New();
                            contract.idPlanInstance = instance.Id;
                            contract.PaymentTerm = 0;
                            contract.Price = 0;
                            contract.idAccountMain = selectedDebitAccount.Id;
                            contract.CommitChanges();
                            break;
                    }

                    OnRaiseItemUpdated();

                    this.Close();
                    var nextwnd = new PlanItemEdit(instance);
                    nextwnd.Show();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Unerwarteter Fehler beim Anlegen eines Planelementes", "Fehler", MessageBoxButton.OK, MessageBoxImage.Error);
            }

        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void cbElementType_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbElementType.SelectedIndex == -1)
            {
                spAccountMain.Visibility = Visibility.Visible;
                spAccountCredit.Visibility = Visibility.Visible;
                lbAccountMain.Content = "Konto Soll:";
            }
            else
            {
                switch ((TypePlanElementEnum)colElementTypes.ElementAt(cbElementType.SelectedIndex).TypeCode)
                {
                    case TypePlanElementEnum.BookingRule:
                        spAccountMain.Visibility = Visibility.Visible;
                        spAccountCredit.Visibility = Visibility.Visible;
                        spTariff.Visibility = Visibility.Collapsed;
                        spExpenseGroup.Visibility = Visibility.Collapsed;
                        lbAccountMain.Content = "Konto Soll:";
                        break;
                    case TypePlanElementEnum.Personnel:
                        spAccountMain.Visibility = Visibility.Collapsed;
                        spAccountCredit.Visibility = Visibility.Collapsed;
                        spTariff.Visibility = Visibility.Visible;
                        spExpenseGroup.Visibility = Visibility.Visible;
                        break;
                    case TypePlanElementEnum.Purchase:
                    case TypePlanElementEnum.Sale:
                        spAccountMain.Visibility = Visibility.Visible;
                        spAccountCredit.Visibility = Visibility.Collapsed;
                        spTariff.Visibility = Visibility.Collapsed;
                        spExpenseGroup.Visibility = Visibility.Collapsed;
                        lbAccountMain.Content = "Buchungskonto:";
                        break;
                }
            }
        }

        public event EventHandler<PlanElementInstance> ItemUpdated;

        protected virtual void OnRaiseItemUpdated()
        {
            // Raise event if event handler is set (i.e. not null)
            ItemUpdated?.Invoke(this, instance);
        }

        private void btnAccountCreditSelect_Click(object sender, RoutedEventArgs e)
        {

        }

    }
}
