using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using VerumDesk.Controller;
using VerumDesk.GUI;

namespace VerumDesk
{
    /// <summary>
    /// Interaktionslogik für "App.xaml"
    /// </summary>
    public partial class App : Application
    {
        public App()
        {
        }

        private void Application_Startup(object sender, StartupEventArgs e)
        {
            if (e.Args.Length == 3 && e.Args[2] == "debug")
                ManageSession.LogonUser(e.Args[0], e.Args[1], VerumDesk.Properties.Settings.Default.DBConnectionTest);
                //ManageSession.LogonUser(e.Args[0], e.Args[1], "Server = localhost\\SQLEXPRESS; Database = VerumProdBackup; Trusted_Connection = True;");

            else if (e.Args.Length == 3 && e.Args[2] == "develop") 
                ManageSession.LogonUser(e.Args[0], e.Args[1], VerumDesk.Properties.Settings.Default.DBConnectionDevelop);
            else if (e.Args.Length >= 2) 
                ManageSession.LogonUser( e.Args[0], e.Args[1], VerumDesk.Properties.Settings.Default.DBConnectionProduction);


            if (ManageSession.Session == null || !ManageSession.Session.SessionActive)
            {
                LogonDialog logonDialog = new LogonDialog();
                logonDialog.ShowDialog();
            }

            if (ManageSession.Session != null && ManageSession.Session.SessionActive)
            {
                MainWindow mw = new MainWindow();
                mw.Show();
            }
            else this.Shutdown();
        }

        private void Application_Exit(object sender, ExitEventArgs e)
        {
            try
            {
                if (ManageSession.Session != null) ManageSession.Session.TerminateSession();
            }
            catch { }
        }
    }
}
