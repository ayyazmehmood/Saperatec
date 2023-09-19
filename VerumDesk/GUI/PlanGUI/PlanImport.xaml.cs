using System;
using System.Windows;
using VerumDesk.Controller;
using VerumBusinessObjects.Framework;
using VerumBusinessObjects;
using System.Windows.Forms;
using System.Collections.ObjectModel;
using System.Linq;

namespace VerumDesk.GUI
{
    /// <summary>
    /// Interaktionslogik für PlanImport.xaml
    /// </summary>
    public partial class PlanImport : Window
    {
        PlanImportFromXLS _Import = new PlanImportFromXLS();
        public PlanImport()
        {
            InitializeComponent();
            InitTabElement();
            txtFilename.Text = VerumInstance.User.DataImportFolder;
            txtClientName.Text = VerumInstance.Client.TitleClient;
            txtPlanGuid.Text = "{00000004-0000-0000-0000-000000000000}";

        }

        ObservableCollection<Plan> colPlan;


        private void InitTabElement()
        {
            // init reference group combo box
            colPlan = Plan.GetBOCollection().GetObservableCollection();
            cbPlan.ItemsSource = colPlan.Select(i => $"{i.TitlePlan}");
            //cbPlan.SelectedIndex = colPlan.IndexOf(colPlan.FirstOrDefault(b => b.Id == item.idReferenceGroup));
        }

        private void btnSelectFile_Click(object sender, RoutedEventArgs e)
        {
            System.Windows.Forms.OpenFileDialog obj = new System.Windows.Forms.OpenFileDialog();
            obj.Title = "Importdatei auswählen.";
            obj.FileName = txtFilename.Text;
            obj.CheckFileExists = true;
            obj.DefaultExt = "*.xlsx";
            DialogResult result = obj.ShowDialog();

            if (result == System.Windows.Forms.DialogResult.OK )
            {
                txtFilename.Text = obj.FileName;
                VerumInstance.User.DataImportFolder = obj.FileName;
                VerumInstance.User.CommitChanges(true);
            }
        }

        /*private void cmdImportPlanFromXLS_Click(object sender, RoutedEventArgs e)
        {
            if (_Import.OpenImportFile(txtFilename.Text, txtImportTrace))
            {
                if (Guid.TryParse(txtPlanGuid.Text, out Guid planGuid))
                {
                    if (_Import.ImportPlanFromExcel(planGuid, txtImportTrace) == BOResult.Success)
                    {
                        DialogResult dialogResult = System.Windows.Forms.MessageBox.Show("Aktualisieren aller Elemente erzwingen?", "Plan aktualisieren", MessageBoxButtons.YesNoCancel);
                        if (!(dialogResult == System.Windows.Forms.DialogResult.Cancel))
                        {
                            Plan plan = new Plan(planGuid);

                            try
                            {
                                if (plan != null)
                                {
                                    plan.CommitChanges();

                                    var wnd = new PlanUpdateInProgress();
                                    wnd.Show();
                                    if(dialogResult == System.Windows.Forms.DialogResult.Yes) plan.ImplementPlan(true);
                                    else plan.ImplementPlan(false);
                                    wnd.Close();
                                    System.Windows.MessageBox.Show("Buchungen anlegen erfolgreich abgeschlossen.", "Plan buchen", MessageBoxButton.OK, MessageBoxImage.Information);
                                }
                            }
                            catch (Exception)
                            {
                                System.Windows.MessageBox.Show("Unerwarteter Fehler beim Anlegen der Buchungen.", "Plan buchen", MessageBoxButton.OK, MessageBoxImage.Error);
                            }
                        }
                        //VerumCommands.PlanImplement.Execute("", ManageSession.mainWindow);
                    } 
                }
                else
                    System.Windows.MessageBox.Show("Ungültiger Schlüssel für Zugriff auf Plan");
            }
            else System.Windows.Forms.MessageBox.Show($"Fehler beim Öffnen der Importdatei {txtFilename.Text}.");

        }*/

        private void cmdImportPlanFromXLS_Click(object sender, RoutedEventArgs e)
        {
            //Fabian - 28.04.2023

            if (_Import.OpenImportFile(txtFilename.Text, txtImportTrace))

            {

                if (Guid.TryParse(txtPlanGuid.Text, out Guid planGuid))

                {

                    if (_Import.ImportPlanFromExcel(planGuid, txtImportTrace) == BOResult.Success)

                    {

                        DialogResult dialogResult = System.Windows.Forms.MessageBox.Show("Plan aktualisieren?", "", MessageBoxButtons.YesNo);

                        if (dialogResult == System.Windows.Forms.DialogResult.Yes)

                        {

                            Plan plan = new Plan(planGuid);



                            try

                            {

                                if (plan != null)

                                {

                                    plan.CommitChanges();



                                    var wnd = new PlanUpdateInProgress();

                                    wnd.Show();

                                    plan.ImplementPlan(false);

                                    wnd.Close();

                                    System.Windows.MessageBox.Show("Buchungen anlegen erfolgreich abgeschlossen.", "Plan buchen", MessageBoxButton.OK, MessageBoxImage.Information);

                                }

                            }

                            catch (Exception)

                            {

                                System.Windows.MessageBox.Show("Unerwarteter Fehler beim Anlegen der Buchungen.", "Plan buchen", MessageBoxButton.OK, MessageBoxImage.Error);

                            }

                        }

                        //VerumCommands.PlanImplement.Execute("", ManageSession.mainWindow);

                    }

                }

                else

                    System.Windows.MessageBox.Show("Ungültiger Schlüssel für Zugriff auf Plan");

            }

            else System.Windows.Forms.MessageBox.Show($"Fehler beim Öffnen der Importdatei {txtFilename.Text}.");



        }

        private void cmdCancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void cmdImportClientFromXLS_Click(object sender, RoutedEventArgs e)
        {
            if (_Import.OpenImportFile(txtFilename.Text))
                _Import.ImportClientFromExcel(txtImportTrace);

            else System.Windows.Forms.MessageBox.Show($"Fehler beim Öffnen der Importdatei {txtFilename.Text}.");

        }

        private void cbPlan_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            if (cbPlan.SelectedItem != null) txtPlanGuid.Text = colPlan.ElementAt(cbPlan.SelectedIndex).Id.ToString();
            //else txtPlanGuid.Text = "";
        }

        private void txtPlanGuid_TextChanged(object sender, System.Windows.Controls.TextChangedEventArgs e)
        {
            Plan selected = colPlan.Where(x => x.Id.ToString() == txtPlanGuid.Text).FirstOrDefault();
            //if (selected != null) 
            cbPlan.SelectedIndex = colPlan.IndexOf(selected);

        }
    }
}
