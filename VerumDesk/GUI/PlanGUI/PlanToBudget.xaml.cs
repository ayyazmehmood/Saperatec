using System;
using System.Collections.Generic;
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
    /// Interaktionslogik für PlanToBudget.xaml
    /// Determines the start and end date of the budgeting period and triggers controller to create budget
    /// </summary>
    public partial class PlanToBudget : Window
    {
        Plan budgetPlan;

        public PlanToBudget(Plan plan)
        {
            MessageBoxResult result = MessageBoxResult.Yes;

            InitializeComponent();
            budgetPlan = plan;

            if ((TypePlanStatusEnum)plan.TypeStatus == TypePlanStatusEnum.Baseline)
            {
                result = MessageBox.Show("Dieser Plan ist bereits budgetiert. Wollen Sie dennoch fortsetzen?", "Plan budgetieren", MessageBoxButton.YesNo, MessageBoxImage.Question);
            }

            if (result == MessageBoxResult.Yes)
                this.DataContext = plan;
            else
                this.Close();
        }

        private void cmdExecute_Click(object sender, RoutedEventArgs e)
        {
            if (!(budgetPlan == null) && (budgetPlan.Bound))
            {
                if (budgetPlan.ToBudget(FromDate.SelectedDate, ToDate.SelectedDate,
                    cbFlagReplace.IsChecked.GetValueOrDefault(),
                    cbFlagForecast.IsChecked.GetValueOrDefault()) != BOResult.Success)
                    MessageBox.Show("Fehler beim budgetieren des ausgewählten Plans.", "Plan budgetieren", MessageBoxButton.OK, MessageBoxImage.Error);
                    
                OnRaiseDone();
                this.Close();
            }
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        public event EventHandler<Plan> PlanDone;

        protected virtual void OnRaiseDone()
        {
            // Raise event if event handler is set (i.e. not null)
            PlanDone?.Invoke(this, budgetPlan);
        }


    }
}
