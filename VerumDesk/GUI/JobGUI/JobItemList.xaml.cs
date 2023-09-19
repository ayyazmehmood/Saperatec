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

namespace VerumDesk.GUI.Job
{
    /// <summary>
    /// Interaktionslogik für JobItemList.xaml
    /// </summary>
    public partial class JobItemList : Window
    {
        private BOCollection<JobReportItem, tJobReportItem> BOColl;
        private ObservableCollection<JobReportItem> listItems;
        private JobReport job;

        public JobItemList(JobReport job)
        {
            InitializeComponent();
            this.job = job;
            ListUpdate();
        }

        private void btnOpen_Click(object sender, RoutedEventArgs e)
        {

        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void ListUpdate()
        {
            BOColl = JobReportItem.GetBOCollection(job);

            listItems = new ObservableCollection<JobReportItem>();

            foreach (var BO in BOColl)
                listItems.Add(BO);

            dgMain.ItemsSource = listItems;
            dgMain.Items.SortDescriptions.Clear();
        }

    }
}
