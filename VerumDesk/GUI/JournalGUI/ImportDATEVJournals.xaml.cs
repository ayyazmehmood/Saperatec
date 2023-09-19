using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.IO;
using System.Windows.Forms;
using VerumDesk.Controller;
using VerumBusinessObjects.Framework;
using VerumBusinessObjects.Views;
using VerumBusinessObjects;

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für BookingRecordImport.xaml
    /// </summary>
    public partial class ImportDATEVJournals : Window
    {
        DATEVImport controller;

        public ImportDATEVJournals()
        {
            InitializeComponent();
            txtImportFolder.Text = VerumInstance.User.DATEVImportFolder;

            // Check whether client includes a DATEV Client Number
            if (!VerumInstance.Client.DATEVClientNumber.HasValue)
            {
                txtResult.Text = "Ihrem Mandaten wurde bisher keine DATEV Mandantennummer zugewiesen. Ein Buchungsimport ist daher nicht möglich.";
                txtResult.Visibility = Visibility.Visible;
                cmdImportFiles.IsEnabled = false;
            }
        }

        private void btnSelectFolder_Click(object sender, RoutedEventArgs e)
        {
            System.Windows.Forms.FolderBrowserDialog obj = new System.Windows.Forms.FolderBrowserDialog();
            obj.RootFolder = Environment.SpecialFolder.MyComputer;
            obj.Description = "Importordner auswählen.";
            obj.SelectedPath = txtImportFolder.Text;
            DialogResult result = obj.ShowDialog();

            if (result == System.Windows.Forms.DialogResult.OK)
            {
                txtImportFolder.Text = obj.SelectedPath;
                VerumInstance.User.DATEVImportFolder = obj.SelectedPath;
                VerumInstance.User.CommitChanges(true);
            }
        }

        private void btnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private async void btnImportFiles_Click(object sender, RoutedEventArgs e)
        {
            BOResult result;

            try
            {
                controller = new DATEVImport();
                result = controller.SetImportFolder(txtImportFolder.Text);

                if (result == BOResult.Success)
                {
                    cmdClose.IsEnabled = false;
                    ctrlProgress.Maximum = controller.FileCount;
                    ctrlProgress.Visibility = Visibility.Visible;
                    controller.ProgressEvent += ProgressEventHandler;

                    result = await Task.Run(() => controller.ImportFolder());
                }

                switch (result)
                {
                    case BOResult.Success:
                        txtResult.Text = "DATEV Journal Import erfolgreich abgeschlossen.\n";
                        break;
                    case BOResult.GeneralError:
                        txtResult.Text = "DATEV Journal Import mit unerwartetem Fehler abgeschlossen. Weitere Informationen im Fehlerprotokoll.";
                        break;
                    case BOResult.GeneralWarning:
                        txtResult.Text = "DATEV Journal Import mit Warnungen abgeschlossen. Weitere Informationen im Job Report.\n";
                        break;
                    case BOResult.JobReportingError:
                        txtResult.Text = "Fehler beim Job Reporting. Der Vorgang wird abgebrochen.";
                        break;
                    case BOResult.ExcelInvalidFolderName:
                        txtResult.Text = "Der angegebene Importpfad kann nicht gefunden werden.";
                        break;
                    case BOResult.ExcelEmptyFolder:
                        txtResult.Text = "Der angegebene Importpfad enthält keine Dateien mit den Endungen .xlsx oder .xlsm.";
                        break;
                    case BOResult.DATEVClientNumberNotDefined:
                        txtResult.Text = "Ihrem Mandanten wurde noch keine DATEV Mandantennummer zugeordnet. Der Import von DATEV Journalen ist daher nicht möglich.";
                        break;
                    default:
                        txtResult.Text = "DATEV Journal Import mit unerwartetem Ergebnis abgeschlossen.";
                        break;
                }
                JobReport r = JobReport.GetBOCollection().GetObservableCollection().LastOrDefault();
                foreach (var item in JobReportItem.GetBOCollection(r))
                {
                    txtResult.Text += $">{item.Message}\n";
                }
                txtResult.Visibility = Visibility.Visible;
                cmdClose.IsEnabled = true;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex);
                txtResult.Text = "Unerwarteter Fehler beim Import. Vorgang abgebrochen.";
                txtResult.Visibility = Visibility.Visible;
                cmdClose.IsEnabled = true;
            }
        }

        private void ProgressEventHandler(object sender, JobProgress e)
        {
            Dispatcher.BeginInvoke(new Action(() => { ctrlProgress.Value = e.ItemsComplete; }));
        }

    }
}
