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
using System.Windows.Navigation;
using System.Windows.Shapes;
using VerumBusinessObjects;
using VerumDesk.Controller;
using VerumBusinessObjects.Framework;

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für MainWindow.xaml
    /// </summary>
    public partial class LogonDialog : Window
    {
        public LogonDialog()
        {
            InitializeComponent();
        }

        private void cmdLogon_Click(object sender, RoutedEventArgs e)
        {
            string connection;
            VerumSession session = new VerumSession();

            switch (cbConnection.SelectedIndex)
            {
                case 0:
                    connection = VerumDesk.Properties.Settings.Default.DBConnectionProduction;
                    break;
                case 1:
                    connection = VerumDesk.Properties.Settings.Default.DBConnectionTest;
                    break;
                case 2:
                    connection = VerumDesk.Properties.Settings.Default.DBConnectionDevelop;
                    break;
                default:
                    connection = VerumDesk.Properties.Settings.Default.DBConnectionProduction;
                    break;
            }
             
            switch (ManageSession.LogonUser(txtLogonName.Text, txtPWD.Password, connection))
            {
                case BOResult.UserLogonSuccess:
                    DialogResult = true;
                    Close();
                    break;

                case BOResult.UserLoginInvalid:
                    MessageBox.Show("Ungültiger Anmeldename.");
                    break;

                case BOResult.UserLoginPasswordInvalid:
                    MessageBox.Show("Ungültiges Passwort.");
                    break;
                case BOResult.UserLoginAccessFailed:
                    MessageBox.Show("Zugriff auf Datenbank nicht möglich.");
                    break;
            }
        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            Close();
            App.Current.Shutdown();
        }
    }
}
