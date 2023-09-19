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

namespace VerumDesk.GUI.PlanGUI
{
    /// <summary>
    /// Interaction logic for AddRefCode.xaml
    /// </summary>
    public partial class AddRefCode : Window
    {

        PlanItemEdit planWindow;
        string code;

        public AddRefCode(string code, PlanItemEdit planWindow)
        {
            InitializeComponent();
            tbMessage.Text = "Der Buchungsschlüssel " + code + " wurde nicht gefunden. Soll der Buchungsschlüssel angelegt werden?";
            this.code = code;
            this.planWindow = planWindow;
        }

        private void btnJa_Click(object sender, RoutedEventArgs e)
        {
            var wnd = new ReferenceCodeEdit(code, planWindow);
            this.Close();
            wnd.ShowDialog();           
        }

        private void btnAbbrechen_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
