using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Forms;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using VerumBusinessObjects;
using VerumBusinessObjects.Framework;
using VerumBusinessObjects.Views;
using VerumDesk.Controller;

namespace VerumDesk.GUI.PlanGUI
{
    /// <summary>
    /// Interaction logic for ImportAllocationSchedule.xaml
    /// </summary>
    public partial class ImportAllocationSchedule : Window
    {
        PlanElementInstance elementInstance;
        public ImportAllocationSchedule(PlanElementInstance elementInstance)
        {
            this.elementInstance = elementInstance;
            InitializeComponent();
        }

        private void btnImport_Click(object sender, RoutedEventArgs e)
        {
            JobReport job = null;

            try
            {
                //if (objConn == null) throw new InvalidOperationException();

                job = new JobReport();
                //if (!job.StartJob(TypeJobEnum.JournalImport))
                //    return BOResult.JobReportingError;

                // Import sequence based on referential dependencies according to Cascade Sequence of Data Dictionary
                
                ImportPlanAllocationSchedule();
                ImportPlanAllocationScheduleItems();
                
                job.EndJob();

                //return BOResult.Success;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);

                if (job != null)
                {
                    job.Report(TypeJobSuccessEnum.Error, BOResult.GeneralError, "Plan Import from Excel", "", "Unexpected error during plan import from Excel. See tracing for further information.");
                    job.EndJob();
                }

                //return BOResult.GeneralError;
            }
        }

        private void btnSelectFile_Click(object sender, RoutedEventArgs e)
        {
            System.Windows.Forms.OpenFileDialog obj = new System.Windows.Forms.OpenFileDialog();
            obj.Title = "Importdatei auswählen.";
            obj.FileName = txtFilename.Text;
            obj.CheckFileExists = true;
            obj.DefaultExt = "*.xlsx";
            DialogResult result = obj.ShowDialog();

            if (result == System.Windows.Forms.DialogResult.OK)
            {
                txtFilename.Text = obj.FileName;
                VerumInstance.User.DataImportFolder = obj.FileName;
                VerumInstance.User.CommitChanges(true);
            }
        }
        private void ImportPlanAllocationSchedule()
        {
            const string table_name = "AllocationSchedule";
            string trace = "";
            int count = 0;
            var target = new PlanAllocationSchedule();
            var import = new PlanImportFromXLS();
            vPlanAllocationSchedule source;

            import.OpenImportFile(txtFilename.Text);
            var dataset = import.ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vPlanAllocationSchedule>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Title == null || source.Title == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        //target = new PlanAllocationSchedule();

                        if (!target.SelectViaKey(source.Title, elementInstance.idPlan))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        target.idPlan = elementInstance.idPlan;
                        target.TitleAllocationSchedule = source.Title;

                        if (Enum.IsDefined(typeof(TypeRegularPeriods), Convert.ToInt16(source.Months_per_Period)))
                            target.MonthsBetweenItems = source.Months_per_Period;
                        else
                            target.MonthsBetweenItems = 1;

                        target.PerpetualRate = source.Perpetual_Rate;
                        target.FlagScheduleShared = source.Flag_Shared;
                        target.FlagAbsoluteRates = source.Flag_Absolute_Rates;
                        target.AdvanceDelayPeriods = source.Advance_Delay;
                        target.FlagAuto = source.Auto_Generate;

                        if (source.Auto_Generate && source.Period_1.HasValue && source.Rate_1.HasValue)
                        {
                            target.Period1 = source.Period_1;
                            target.Rate1 = source.Rate_1;

                            if (source.Period_2.HasValue && source.Rate_2.HasValue && source.Period_2 > source.Period_1)
                            {
                                target.Period2 = source.Period_2;
                                target.Rate2 = source.Rate_2;

                                if (source.Period_3.HasValue && source.Rate_3.HasValue && source.Period_3 > source.Period_2)
                                {
                                    target.Period3 = source.Period_3;
                                    target.Rate3 = source.Rate_3;
                                }
                            }
                        }

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen der Importtabelle {table_name}, Eintrag: {source.Title}.\n";
                    }
                }

                //trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                //trace_listener.Text += trace;
            }
        }

        private void ImportPlanAllocationScheduleItems()
        {
            const string table_name = "AllocationScheduleItems";
            string trace = "";
            int count = 0;
            var target = new PlanAllocationScheduleItems();
            var import = new PlanImportFromXLS();
            vPlanAllocationScheduleItems source;

            var dataset = import.ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vPlanAllocationScheduleItems>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.TitleAllocationSchedule == null || source.TitleAllocationSchedule == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        //target = new PlanAllocationScheduleItems();

                        // Determine AllocationScheduleId first
                        var obj = new PlanAllocationSchedule();

                        if (!obj.SelectViaKey(source.TitleAllocationSchedule, elementInstance.idPlan))
                            throw new BOException($"Allocation Schedule Title not found on import of schedule items.", BOResult.AllocationScheduleTitleNotFound,
                                                    source.TitleAllocationSchedule);

                        // Skip if Schedule is set to auto generate
                        if (obj.FlagAuto) continue;

                        if (!target.GetViaOrderNum(obj.Id, source.OrderNum))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;

                            target.idPlanAllocationSchedule = obj.Id;
                        }

                        // *** import and validate table data ***
                        target.OrderNum = source.OrderNum;
                        target.ItemRate = source.ItemRate;

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen von {table_name} {source.TitleAllocationSchedule}.\n";
                    }
                }

                //trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                //trace_listener.Text += trace;
            }
        }
    }
}
