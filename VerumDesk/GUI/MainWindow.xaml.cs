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
using VerumDesk.Controller;

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            ManageSession.mainWindow = this;
            this.Closed += MainWindow_Closed;
        }

        void MainWindow_Closed(object sender, EventArgs e)
        {
            App.Current.Shutdown();
        }

        // *** Desktop Application Commands ***

        private void BookingRunImportCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e) { e.CanExecute = true; }
        private void BookingRunImportCommand_Executed(object sender, ExecutedRoutedEventArgs e) { var wnd = new ImportDATEVJournals(); wnd.Show(); }

        private void CostCenterListCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e) { e.CanExecute = true; }
        private void CostCenterListCommand_Executed(object sender, ExecutedRoutedEventArgs e) { var wnd = new CostCenterList(); wnd.Show(); }

        private void ExitCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e) { e.CanExecute = true; }
        private void ExitCommand_Executed(object sender, ExecutedRoutedEventArgs e) { Application.Current.Shutdown(); }

        private void JobListCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e) { e.CanExecute = true; }
        private void JobListCommand_Executed(object sender, ExecutedRoutedEventArgs e) { var wnd = new GUI.Job.JobList(); wnd.Show(); }

        private void PlanEditCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e) { e.CanExecute = true; }
        private void PlanEditCommand_Executed(object sender, ExecutedRoutedEventArgs e) { var wnd = new PlanSelect(); wnd.Show(); }

        private void PlanImplementCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e) { e.CanExecute = true; }
        private async void PlanImplementCommand_Executed(object sender, ExecutedRoutedEventArgs e) 
        {
            var obj = new Plan();
            obj.ProgressEvent += ProgressEventHandler;
            
            await Task.Run(() => obj.ImplementPlan());
            MessageBox.Show("Aktualisierung der Planung abgeschlossen","Planung aktualisieren ...");
        }

        private void UserAdminCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e)
        {
            if (VerumInstance.TypeCurrentUser == TypeUserEnum.Admin)
                e.CanExecute = true;
            else
                e.CanExecute = false;
        }
        private void UserAdminCommand_Executed(object sender, ExecutedRoutedEventArgs e) { var wnd = new UserAdmin(); wnd.Show(); }

        private void ReferenceCodeListCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e) { e.CanExecute = true; }
        private void ReferenceCodeListCommand_Executed(object sender, ExecutedRoutedEventArgs e) { var wnd = new ReferenceCodeList(); wnd.Show(); }

        private void ReferenceGroupListCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e) { e.CanExecute = true; }
        private void ReferenceGroupListCommand_Executed(object sender, ExecutedRoutedEventArgs e) { var wnd = new ReferenceGroupList(); wnd.Show(); }

        private void AccountListCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e) { e.CanExecute = true; }
        private void AccountListCommand_Executed(object sender, ExecutedRoutedEventArgs e) { var wnd = new AccountList(); wnd.Show(); }

        private void AccountGroupListCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e) { e.CanExecute = true; }
        private void AccountGroupListCommand_Executed(object sender, ExecutedRoutedEventArgs e) { var wnd = new AccountGroupList(); wnd.Show(); }

        private void AccountMainGroupListCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e) { e.CanExecute = true; }
        private void AccountMainGroupListCommand_Executed(object sender, ExecutedRoutedEventArgs e) { var wnd = new AccountMainGroupList(); wnd.Show(); }

        private void AccountSectionListCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e) { e.CanExecute = true; }
        private void AccountSectionListCommand_Executed(object sender, ExecutedRoutedEventArgs e) { var wnd = new AccountSectionList(); wnd.Show(); }

        private void BookingRunListCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e) { e.CanExecute = true; }
        private void BookingRunListCommand_Executed(object sender, ExecutedRoutedEventArgs e) { var wnd = new BookingRunList(); wnd.Show(); }

        private void DepreciationRuleListCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e) { e.CanExecute = true; }
        private void DepreciationRuleListCommand_Executed(object sender, ExecutedRoutedEventArgs e) { var wnd = new DepreciationRuleList(); wnd.Show(); }

        private void PlanImportCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e) { e.CanExecute = true; }
        private void PlanImportCommand_Executed(object sender, ExecutedRoutedEventArgs e) { var wnd = new PlanImport(); wnd.Show(); }


        private void ProgressEventHandler(object sender, PlanImplementationProgress e)
        {
            Dispatcher.BeginInvoke(new Action(() => { lblPlanImplementationProgress.Text = $"{e.ItemsRemaining}"; }));
        }

        private void CommandBinding_CanExecute(object sender, CanExecuteRoutedEventArgs e)
        {

        }

        
    }
}
