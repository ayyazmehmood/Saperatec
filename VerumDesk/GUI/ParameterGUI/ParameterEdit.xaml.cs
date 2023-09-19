using System;
using System.Windows;
using VerumBusinessObjects;
using System.Collections.Generic;

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für ParameterEdit.xaml
    /// </summary>
    public partial class ParameterEdit : Window
    {
        PlanParameter item;

        public ParameterEdit(Guid idPlan)
        {
            item = new PlanParameter();
            item.New();
            item.idPlan = idPlan;
            item.TypePlanParameter = -1;
            item.ValueDate = DateTime.Today;

            InitializeWindow();
        }

        public ParameterEdit(TypePlanParameterEnum partype, Guid idPlan, string title = "")
        {
            item = new PlanParameter();
            item.New();
            item.TypePlanParameter = (short)partype;
            item.idPlan = idPlan;
            item.ValueDate = DateTime.Today;
            item.TitlePlanParameter = title;

            InitializeWindow();
        }

        public ParameterEdit(PlanParameter item)
        {
            this.item = item;
            InitializeWindow();
        }

        private void InitializeWindow()
        {
            InitializeComponent();
            this.DataContext = item;

            var typeSel = new List<TypeSelector>();
            typeSel.Add(new TypeSelector((short)TypePlanParameterEnum.ContingencyRate, "Reservefaktor"));
            typeSel.Add(new TypeSelector((short)TypePlanParameterEnum.PriceFactor, "Preisfaktor"));
            typeSel.Add(new TypeSelector((short)TypePlanParameterEnum.TriggerDate, "Datum"));
            cbType.ItemsSource = typeSel;

            if (item.TypePlanParameter == -1)
            {
                cbType.IsEnabled = true;
                cbType.SelectedIndex = -1;
                dpValueDate.IsEnabled = false;
                tbUnit.IsEnabled = false;
                tbValueNum.IsEnabled = false;
            }
            else
            {
                cbType.IsEnabled = false;
                cbType.SelectedItem = typeSel.Find(b => b.TypeCode == item.TypePlanParameter);
                UpdateParType();
            }
        }

        private void UpdateParType()
        {

            switch ((TypePlanParameterEnum)item.TypePlanParameter)
            {
                case (TypePlanParameterEnum.ContingencyRate):
                    dpValueDate.IsEnabled = false;
                    tbUnit.IsEnabled = false;
                    tbValueNum.IsEnabled = true;
                    tbValueNum.FormatString = "P2";
                    break;

                case (TypePlanParameterEnum.PriceFactor):
                    dpValueDate.IsEnabled = false;
                    tbUnit.IsEnabled = true;
                    tbValueNum.IsEnabled = true;
                    tbValueNum.FormatString = "N2";
                    break;

                case (TypePlanParameterEnum.TriggerDate):
                    dpValueDate.IsEnabled = true;
                    tbUnit.IsEnabled = false;
                    tbValueNum.IsEnabled = false;
                    break;
            }
        }

        private void cmdOK_Click(object sender, RoutedEventArgs e)
        {

            if (tbTitle.Text.Trim() == "")
            {
                System.Windows.MessageBox.Show("Einem Parameter muss ein Titel zugewiesen werden.", "Parameter erstellen", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            try
            {
                item.CommitChanges();
                OnRaiseItemUpdated();
                this.Close();
            }
            catch (Exception ex)
            {
                System.Windows.MessageBox.Show("Unerwarteter Fehler beim Bearbeiten eines Parameters.", "Kostenstelle anlegen", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        public event EventHandler<PlanParameter> ItemUpdated;

        protected virtual void OnRaiseItemUpdated()
        {
            ItemUpdated?.Invoke(this, item);
        }

        private void cbType_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            item.TypePlanParameter = ((TypeSelector)cbType.SelectedItem).TypeCode;
            UpdateParType();
        }
    }
}