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

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für PlanNew.xaml
    /// </summary>
    public partial class PlanNew : Window
    {
        Plan plan = new Plan();

        public PlanNew()
        {
            InitializeComponent();
            plan.New();

            plan.DateValidFrom = DateTime.Today;
            plan.DateValidTo = new DateTime(DateTime.Today.Year + 1, 12, 31);
            plan.TypeStatus = (short)TypePlanStatusEnum.New;
            this.DataContext = plan;
        }

        private void cmdAdd_Click(object sender, RoutedEventArgs e)
        {
            plan.CommitChanges();
            OnRaisePlanCreated();
            this.Close();
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        public event EventHandler<Plan> PlanCreated;

        protected virtual void OnRaisePlanCreated()
        {
            // Raise event if event handler is set (i.e. not null)
            PlanCreated?.Invoke(this, plan);
        }


    }
}
