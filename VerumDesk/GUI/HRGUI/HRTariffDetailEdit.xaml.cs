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
using System.Collections.ObjectModel;
using Xceed.Wpf.Toolkit;

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für HRTariffDetailEdit.xaml
    /// </summary>
    public partial class HRTariffDetailEdit : Window
    {
        public PlanHRTariffDetail item;

        /// <summary>
        /// Constructor for new tariff detail
        /// </summary>
        /// <param name="Tariff"></param>
        public HRTariffDetailEdit(PlanHRTariff tariff, PlanHRTariffDetail sourceDetail = null)
        {
            if (sourceDetail == null)
            {
                item = new PlanHRTariffDetail();
                item.New();
                item.idTariff = tariff.Id;
                item.FTEFactor = 1;
                item.StandardHolidays = 10;
                item.WorkTimeWeekly = 40;
                item.AnnualLeave = 30;
            }
            else
            {
                item = new PlanHRTariffDetail();
                item.Clone(sourceDetail);
                item.idTariff = tariff.Id;
            }

            Init();
        }

        public HRTariffDetailEdit(PlanHRTariffDetail item)
        {
            this.item = item;
            Init();
        }

        void Init()
        {
            DataContext = item;
            InitializeComponent();
        }

        private void cmdOK_Click(object sender, RoutedEventArgs e)
        {
            item.CommitChanges();
            Close();
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

    }
}
