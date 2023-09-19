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

namespace VerumDesk.GUI.BookingRunGUI
{
    /// <summary>
    /// Interaction logic for ChangeStatus.xaml
    /// </summary>
    public partial class ChangeStatus : Window
    {
        BookingRun b;
        public ChangeStatus(BookingRun b)
        {
            InitializeComponent();
            this.b = b;
            if (b.StatusPreliminary) tbMessage.Text = "Status auf \"final\" setzen?";
            else tbMessage.Text = "Status auf \"vorläufig\" setzen?";
        }

        private void btnJa_Click(object sender, RoutedEventArgs e)
        {
            b.StatusPreliminary = !b.StatusPreliminary;
            this.Close();
        }

        private void btnAbbrechen_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
