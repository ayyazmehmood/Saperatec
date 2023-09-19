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
    /// Interaktionslogik für PlanToForcast.xaml
    /// Determines the start and end date of the forecasting period and triggers controller to create forecast
    /// </summary>
    public partial class PlanToForecast : Window
    {
        Plan forecastPlan;

        public PlanToForecast(Plan plan)
        {
            InitializeComponent();
            forecastPlan = plan;
            this.DataContext = plan;
        }

        private void cmdExecute_Click(object sender, RoutedEventArgs e)
        {
            if (!(forecastPlan == null) && (forecastPlan.Bound))
            {
                if (forecastPlan.ToForecast(FromDate.SelectedDate, ToDate.SelectedDate, 
                    cbFlagReplace.IsChecked.GetValueOrDefault()) != BOResult.Success)
                    MessageBox.Show("Fehler beim Erstellen des Forecasts.", "Plan Forecast", MessageBoxButton.OK, MessageBoxImage.Error);

                OnRaiseDone();
                this.Close();
            }
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        public event EventHandler<Plan> PlanForecastDone;

        protected virtual void OnRaiseDone()
        {
            // Raise event if event handler is set (i.e. not null)
            PlanForecastDone?.Invoke(this, forecastPlan);
        }


    }
}
