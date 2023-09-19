using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.OleDb;
using System.Data;
using VerumBusinessObjects;
using VerumBusinessObjects.Framework;
using VerumBusinessObjects.Views;
using System.Windows.Controls;
using System.Diagnostics;
using System.Data.Entity.Core.Objects.DataClasses;
using System.Windows;
using System.ComponentModel;
using DocumentFormat.OpenXml.Spreadsheet;

namespace VerumDesk.Controller
{
    internal class PlanImportFromXLS
    {
        OleDbConnection objConn;

        ~PlanImportFromXLS()
        {
            try
            {
                if (objConn != null) objConn.Close();
            }
            catch { }
        }

        internal bool ImportClientFromExcel(TextBox trace)
        {
            try
            {
                if (objConn == null) throw new InvalidOperationException();

                // Import sequence based on referential dependancies according to Cascade Sequence of Data Dictionary
                ImportCurrency(trace);
                ImportClient(trace);
                ImportTypeGroupDef(trace);
                ImportTypeCodeDef(trace);
                ImportUser(trace);
                ImportAccountSection(trace);
                ImportAccountMainGroup(trace);
                ImportAccountGroup(trace);
                ImportAccount(trace);
                ImportPlanAccountFunction(trace);
                ImportCostCenter(trace);
                ImportReferenceGroup(trace);
                ImportPlan(trace);
                ImportPlanGroup(trace);
                ImportCurrencyExchangeRate(trace);

                return true;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                return false;
            }
        }

        internal BOResult ImportPlanFromExcel(Guid idPlan, TextBox trace)
        {
            JobReport job = null;

            try
            {
                if (objConn == null) throw new InvalidOperationException();

                job = new JobReport();
                if (!job.StartJob(TypeJobEnum.JournalImport))
                    return BOResult.JobReportingError;

                // Import sequence based on referential dependencies according to Cascade Sequence of Data Dictionary
                ImportDepreciationRule(job);
                ImportVATRule(trace);
                ImportReferenceCode(trace);
                ImportPlanInflationRule(idPlan, trace);
                ImportCurrencyExchangeRate(trace, idPlan);
                ImportPlanParameterContingency(idPlan, trace);
                ImportPlanParameterPrice(idPlan, trace);
                ImportPlanParameterDate(idPlan, trace);
                ImportPlanAllocationSchedule(idPlan, trace);
                ImportPlanAllocationScheduleItems(idPlan, trace);
                ImportPlanHRTariff(idPlan, trace);
                ImportPlanHRTariffDetail(idPlan, trace);
                ImportPlanHRExpenseGroup(idPlan, trace);
                ImportPlanHRExpense(idPlan, trace);
                ImportPlanElementContract(idPlan, trace);
                ImportPlanElementBooking(idPlan, trace);
                ImportPlanElementHR(idPlan, trace);

                job.EndJob();

                return BOResult.Success;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);

                if (job != null)
                { 
                    job.Report(TypeJobSuccessEnum.Error, BOResult.GeneralError, "Plan Import from Excel", "", "Unexpected error during plan import from Excel. See tracing for further information.");
                    job.EndJob();
                }

            return BOResult.GeneralError;
            }
        }

        internal bool OpenImportFile(string filename, TextBox trace_listener = null)
        {
            try
            {
                // Create connection string variable. 
                String sConnectionString = $"Provider=Microsoft.ACE.OLEDB.12.0; Data Source={filename}; Extended Properties=Excel 12.0 Xml; Mode=Share Deny None";

                // Create connection object by using the preceding connection string.
                objConn = new OleDbConnection(sConnectionString);

                // Open connection with the database.
                objConn.Open();

                return true;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);

                if (trace_listener != null)
                    trace_listener.Text += ex.ToString();

                return false;
            }
        }

        public DataSet ReadExcelTable(string sheetName)
        {
            // The code to follow uses a SQL SELECT command to display the data from the worksheet.

            // Create new OleDbDataAdapter that is used to build a DataSet
            // based on the preceding SQL SELECT statement.
            OleDbDataAdapter objAdapter1 = new OleDbDataAdapter($"select * from [{sheetName}$]", objConn);

            // Create new DataSet to hold information from the worksheet.
            DataSet objDataset1 = new DataSet();

            try
            {
                // Fill the DataSet with the information from the worksheet.
                objAdapter1.Fill(objDataset1);

                return objDataset1;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);

                return null;
            }
        }

        private void ImportAccount(TextBox trace_listener)
        {
            const string table_name = "Account";
            string trace = "";
            int count = 0;
            var target = new Account();
            vAccountPlanning source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name }\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vAccountPlanning>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Code < 0) continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        var group = new AccountGroup();
                        if (!group.SelectViaKey(source.Group))
                        {
                            trace += $"Warnung: Ungültige Kontengruppe (AccountGroup) {source.Group} für Konto {source.Code}.\n";
                            continue;
                        }

                        var mainGroup = new AccountMainGroup();
                        mainGroup.Id = group.idAccountMainGroup.Value;

                        target = new Account();

                        if (!target.SelectViaKey(source.Code))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        target.idAccountGroup = group.Id;
                        target.idAccountMainGroup = mainGroup.Id;
                        target.idAccountSection = mainGroup.idAccountSection;
                        target.AccountCode = source.Code;

                        if (source.Title_local != null && source.Title_local != "")
                            target.TitleLocalAccount = source.Title_local;

                        if (source.Title_english != null && source.Title_english != "")
                            target.TitleEnglishAccount = source.Title_english;

                        if (Enum.IsDefined(typeof(TypeAccountEnum), source.Type))
                            target.TypeAccount = source.Type;
                        else
                            trace += $"Ungültiger Code als Kontoart (Type) übergeben: {source.Type}.\n";

                        target.FlagPlan = source.Planning;

                        //if (source.Group != null && source.Group != "")
                        //{
                        //    var obj = new AccountGroup();
                        //    if (obj.SelectViaKey(source.Group))
                        //        target.idAccountGroup = obj.Id;
                        //    else
                        //        trace += $"Warnung: Ungültige Kontengruppe (AccountGroup) {source.Group} für Konto {source.Code}.\n";
                        //}

                        if (source.Report_Account.HasValue)
                        {
                            var obj = new Account();
                            if (obj.SelectViaKey(source.Report_Account.Value))
                                target.idAccountReporting = obj.Id;
                            else
                                trace += $"Warnung: Ungültiges Konto als Berichtskonto {source.Report_Account} für Konto {source.Code}.\n";
                        }

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen von {table_name} {source.Code}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportAccountGroup(TextBox trace_listener)
        {
            const string table_name = "AccountGroup";
            string trace = "";
            int count = 0;
            var target = new AccountGroup(); 
            vAccountGroup source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vAccountGroup>(dataRow);

                    // do not read empty rows
                    if (source.Title_Local == null || source.Title_Local == "") continue;

                    try
                    {
                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        var mainGroup = new AccountMainGroup();

                        if (!mainGroup.SelectViaKey(source.Title_Main_Group))
                        {
                            trace += $"Hauptgruppentitel (AccountMainGroup) ungültig {source.Title_Main_Group}.\n";
                            continue;
                        }

                        target = new AccountGroup();

                        if (!target.SelectViaKey(source.Title_Local))
                        {
                            target.New();
                        }

                        // *** import and validate table data ***
                        target.idAccountMainGroup = mainGroup.Id;
                        target.TitleLocalAccountGroup = source.Title_Local;
                        target.TitleEnglishAccountGroup= source.Title_English;
                        target.AccountCodeFrom = source.Code_From;
                        target.AccountCodeTo = source.Code_To;
                        target.TypeAccountDefault = source.Default_Type;

                        if (source.Default_Reporting_Account.HasValue)
                        {
                            var account = new Account();
                            if (!account.SelectViaKey(source.Default_Reporting_Account.GetValueOrDefault()))
                            {
                                trace += $"Es wurde kein gültiges Berichtskonto (Default Reporting Account) gefunden.\n";
                                continue;
                            }
                            else
                                target.idAccountReportingDefault = account.Id;
                        }
                        else
                            target.idAccountReportingDefault = null;

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen der Importtabelle {table_name}, Eintrag: {source.Title_Local}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportAccountMainGroup(TextBox trace_listener)
        {
            const string table_name = "AccountMainGroup";
            string trace = "";
            int count = 0;
            var target = new AccountMainGroup();
            vAccountMainGroup source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vAccountMainGroup>(dataRow);

                    // do not read empty rows
                    if (source.Title_Local == null || source.Title_Local == "") continue;

                    try
                    {
                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        var section = new AccountSection();

                        if (!section.SelectViaKey(source.Title_Section))
                        { 
                            trace += $"Abschnittstitel (AccountSection) ungültig {source.Title_Section}.\n";
                            continue;
                        }

                        target = new AccountMainGroup();

                        if (!target.SelectViaKey(source.Title_Local))
                        {
                            target.New();
                        }

                        // *** import and validate table data ***
                        target.idAccountSection = section.Id;
                        target.TitleLocalMainGroup = source.Title_Local;
                        target.TitleEnglishMainGroup = source.Title_English;
                        target.MainGroupOrder = source.Main_Group_Order;

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen der Importtabelle {table_name}, Eintrag: {source.Title_Local}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportAccountSection(TextBox trace_listener)
        {
            const string table_name = "AccountSection";
            string trace = "";
            int count = 0;
            var target = new AccountSection();
            vAccountSection source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vAccountSection>(dataRow);

                    // do not read empty rows
                    if (source.Title_Local == null || source.Title_Local == "") continue;

                    try
                    {
                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new AccountSection();

                        if (!target.SelectViaKey(source.Title_Local))
                        {
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;
                            target.New();
                        }

                        // *** import and validate table data ***
                        target.TitleLocalSection = source.Title_Local;
                        target.TitleEnglishSection = source.Title_English;
                        target.SectionOrder = source.Section_Order;

                        if (Enum.IsDefined(typeof(TypeAccountEnum), source.Type_Account))
                            target.TypeAccount = source.Type_Account;
                        else
                            trace += $"Ungültiger Code als Kontoart (Type) übergeben: {source.Type_Account}.\n";

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen der Importtabelle {table_name}, Eintrag: {source.Title_Local}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportClient(TextBox trace_listener)
        {
            const string table_name = "Client";
            string trace = "";
            int count = 0;
            var target = new Client();
            vClient source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vClient>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Title == null || source.Title == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new Client();

                        if (!target.SelectViaKey(source.Title))
                        {
                            if (source.Id == null || source.Id == Guid.Empty) target.New();
                            else target.Id = source.Id;
                        }

                        // Establish foreign keys
                        // Currency
                        if (source.Currency_Code != null && source.Currency_Code != "")
                        {
                            var obj = new Currency();
                            if (obj.SelectViaKey(source.Currency_Code))
                                target.idCurrencyClient = obj.Id;
                            else
                                trace += $"Warnung: Ungültige Währung (Currency Code) {source.Currency_Code} für Client {source.Title}.\n";
                        }

                        // *** import and validate table data ***
                        target.TitleClient = source.Title;
                        target.FlagTemplate = source.Flag_Template;
                        target.StartOfBusinessYear = source.Start_of_Business_Year;
                        target.DATEVClientNumber = source.DATEVClientNumber;

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen von {table_name} {source.Title}.\n";
                    }

                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportCostCenter(TextBox trace_listener)
        {
            const string table_name = "CostCenter";
            string trace = "";
            int count = 0;
            var target = new CostCenter();
            vCostCenter source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vCostCenter>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Code == null || source.Code == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new CostCenter();

                        if (!target.SelectViaKey(source.Code))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        target.CostCenterCode = source.Code;
                        target.TitleCostCenter = source.Title_Local;
                        target.TitleEnglishCostCenter= source.Title_English;
                        target.idClient = VerumInstance.IdClient;
                        target.FlagProfitCenter = source.Flag_Profit_Center;
                        target.DescriptionCostCenter = source.Description;

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen der Importtabelle {table_name}, Eintrag: {source.Title_Local}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportCurrency(TextBox trace_listener)
        {
            const string table_name = "Currency";
            string trace = "";
            int count = 0;
            var target = new Currency();
            vCurrency source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vCurrency>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Code == null || source.Code == "") continue;

                        // check client or plan as applicable

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new Currency();

                        if (!target.SelectViaKey(source.Code))
                        {
                            if (source.Id == null || source.Id == Guid.Empty) target.New();
                            else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        target.CurrencyCode = source.Code;
                        target.TitleCurrency = source.Title;

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen von {table_name} {source.Code}.\n";
                    }

                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportCurrencyExchangeRate(TextBox trace_listener, Guid? idPlan = null)
        {
            const string table_name = "CurrencyExchangeRate";
            string trace = "";
            int count = 0;
            var target = new CurrencyExchangeRate();
            Plan plan = new Plan();
            Guid idCurrency;
            vCurrencyExchangeRate source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vCurrencyExchangeRate>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Currency_Code == null || source.Currency_Code == "") continue;
                        else
                        {
                            var obj = new Currency();
                            if (obj.SelectViaKey(source.Currency_Code))
                                idCurrency = obj.Id;
                            else
                            {
                                trace += $"Warning: Ungültiger Währungscode {source.Currency_Code}. Eintrag: {source.Currency_Code} am {source.Date.Date}, Plan {source.Plan_Title}. Eintrag nicht importiert\n";
                                continue;
                            }
                        }

                        // Determine whether exchange rate is assigned to a plan
                        // Find plan if a plan title is given and check validity
                        if (source.Plan_Title != null && source.Plan_Title != "")
                            if (!plan.SelectViaKey(source.Plan_Title))
                            {
                                trace += $"Warning: Ungültiger Plantitel {source.Plan_Title}. Eintrag: {source.Currency_Code} am {source.Date.Date}. Eintrag nicht importiert\n";
                                continue;
                            }

                        // if import runs in load client mode, import exchange rates for all plan ids
                        if (idPlan == null)
                        {
                            if (plan.Bound)
                                idPlan = plan.Id;
                        }
                        else
                            if (plan == null || idPlan != plan.Id)
                        {
                            trace += $"Information: Wechselkurs {source.Currency_Code} am {source.Date.Date} für abweichenden Plan wird ignoriert.\n";
                            continue;
                        }

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        if (!target.SelectViaKey(idCurrency, source.Date, idPlan))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        target.idCurrencyExchangeRate = idCurrency;
                        target.idPlan = idPlan;
                        target.DateExchangeRate = source.Date.Date;
                        target.RatePerClientCurrency = source.Rate;

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen der Importtabelle {table_name}, Eintrag: {source.Currency_Code} am {source.Date.Date}, Plan {source.Plan_Title}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportDepreciationRule(JobReport job)
        {
            const string table_name = "DepreciationRule";
            string trace = "";
            int count = 0;
            var target = new DepreciationRule();
            vDepreciationRule source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name }\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vDepreciationRule>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Title == null || source.Title == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new DepreciationRule();

                        if (!target.SelectViaKey(source.Title))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        target.idClient = VerumInstance.IdClient;
                        target.TitleDepreciationRule = source.Title;
                        target.NumberOfPeriods = source.Periods;

                        if (source.Months_per_Period > 0) target.PeriodInMonths = source.Months_per_Period;
                        else target.PeriodInMonths = 1;

                        if (Enum.IsDefined(typeof(TypeDepreciationRuleEnum), source.Type))
                            target.TypeDepreciationRule = source.Type;
                        else
                        {
                            job.Report(TypeJobSuccessEnum.Warning, BOResult.PlanImportInvalidDepreciationType, Properties.Resources.PlanImportJobTitle + table_name,
                                        source.Title, $"Warnung: Ungültiger Abschreibungstyp (Type) übergeben: {source.Type}. Weiter mit linearer Abschreibung als Standard.");
                            target.TypeDepreciationRule = (short)TypeDepreciationRuleEnum.Linear;
                        }

                        if (source.Account_Activation > 0)
                        {
                            var obj = new Account();
                            if (obj.SelectViaKey(source.Account_Activation))
                                target.idAccountActivation = obj.Id;
                            else
                            {
                                job.Report(TypeJobSuccessEnum.Error, BOResult.PlanImportInvalidActivationAccount, Properties.Resources.PlanImportJobTitle + table_name,
                                            source.Title, $"Fehler: Ungültiges Konto zur Aktivierung {source.Account_Activation}");
                                continue;
                            }
                        }
                        else
                        {
                            job.Report(TypeJobSuccessEnum.Error, BOResult.PlanImportInvalidActivationAccount, Properties.Resources.PlanImportJobTitle + table_name,
                                        source.Title, $"Fehler: Fehlendes Konto zur Aktivierung {source.Account_Activation}");
                            continue;
                        }

                        if (source.Account_Depreciation> 0)
                        {
                            var obj = new Account();
                            if (obj.SelectViaKey(source.Account_Depreciation))
                                target.idAccountDepreciation = obj.Id;
                            else
                                job.Report(TypeJobSuccessEnum.Error, BOResult.PlanImportInvalidActivationAccount, Properties.Resources.PlanImportJobTitle + table_name,
                                            source.Title, $"Warnung: Ungültiges Konto zur Abschreibung {source.Account_Depreciation}. Weiter ohne Abschreibungskonto.");
                        }

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        job.Report(TypeJobSuccessEnum.Error, BOResult.PlanImportDepreciationError, Properties.Resources.PlanImportJobTitle + table_name,
                                    source.Title, $"Fehler: Unbekanner Fehler beim Plan Import.");
                    }
                }

                job.Report(TypeJobSuccessEnum.Success, BOResult.Success, Properties.Resources.PlanImportJobTitle + table_name, $"{count} records", "Erfolg: Tabelle eingelesen.");
            }
        }

        private void ImportPlan(TextBox trace_listener)
        {
            const string table_name = "Plan";
            string trace = "";
            int count = 0;
            var target = new Plan();
            vPlan source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vPlan>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Title == null || source.Title == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        if (!target.SelectViaKey(source.Title))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;
                        }

                        // Resolve Foreign keys
                        // Base Plan
                        if (source.Title_Base_Plan != null && source.Title_Base_Plan != "")
                        {
                            var obj = new Plan();
                            if (obj.SelectViaKey(source.Title_Base_Plan))
                                target.idPlanBase = obj.Id;
                            else
                            {
                                trace += $"Error: Angabe eines ungültigen Basisplans {source.Title_Base_Plan} für Plan {source.Title}. Import abgebrochen.\n";
                                continue;
                            }
                        }

                        // *** import and validate table data ***
                        target.TitlePlan = source.Title;
                        target.DateValidFrom = source.Valid_From;
                        target.DateValidTo = source.Valid_To;
                        target.PlanFlagBaseline = source.Flag_Baseline;

                        if (Enum.IsDefined(typeof(TypePlanStatusEnum), source.Status))
                            target.TypeStatus = source.Status;
                        else
                            target.TypeStatus = (short)TypePlanStatusEnum.New;

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

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportPlanAccountFunction(TextBox trace_listener)
        {
            const string table_name = "PlanAccountFunction";
            string trace = "";
            int count = 0;
            var target = new PlanAccountFunction();
            vPlanAccountFunction source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name }\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vPlanAccountFunction>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Type <= 0) continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        if (!target.SelectViaKey(source.Type))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        if (Enum.IsDefined(typeof(TypeAccountFunctionEnum), (short)source.Type))
                            target.TypeAccountFunction = source.Type;
                        else
                        {
                            trace += $"Error: Ungültiger Type Code übergeben: {source.Type}. Import abgebrochen.\n";
                            continue;
                        }

                        if (source.Account_Code >= 0)
                        {
                            var obj = new Account();
                            if (obj.SelectViaKey(source.Account_Code))
                                target.idAccountPlanAccountFunction = obj.Id;
                            else
                            {
                                trace += $"Error: Ungültige Kontonummer (Account Code) {source.Account_Code} für Account Function {source.Type}. Import abgebrochen\n";
                                continue;
                            }
                        }
                        else
                        {
                            trace += $"Error: Fehlende Kontonummer (Account Code) für Account Function {source.Type}. Import abgebrochen\n";
                            continue;
                        }

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen von {table_name} {source.Type}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportPlanAllocationSchedule(Guid idPlan, TextBox trace_listener)
        {
            const string table_name = "AllocationSchedule";
            string trace = "";
            int count = 0;
            var target = new PlanAllocationSchedule();
            vPlanAllocationSchedule source;

            var dataset = ReadExcelTable(table_name);
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
                        target = new PlanAllocationSchedule();

                        if (!target.SelectViaKey(source.Title, idPlan))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        target.idPlan = idPlan;
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

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportPlanAllocationScheduleItems(Guid idPlan, TextBox trace_listener)
        {
            const string table_name = "AllocationScheduleItems";
            string trace = "";
            int count = 0;
            var target = new PlanAllocationScheduleItems();
            vPlanAllocationScheduleItems source;

            var dataset = ReadExcelTable(table_name);
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
                        target = new PlanAllocationScheduleItems();

                        // Determine AllocationScheduleId first
                        var obj = new PlanAllocationSchedule();

                        if (!obj.SelectViaKey(source.TitleAllocationSchedule, idPlan))
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

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportPlanElementBooking(Guid idPlan, TextBox trace_listener)
        {
            const string table_name = "PlanBooking";
            string trace = "";
            int count = 0;
            PlanElement planElement;
            PlanElementInstance planInstance;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace_listener.Text += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // PlanPurchase Eintrag einlesen
                    var source = ExcelImport.GetEntityFromXLS<vPlanElementBooking>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Title == null || source.Title == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        var planBooking = new PlanElementBooking();
                        planBooking.GetEntities(source.Id, source.Title, idPlan, out planElement, out planInstance, source.Cost_Center);

                        // *** Daten des Eintrages importieren und validieren ***

                        // Protect PlanElement settings which are shared across plans from update if element was used for baseline before
                        if (planElement.ElementFlagBaseline)
                            trace += $"Das Planelement {source.Title} wurde bereits für eine genehmigte Budgetplanung verwendet. Bestimmte Einstellungen können daher nicht mehr geändert werden\n";
                        else
                        {
                            // Check client and plan ids
                            if (planElement.idClient == Guid.Empty) planElement.idClient = VerumInstance.IdClient;
                            else if (planElement.idClient != VerumInstance.IdClient)
                            {
                                trace += $"Mandantennummer des Elements ist nicht korrekt.";
                                continue;
                            }

                            if (planInstance.idPlan == Guid.Empty) planInstance.idPlan = idPlan;
                            else if (planInstance.idPlan != idPlan)
                            {
                                trace += $"Die spezifierte ID der Instanz des Plan Elements gehört zu einem andren Plan.";
                                continue;
                            }

                            // Plan Group
                            var planGroup = new PlanGroup();
                            if (source.Plan_Group != null && !planGroup.SelectViaKey(source.Plan_Group))
                                trace += $"Plan Group {source.Plan_Group} wurde nicht gefunden. Plan Group bleibt frei.\n";
                            else
                                planElement.idPlanGroup = planGroup.Id;

                            // Title
                            planElement.TitlePlanElement = source.Title;

                            // Type
                            planElement.TypePlanElement = (short)TypePlanElementEnum.BookingRule;

                            // Cost Center
                            var costCenter = new CostCenter();
                            if (source.Cost_Center == null || source.Cost_Center == "")
                                planElement.idCostCenterPlanElement = null;
                            else if (!costCenter.SelectViaKey(source.Cost_Center))
                            {
                                trace += $"Cost Center {source.Cost_Center} wurde nicht gefunden. Import für Planelement {source.Title} wird abgebrochen.\n";
                                continue;
                            }
                            else
                                planElement.idCostCenterPlanElement = costCenter.Id;

                            // Reference Key
                            planElement.ReferenceIDPlanElement = source.Reference;
                        }

                        // Debit account
                        var accountDebit = new Account();
                        if (source.Debit_Account == 0 || !accountDebit.SelectViaKey(source.Debit_Account))
                        {
                            trace += $"Es wurde kein gültiges Sollkonto (Debit Account) definiert.\n";
                            continue;
                        }
                        else
                            planBooking.idAccountDebit = accountDebit.Id;

                        // Credit account
                        var accountCredit = new Account();
                        if (!source.Credit_Account.HasValue || !accountCredit.SelectViaKey(source.Credit_Account.Value))
                        {
                            trace += $"Es wurde kein gültiges Habenkonto (Credit Account) definiert.\n";
                            continue;
                        }
                        else
                            planBooking.idAccountCredit = accountCredit.Id;

                        // Price
                        planBooking.Price = source.Price;

                        // Currency
                        var currency = new Currency();
                        if (source.Currency != null && currency.SelectViaKey(source.Currency))
                            planElement.idCurrency = currency.Id;
                        else
                            planElement.idCurrency = null;

                        // Element Description - can also change when baseline
                        if (source.Description != "") planElement.PlanElementDescription = source.Description;

                        // DateOffset versus Absolute mode
                        planInstance.FlagDateOffset = source.Due_Offset.GetValueOrDefault();

                        // Determine base date and end date

                        // if Offset
                        if (planInstance.FlagDateOffset)
                        {
                            planInstance.DueDateDay = source.Due_Day.GetValueOrDefault();
                            planInstance.DueDateMonth = source.Due_Month.GetValueOrDefault();
                            planInstance.DueDateYear = source.Due_Year.GetValueOrDefault();

                            planInstance.UntilDateDay = source.Until_Day.GetValueOrDefault();
                            planInstance.UntilDateMonth = source.Until_Month.GetValueOrDefault();
                            planInstance.UntilDateYear = source.Until_Year.GetValueOrDefault();
                        }

                        // if absolute
                        else
                        {
                            if (BOUtilities.IsValidDate(source.Due_Year.GetValueOrDefault(), source.Due_Month.GetValueOrDefault(), source.Due_Day.GetValueOrDefault()))
                            {
                                planInstance.DueDateDay = source.Due_Day.Value;
                                planInstance.DueDateMonth = source.Due_Month.Value;
                                planInstance.DueDateYear = source.Due_Year.Value;
                            }
                            else
                            {
                                planInstance.DueDateDay = 0;
                                planInstance.DueDateMonth = 0;
                                planInstance.DueDateYear = 0;
                            }

                            if (BOUtilities.IsValidDate(source.Until_Year.GetValueOrDefault(), source.Until_Month.GetValueOrDefault(), source.Until_Day.GetValueOrDefault()))
                            {
                                planInstance.UntilDateDay = source.Until_Day.Value;
                                planInstance.UntilDateMonth = source.Until_Month.Value;
                                planInstance.UntilDateYear = source.Until_Year.Value;
                            }
                            else
                            {
                                planInstance.UntilDateDay = 0;
                                planInstance.UntilDateMonth = 0;
                                planInstance.UntilDateYear = 0;
                            }
                        }

                        // Due Trigger
                        var parameter = new PlanParameter();
                        if (source.Due_Trigger != null && parameter.SelectViaKey(source.Due_Trigger, idPlan) && parameter.TypePlanParameter == (short)TypePlanParameterEnum.TriggerDate)
                            planInstance.idParTriggerDueDate = parameter.Id;
                        else if (source.Due_Trigger != "" && source.Due_Trigger != null)
                        {
                            trace_listener.Text += $"Ein angegebener Trigger für das Fälligkeitsdatum (Due Trigger) wurde nicht gefunden.\n";
                            planInstance.idParTriggerDueDate = null;
                        }
                        else
                            planInstance.idParTriggerDueDate = null;

                        // Repeat
                        if (!Enum.IsDefined(typeof(TypeRepeatEnum), source.Repeat))
                        {
                            trace += $"Ungültiger Wert zur Wiederholung (Repeat). Nur die Wert -1, 0, 1, 3, 6 und 12 sind gültig.\n";
                            planBooking.TypeRepeat = (short)TypeRepeatEnum.NoRepeat;
                        }
                        else
                            planBooking.TypeRepeat = source.Repeat;


                        // Schedule
                        if (source.Schedule != "" && source.Schedule != null)
                        {
                            var schedule = new PlanAllocationSchedule();
                            if (schedule.SelectViaKey(source.Schedule, idPlan))
                                planBooking.idAllocationSchedule = schedule.Id;
                            else
                                trace += $"Ein angegebener Verteilungsplan (Schedule) wurde nicht gefunden.\n";
                        }
                        else
                            planBooking.idAllocationSchedule = null;

                        // Units
                        if (source.Units > 0)
                            planBooking.NumberOfUnits = source.Units;
                        else
                            planBooking.NumberOfUnits = 1;

                        // Price Par 1
                        if (source.Price_Par_1 != "" && source.Price_Par_1 != null)
                        {
                            parameter = new PlanParameter();
                            if (parameter.SelectViaKey(source.Price_Par_1, idPlan) && parameter.TypePlanParameter == (short)TypePlanParameterEnum.PriceFactor)
                                planBooking.idParPrice1 = parameter.Id;
                            else
                            {
                                trace += $"Ein angegebener Preisparamter (Price Par 1) wurde nicht gefunden.\n";
                                planBooking.idParPrice1 = null;
                            }
                        }
                        else
                            planBooking.idParPrice1 = null;

                        // Price Par 2
                        if (source.Price_Par_2 != "" && source.Price_Par_2 != null)
                        {
                            parameter = new PlanParameter();
                            if (parameter.SelectViaKey(source.Price_Par_2, idPlan) && parameter.TypePlanParameter == (short)TypePlanParameterEnum.PriceFactor)
                                planBooking.idParPrice2 = parameter.Id;
                            else
                            {
                                trace += $"Ein angegebener Preisparamter (Price Par 2) wurde nicht gefunden.\n";
                                planBooking.idParPrice2 = null;
                            }
                        }
                        else
                            planBooking.idParPrice2 = null;

                        // Contingency Rule
                        if (source.Contingency_Rule != "" && source.Contingency_Rule != null)
                        {
                            parameter = new PlanParameter();
                            if (parameter.SelectViaKey(source.Contingency_Rule, idPlan) && parameter.TypePlanParameter == (short)TypePlanParameterEnum.ContingencyRate)
                                planBooking.idParContingencyRate = parameter.Id;
                            else
                            {
                                trace += $"Eine angegebene Contingency Regel wurde nicht gefunden.\n";
                                planBooking.idParContingencyRate = null;
                            }
                        }
                        else
                            planBooking.idParContingencyRate = null;

                        // Inflation Rule
                        if (source.Inflation_Rule != "" && source.Inflation_Rule != null)
                        {
                            var inflation = new PlanInflationRule();
                            if (inflation.SelectViaKey(source.Inflation_Rule, idPlan))
                                planBooking.idInflationRule = inflation.Id;
                            else
                            {
                                trace += $"Eine angegebene Inflationsregel (Inflation Rule) wurde nicht gefunden.\n";
                                planBooking.idInflationRule = null;
                            }
                        }
                        else
                            planBooking.idInflationRule = null;

                        // Price Date
                        if (source.Price_Date != null && source.Price_Date > DateTime.MinValue)
                            planBooking.PriceDate = source.Price_Date;

                        // Assumptions
                        if (source.Assumptions != "" && source.Assumptions != null)
                            planInstance.Assumptions = source.Assumptions;
                        else
                            planInstance.Assumptions = null;

                        // Revisions
                        if (source.Revisions != "" && source.Revisions != null)
                            planInstance.Revisions = source.Revisions;
                        else
                            planInstance.Revisions = null;

                        // Account Opening Booking flag
                        planBooking.FlagAccountOpening = source.Flag_Account_Opening;

                        bool flagChange = planElement.Changed || planInstance.Changed || planBooking.Changed;

                        try
                        {
                            // Commit Changes
                            VerumInstance.TransactionStart();
                            planElement.CommitChanges();
                            VerumInstance.SaveChanges(true);
                            planInstance.CommitChanges();
                            VerumInstance.SaveChanges(true);
                            planBooking.CommitChanges();
                            VerumInstance.TransactionEnd();
                        }
                        catch (Exception ex)
                        {
                            VerumInstance.TransactionRollback();
                            throw (ex);
                        }

                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace_listener.Text += $"Fehler beim Einlesen der Tabelle {table_name}, Element: {source.Title}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportPlanElementContract(Guid idPlan, TextBox trace_listener)
        {
            const string table_name = "PlanContract";
            string trace = "";
            int count = 0;
            PlanElement planElement;
            PlanElementInstance planInstance;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace_listener.Text += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // PlanContract Eintrag einlesen
                    var source = ExcelImport.GetEntityFromXLS<vPlanElementContract>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Title == null || source.Title == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        var planContract = new PlanElementContract();
                        planContract.GetEntities(source.Id, source.Title, idPlan, out planElement, out planInstance, source.Cost_Center);

                        // *** Daten des Eintrages importieren und validieren ***

                        // Protect PlanElement settings which are shared across plans from update if element was used for baseline before
                        if (planElement.ElementFlagBaseline)
                            trace += $"Das Planelement {source.Title} wurde bereits für eine genehmigte Budgetplanung verwendet. Bestimmte Einstellungen können daher nicht mehr geändert werden\n";
                        else
                        {
                            // Check client and plan ids
                            if (planElement.idClient == Guid.Empty) planElement.idClient = VerumInstance.IdClient;
                            else if (planElement.idClient != VerumInstance.IdClient)
                            {
                                trace += $"Mandantennummer des Elements ist nicht korrekt.";
                                continue;
                            }

                            if (planInstance.idPlan == Guid.Empty) planInstance.idPlan = idPlan;
                            else if (planInstance.idPlan != idPlan)
                            {
                                trace += $"Die spezifierte ID der Instanz des Plan Elements gehört zu einem andren Plan.";
                                continue;
                            }

                            // Plan Group
                            var planGroup = new PlanGroup();
                            if (source.Plan_Group != null && !planGroup.SelectViaKey(source.Plan_Group))
                                trace += $"Plan Group {source.Plan_Group} wurde nicht gefunden. Plan Group bleibt frei.\n";
                            else
                                planElement.idPlanGroup = planGroup.Id;

                            // Title
                            planElement.TitlePlanElement = source.Title;

                            // Type
                            if (source.Type_Select == "Purchase")
                                planElement.TypePlanElement = (short)TypePlanElementEnum.Purchase;
                            else
                                planElement.TypePlanElement = (short)TypePlanElementEnum.Sale;

                            // Cost Center
                            var costCenter = new CostCenter();
                            if (source.Cost_Center == null || source.Cost_Center == "")
                                planElement.idCostCenterPlanElement = null;
                            else if (!costCenter.SelectViaKey(source.Cost_Center))
                            {
                                trace += $"Cost Center {source.Cost_Center} wurde nicht gefunden. Import für Planelement {source.Title} wird abgebrochen.\n";
                                continue;
                            }
                            else
                                planElement.idCostCenterPlanElement = costCenter.Id;

                            // Reference Key
                            planElement.ReferenceIDPlanElement = source.Reference;
                        }

                        // Main transaction account
                        var accountMain = new Account();
                        if (!accountMain.SelectViaKey(source.Account))
                        {
                            trace += $"Es wurde kein gültiges Aufwandskonto (Cost Account) definiert.\n";
                            continue;
                        }
                        else
                            planContract.idAccountMain = accountMain.Id;

                        // Price
                        planContract.Price = source.Price;

                        // Currency
                        var currency = new Currency();
                        if (source.Currency != null && currency.SelectViaKey(source.Currency))
                            planElement.idCurrency = currency.Id;
                        else
                            planElement.idCurrency = null;

                        // Element Description - can also change when baseline
                        if (source.Description != "") 
                            planElement.PlanElementDescription = source.Description;

                        // DateOffset versus Absolute mode
                        planInstance.FlagDateOffset = source.Due_Offset.GetValueOrDefault();

                        // Determine base date and end date

                        // if Offset
                        if (planInstance.FlagDateOffset)
                        {
                            planInstance.DueDateDay = source.Due_Day.GetValueOrDefault();
                            planInstance.DueDateMonth = source.Due_Month.GetValueOrDefault();
                            planInstance.DueDateYear = source.Due_Year.GetValueOrDefault();

                            planInstance.UntilDateDay = source.Until_Day.GetValueOrDefault();
                            planInstance.UntilDateMonth = source.Until_Month.GetValueOrDefault();
                            planInstance.UntilDateYear = source.Until_Year.GetValueOrDefault();
                        }

                        // if absolute
                        else
                        {
                            if (BOUtilities.IsValidDate(source.Due_Year.GetValueOrDefault(), source.Due_Month.GetValueOrDefault(), source.Due_Day.GetValueOrDefault()))
                            {
                                planInstance.DueDateDay = source.Due_Day.Value;
                                planInstance.DueDateMonth = source.Due_Month.Value;
                                planInstance.DueDateYear = source.Due_Year.Value;
                            }
                            else
                            {
                                planInstance.DueDateDay = 0;
                                planInstance.DueDateMonth = 0;
                                planInstance.DueDateYear = 0;
                            }

                            if (BOUtilities.IsValidDate(source.Until_Year.GetValueOrDefault(), source.Until_Month.GetValueOrDefault(), source.Until_Day.GetValueOrDefault()))
                            {
                                planInstance.UntilDateDay = source.Until_Day.Value;
                                planInstance.UntilDateMonth = source.Until_Month.Value;
                                planInstance.UntilDateYear = source.Until_Year.Value;
                            }
                            else
                            {
                                planInstance.UntilDateDay = 0;
                                planInstance.UntilDateMonth = 0;
                                planInstance.UntilDateYear = 0;
                            }
                        }

                        // Due Trigger
                        var parameter = new PlanParameter();
                        if (source.Due_Trigger != null && parameter.SelectViaKey(source.Due_Trigger, idPlan) && parameter.TypePlanParameter == (short)TypePlanParameterEnum.TriggerDate)
                            planInstance.idParTriggerDueDate = parameter.Id;
                        else if (source.Due_Trigger != "" && source.Due_Trigger != null)
                        {
                            trace_listener.Text += $"Ein angegebener Trigger für das Fälligkeitsdatum (Due Trigger) wurde nicht gefunden.\n";
                            planInstance.idParTriggerDueDate = null;
                        }
                        else
                            planInstance.idParTriggerDueDate = null;

                        // Repeat
                        if (!Enum.IsDefined(typeof(TypeRepeatEnum), source.Repeat))
                        {
                            trace += $"Ungültiger Wert zur Wiederholung (Repeat). Nur die Wert -1, 0, 1, 3, 6 und 12 sind gültig.\n";
                            planContract.TypeRepeat = (short)TypeRepeatEnum.NoRepeat;
                        }
                        else
                            planContract.TypeRepeat = source.Repeat;

                        // Schedule
                        if (source.Schedule != "" && source.Schedule != null)
                        {
                            var schedule = new PlanAllocationSchedule();
                            if (schedule.SelectViaKey(source.Schedule, idPlan))
                                planContract.idAllocationSchedule = schedule.Id;
                            else
                                trace += $"Ein angegebener Verteilungsplan (Schedule) wurde nicht gefunden.\n";
                        }
                        else
                            planContract.idAllocationSchedule = null;

                        // VAT Rule
                        if (source.VAT_Rule != "" && source.VAT_Rule != null)
                        {
                            var vatrule = new VATRule();
                            if (vatrule.SelectViaKey(source.VAT_Rule))
                                planContract.idVATRule = vatrule.Id;
                            else
                            {
                                trace += $"Eine angegebene Umsatzsteuerregel (VAT Rule) wurde nicht gefunden.\n";
                                planContract.idVATRule = null;
                            }
                        }
                        else
                            planContract.idVATRule = null;

                        // Payment Term
                        planContract.PaymentTerm = source.Payment_Term;

                        // Advance Delay
                        planContract.AdvanceDelay = source.Advance_Delay;

                        // Advance account
                        var accountAdvance = new Account();
                        if (source.Advance_Account.HasValue && accountAdvance.SelectViaKey(source.Advance_Account.GetValueOrDefault()))
                            planContract.idAccountAdvance = accountAdvance.Id;
                        else if (source.Advance_Account.HasValue)
                        {
                            trace += $"Ein angegebenes Konto für Anzahlungen (Advance Account) ist nicht gültig.\n";
                            planContract.idAccountAdvance = null;
                        }
                        else
                            planContract.idAccountAdvance = null;

                        // Advance Trigger
                        parameter = new PlanParameter();
                        if (source.Advance_Trigger != null && parameter.SelectViaKey(source.Advance_Trigger, idPlan) && parameter.TypePlanParameter == (short)TypePlanParameterEnum.TriggerDate)
                            planContract.idParTriggerAdvance = parameter.Id;
                        else if (source.Advance_Trigger != "" && source.Advance_Trigger != null)
                        {
                            trace += $"Ein angegebener Trigger für die Umwandlung von Anzahlungen (Advance Trigger) wurde nicht gefunden.\n";
                            planContract.idParTriggerAdvance = null;
                        }
                        else
                            planContract.idParTriggerAdvance = null;

                        // Depreciation Rule (only for PlanElement type Purchase)
                        if (planElement.TypePlanElement == (short)TypePlanElementEnum.Purchase && source.Depreciation_Rule != "" && source.Depreciation_Rule != null)
                        {
                            var deprrule = new DepreciationRule();
                            if (deprrule.SelectViaKey(source.Depreciation_Rule))
                                planContract.idDepreciationRule = deprrule.Id;
                            else
                            {
                                trace += $"Eine angegebene Abschreibungsregel (Depreciation Rule) wurde nicht gefunden.\n";
                                planContract.idDepreciationRule = null;
                                planContract.DepreciationDelay = 0;
                                planContract.idDepreciationTrigger = null;
                            }

                            // Depreciation Delay
                            planContract.DepreciationDelay = source.Depreciation_Delay;

                            if (source.Depreciation_Start_Day != null)
                            {
                                planContract.DepreciationStartDay = source.Depreciation_Start_Day.GetValueOrDefault();
                                planContract.DepreciationStartMonth = source.Depreciation_Start_Month.GetValueOrDefault();
                                planContract.DepreciationStartYear = source.Depreciation_Start_Year.GetValueOrDefault();
                            }


                            // Depreciation Trigger
                            parameter = new PlanParameter();
                            if (source.Depreciation_Trigger != null && parameter.SelectViaKey(source.Depreciation_Trigger, idPlan) && parameter.TypePlanParameter == (short)TypePlanParameterEnum.TriggerDate)
                                planContract.idDepreciationTrigger = parameter.Id;
                            else if (source.Depreciation_Trigger != "" && source.Depreciation_Trigger != null)
                            {
                                trace += $"Ein angegebener Trigger für den Beginn von Abschreibungen (Depreciation Trigger) wurde nicht gefunden.\n";
                                planContract.idDepreciationTrigger = null;
                            }
                            else
                                planContract.idDepreciationTrigger = null;
                        }
                        else
                        {
                            planContract.idDepreciationRule = null;
                            planContract.DepreciationDelay = 0;
                            planContract.idDepreciationTrigger = null;
                        }

                        // Units
                        planContract.NumberOfUnits = source.Units;

                        // Price Par 1
                        if (source.Price_Par_1 != "" && source.Price_Par_1 != null)
                        {
                            parameter = new PlanParameter();
                            if (parameter.SelectViaKey(source.Price_Par_1, idPlan) && parameter.TypePlanParameter == (short)TypePlanParameterEnum.PriceFactor)
                                planContract.idParPrice1 = parameter.Id;
                            else
                            {
                                trace += $"Ein angegebener Preisparamter (Price Par 1) wurde nicht gefunden.\n";
                                planContract.idParPrice1 = null;
                            }
                        }
                        else
                            planContract.idParPrice1 = null;

                        // Price Par 2
                        if (source.Price_Par_2 != "" && source.Price_Par_2 != null)
                        {
                            parameter = new PlanParameter();
                            if (parameter.SelectViaKey(source.Price_Par_2, idPlan) && parameter.TypePlanParameter == (short)TypePlanParameterEnum.PriceFactor)
                                planContract.idParPrice2 = parameter.Id;
                            else
                            {
                                trace += $"Ein angegebener Preisparamter (Price Par 2) wurde nicht gefunden.\n";
                                planContract.idParPrice2 = null;
                            }
                        }
                        else
                            planContract.idParPrice2 = null;

                        // Contingency Rule
                        if (source.Contingency_Rule != "" && source.Contingency_Rule != null)
                        {
                            parameter = new PlanParameter();
                            if (parameter.SelectViaKey(source.Contingency_Rule, idPlan) && parameter.TypePlanParameter == (short)TypePlanParameterEnum.ContingencyRate)
                                planContract.idParContingencyRate = parameter.Id;
                            else
                            {
                                trace += $"Eine angegebene Contingency Regel wurde nicht gefunden.\n";
                                planContract.idParContingencyRate = null;
                            }
                        }
                        else
                            planContract.idParContingencyRate = null;

                        // Inflation Rule
                        if (source.Inflation_Rule != "" && source.Inflation_Rule != null)
                        {
                            var inflation = new PlanInflationRule();
                            if (inflation.SelectViaKey(source.Inflation_Rule, idPlan))
                                planContract.idInflationRule = inflation.Id;
                            else
                            {
                                trace += $"Eine angegebene Inflationsregel (Inflation Rule) wurde nicht gefunden.\n";
                                planContract.idInflationRule = null;
                            }
                        }
                        else
                            planContract.idInflationRule = null;

                        // Price Date
                        if (source.Price_Date != null && source.Price_Date > DateTime.MinValue)
                            planContract.PriceDate = source.Price_Date;

                        // Assumptions
                        if (source.Assumptions != "" && source.Assumptions != null)
                            planInstance.Assumptions = source.Assumptions;
                        else
                            planInstance.Assumptions = null;

                        // Revisions
                        if (source.Revisions != "" && source.Revisions != null)
                            planInstance.Revisions = source.Revisions;
                        else
                            planInstance.Revisions = null;

                        bool flagChange = planElement.Changed || planInstance.Changed || planContract.Changed;

                        try
                        {
                            // Commit Changes
                            VerumInstance.TransactionStart();
                            planElement.CommitChanges();
                            VerumInstance.SaveChanges(true);
                            planInstance.CommitChanges();
                            VerumInstance.SaveChanges(true);
                            planContract.CommitChanges();
                            VerumInstance.TransactionEnd();
                        }
                        catch (Exception ex)
                        {
                            VerumInstance.TransactionRollback();
                            throw (ex);
                        }

                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace_listener.Text += $"Fehler beim Einlesen der Tabelle {table_name}, Element: {source.Title}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportPlanElementHR(Guid idPlan, TextBox trace_listener)
        {
            const string table_name = "PlanHR";
            string trace = "";
            int count = 0;
            PlanElement planElement;
            PlanElementInstance planInstance;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace_listener.Text += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // PlanPurchase Eintrag einlesen
                    var source = ExcelImport.GetEntityFromXLS<vPlanElementHR>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Title == null || source.Title == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        var planItem = new PlanElementHR();
                        planItem.GetEntities(source.Id, source.Title, idPlan, out planElement, out planInstance, source.Cost_Center);

                        // *** Daten des Eintrages importieren und validieren ***

                        // Protect PlanElement settings which are shared across plans from update if element was used for baseline before
                        if (planElement.ElementFlagBaseline)
                            trace += $"Das Planelement {source.Title} wurde bereits für eine genehmigte Budgetplanung verwendet. Bestimmte Einstellungen können daher nicht mehr geändert werden\n";
                        else
                        {
                            // Check client and plan ids
                            if (planElement.idClient == Guid.Empty) planElement.idClient = VerumInstance.IdClient;
                            else if (planElement.idClient != VerumInstance.IdClient)
                            {
                                trace += $"Mandantennummer des Elements ist nicht korrekt.";
                                continue;
                            }

                            if (planInstance.idPlan == Guid.Empty) planInstance.idPlan = idPlan;
                            else if (planInstance.idPlan != idPlan)
                            {
                                trace += $"Die spezifierte ID der Instanz des Plan Elements gehört zu einem andren Plan.";
                                continue;
                            }

                            // Plan Group
                            var planGroup = new PlanGroup();
                            if (source.Plan_Group != null && !planGroup.SelectViaKey(source.Plan_Group))
                                trace += $"Plan Group {source.Plan_Group} wurde nicht gefunden. Plan Group bleibt frei.\n";
                            else
                                planElement.idPlanGroup = planGroup.Id;

                            // Title
                            planElement.TitlePlanElement = source.Title;

                            // Type
                            planElement.TypePlanElement = (short)TypePlanElementEnum.Personnel;

                            // Cost Center
                            var costCenter = new CostCenter();
                            if (source.Cost_Center == null || source.Cost_Center == "")
                                planElement.idCostCenterPlanElement = null;
                            else if (!costCenter.SelectViaKey(source.Cost_Center))
                            {
                                trace += $"Cost Center {source.Cost_Center} wurde nicht gefunden. Import für Planelement {source.Title} wird abgebrochen.\n";
                                continue;
                            }
                            else
                                planElement.idCostCenterPlanElement = costCenter.Id;

                            // Reference Key
                            planElement.ReferenceIDPlanElement = source.Reference;
                        }

                        // Element Description - can also change when baseline
                        if (source.Description != "") planElement.PlanElementDescription = source.Description;

                        // DateOffset versus Absolute mode
                        planInstance.FlagDateOffset = source.Due_Offset.GetValueOrDefault();

                        // Determine base date and end date

                        // if Offset
                        if (planInstance.FlagDateOffset)
                        {
                            planInstance.DueDateDay = source.Due_Day.GetValueOrDefault();
                            planInstance.DueDateMonth = source.Due_Month.GetValueOrDefault();
                            planInstance.DueDateYear = source.Due_Year.GetValueOrDefault();

                            planInstance.UntilDateDay = source.Until_Day.GetValueOrDefault();
                            planInstance.UntilDateMonth = source.Until_Month.GetValueOrDefault();
                            planInstance.UntilDateYear = source.Until_Year.GetValueOrDefault();
                        }

                        // if absolute
                        else
                        {
                            if (BOUtilities.IsValidDate(source.Due_Year.GetValueOrDefault(), source.Due_Month.GetValueOrDefault(), source.Due_Day.GetValueOrDefault()))
                            {
                                planInstance.DueDateDay = source.Due_Day.Value;
                                planInstance.DueDateMonth = source.Due_Month.Value;
                                planInstance.DueDateYear = source.Due_Year.Value;
                            }
                            else
                            {
                                planInstance.DueDateDay = 0;
                                planInstance.DueDateMonth = 0;
                                planInstance.DueDateYear = 0;
                            }

                            if (BOUtilities.IsValidDate(source.Until_Year.GetValueOrDefault(), source.Until_Month.GetValueOrDefault(), source.Until_Day.GetValueOrDefault()))
                            {
                                planInstance.UntilDateDay = source.Until_Day.Value;
                                planInstance.UntilDateMonth = source.Until_Month.Value;
                                planInstance.UntilDateYear = source.Until_Year.Value;
                            }
                            else
                            {
                                planInstance.UntilDateDay = 0;
                                planInstance.UntilDateMonth = 0;
                                planInstance.UntilDateYear = 0;
                            }
                        }

                        // Due Trigger
                        var parameter = new PlanParameter();
                        if (source.Due_Trigger != null && parameter.SelectViaKey(source.Due_Trigger, idPlan) && parameter.TypePlanParameter == (short)TypePlanParameterEnum.TriggerDate)
                            planInstance.idParTriggerDueDate = parameter.Id;
                        else if (source.Due_Trigger != "" && source.Due_Trigger != null)
                        {
                            trace_listener.Text += $"Ein angegebener Trigger für das Fälligkeitsdatum (Due Trigger) wurde nicht gefunden.\n";
                            planInstance.idParTriggerDueDate = null;
                        }
                        else
                            planInstance.idParTriggerDueDate = null;

                        // Inflation Rule
                        if (source.Inflation_Rule != "" && source.Inflation_Rule != null)
                        {
                            var inflation = new PlanInflationRule();
                            if (inflation.SelectViaKey(source.Inflation_Rule, idPlan))
                                planItem.idInflationRule = inflation.Id;
                            else
                            {
                                trace += $"Eine angegebene Inflationsregel (Inflation Rule) wurde nicht gefunden.\n";
                                planItem.idInflationRule = null;
                            }
                        }
                        else
                            planItem.idInflationRule = null;

                        // Currency
                        var currency = new Currency();
                        if (source.Currency != null && currency.SelectViaKey(source.Currency))
                            planElement.idCurrency = currency.Id;
                        else
                            planElement.idCurrency = null;

                        // Tariff
                        if (source.Tariff == null || source.Tariff == "")
                        {
                            trace_listener.Text += $"PlanElementHR {source.Title} ohne Angabe eines gültigen Tarifs. Element wird nicht eingelesen.\n";
                            continue;
                        }
                        else
                        {
                            var tariff = new PlanHRTariff();

                            if (tariff.SelectViaKey(source.Tariff, idPlan))
                                planItem.idTariff = tariff.Id;
                            else
                            {
                                trace_listener.Text += $"PlanElementHR {source.Title} ohne Angabe eines gültigen Tarifs. Element wird nicht eingelesen.\n";
                                continue;
                            }
                        }

                        // Expense Group
                        if (source.Expense_Group == null || source.Expense_Group == "")
                        {
                            trace_listener.Text += $"PlanElementHR {source.Title} ohne Angabe einer gültigen Nebenkostengruppe (Expense Group). Element wird nicht eingelesen.\n";
                            continue;
                        }
                        else
                        {
                            var expense = new PlanHRExpenseGroup();

                            if (expense.SelectViaKey(source.Expense_Group, idPlan))
                                planItem.idExpenseGroup = expense.Id;
                            else
                            {
                                trace_listener.Text += $"PlanElementHR {source.Title} ohne Angabe einer gültigen Nebenkostengruppe (Expense Group). Element wird nicht eingelesen.\n";
                                continue;
                            }
                        }

                        // Other specific fields
                        planItem.StaffName = source.Staff_Name;
                        planItem.Department = source.Department;

                        // Assumptions
                        if (source.Assumptions != "" && source.Assumptions != null)
                            planInstance.Assumptions = source.Assumptions;
                        else
                            planInstance.Assumptions = null;

                        // Revisions
                        if (source.Revisions != "" && source.Revisions != null)
                            planInstance.Revisions = source.Revisions;
                        else
                            planInstance.Revisions = null;

                        bool flagChange = planElement.Changed || planInstance.Changed || planItem.Changed;

                        try
                        {
                            // Commit Changes
                            VerumInstance.TransactionStart();
                            planElement.CommitChanges();
                            VerumInstance.SaveChanges(true);
                            planInstance.CommitChanges();
                            VerumInstance.SaveChanges(true);
                            planItem.CommitChanges();
                            VerumInstance.TransactionEnd();
                        }
                        catch (Exception ex)
                        {
                            VerumInstance.TransactionRollback();
                            throw (ex);
                        }

                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace_listener.Text += $"Fehler beim Einlesen der Tabelle {table_name}, Element: {source.Title}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportPlanGroup(TextBox trace_listener)
        {
            const string table_name = "PlanGroup";
            string trace = "";
            int count = 0;
            var target = new PlanGroup();
            vPlanGroup source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vPlanGroup>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Title_Local == null || source.Title_Local == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new PlanGroup();

                        if (!target.SelectViaKey(source.Title_Local))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        target.TitlePlanGroup = source.Title_Local;
                        target.TitleEnglishPlanGroup = source.Title_English;
                        target.idClient = VerumInstance.IdClient;
                        target.DescriptionPlanGroup = source.Description;

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen der Importtabelle {table_name}, Eintrag: {source.Title_Local}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportPlanHRExpenseGroup(Guid idPlan, TextBox trace_listener)
        {
            const string table_name = "PlanHRExpenseGroup";
            string trace = "";
            string entity_title;
            int count = 0;
            var target = new PlanHRExpenseGroup();
            vPlanHRExpenseGroup source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vPlanHRExpenseGroup>(dataRow);
                    entity_title = source.Title;

                    // do not read empty rows
                    if (entity_title == null || entity_title == "") continue;

                    try
                    {
                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new PlanHRExpenseGroup();

                        if (!target.SelectViaKey(entity_title, idPlan))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;

                            target.TitleExpenseGroup = entity_title;
                            target.idPlan = idPlan;
                        }

                        // *** import and validate table data ***
                        target.ExpenseGroupDescription = source.Description;
                        target.DateInflationBase = source.Inflation_Date;

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen der Importtabelle {table_name}, Eintrag: {entity_title}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportPlanHRExpense(Guid idPlan, TextBox trace_listener)
        {
            const string table_name = "PlanHRExpense";
            string trace = "";
            string entity_title;
            int count = 0;
            var target = new PlanHRExpense();
            vPlanHRExpense source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vPlanHRExpense>(dataRow);
                    entity_title = source.Expense_Title;

                    // do not read empty rows
                    if (source.Group_Title == null || source.Group_Title == "") continue;
                    if (entity_title == null || entity_title == "") continue;

                    try
                    {
                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new PlanHRExpense();

                        var expenseGroup = new PlanHRExpenseGroup();
                        if (source.Group_Title == "" || !expenseGroup.SelectViaKey(source.Group_Title, idPlan))
                        {
                            trace += $"Es wurde kein gültiges Nebenkostengruppe (Group Title) definiert.\n";
                            continue;
                        }

                        if (source.Valid_To.HasValue)
                        {
                            if (!target.SelectViaKey(entity_title, expenseGroup.Id, source.Valid_To.Value))
                            {
                                target.New();
                            }

                            target.TitleExpense = entity_title;
                            target.idExpenseGroup = expenseGroup.Id;
                        }
                        else
                        {
                            if (!target.SelectViaKey(entity_title, expenseGroup.Id))
                            {
                                target.New();
                            }

                            target.TitleExpense = entity_title;
                            target.idExpenseGroup = expenseGroup.Id;
                        }

                        // Expense account
                        var account = new Account();
                        if (source.Account_Code == 0 || !account.SelectViaKey(source.Account_Code))
                        {
                            trace += $"Es wurde kein gültiges Nebenkostenkonto (Account Code) definiert.\n";
                            continue;
                        }
                        else
                            target.idAccountExpense = account.Id;

                        // Optional cost center code
                        if (source.Fixed_Cost_Center_Code != null && source.Fixed_Cost_Center_Code != "")
                        {
                            var costCenter = new CostCenter();

                            if (costCenter.SelectViaKey(source.Fixed_Cost_Center_Code))
                                target.idCostCenterFixed = costCenter.Id;
                            else
                                trace += $"Ungültiger Cost Center Code angegeben {source.Fixed_Cost_Center_Code}.\n";
                        }

                        // *** import and validate table data ***
                        target.DateValidTo = source.Valid_To;
                        target.RatioToSalary = source.Ratio_to_Salary;
                        target.DeductFromSalary = source.Deduct_from_Salary;
                        target.ExpenseAmount = source.Expense_Amount;
                        target.SalaryCap = source.Salary_Cap;
                        target.Assumptions = source.Assumptions;

                        if (Enum.IsDefined(typeof(TypeBonusExpenseModeEnum), source.Bonus_Mode))
                            target.ApplyToBonusMode = source.Bonus_Mode;
                        else
                            trace += $"Ungültiger Bonus Mode (Type) übergeben: {source.Bonus_Mode}.\n";

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen der Importtabelle {table_name}, Eintrag: {entity_title}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportPlanHRTariff(Guid idPlan, TextBox trace_listener)
        {
            const string table_name = "PlanHRTariff";
            string trace = "";
            string entity_title;
            int count = 0;
            var target = new PlanHRTariff();
            vPlanHRTariff source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vPlanHRTariff>(dataRow);
                    entity_title = source.Title;

                    // do not read empty rows
                    if (entity_title == null || entity_title == "") continue;

                    try
                    {
                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new PlanHRTariff();

                        if (!target.SelectViaKey(entity_title, idPlan))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;

                            target.TitleTariff = entity_title;
                            target.idPlan = idPlan;
                        }

                        // Salary account
                        var account = new Account();
                        if (source.Account_Code == 0 || !account.SelectViaKey(source.Account_Code))
                        {
                            trace += $"Es wurde kein gültiges Gehaltskonto (Account Code) definiert.\n";
                            continue;
                        }
                        else
                            target.idAccountSalary = account.Id;

                        // *** import and validate table data ***
                        target.TariffDescription = source.Description;
                        target.PayDay = source.Pay_Day;
                        target.FlagShared = source.Flag_Shared;
                        target.DateInflationBase = source.Inflation_Date;

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen der Importtabelle {table_name}, Eintrag: {entity_title}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportPlanHRTariffDetail(Guid idPlan, TextBox trace_listener)
        {
            const string table_name = "PlanHRTariffDetail";
            string trace = "";
            int count = 0;
            var target = new PlanHRTariffDetail();
            vPlanHRTariffDetail source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vPlanHRTariffDetail>(dataRow);

                    // do not read empty rows
                    if (source.Tariff_Title == null || source.Tariff_Title == "") continue;
                    //if (source.Valid_To == null || source.Valid_To == DateTime.MinValue) continue;

                    try
                    {
                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new PlanHRTariffDetail();

                        var tariff = new PlanHRTariff();
                        if (source.Tariff_Title == "" || !tariff.SelectViaKey(source.Tariff_Title, idPlan))
                        {
                            trace += $"Es wurde kein gültiger Tarif (Tariff Title) definiert.\n";
                            continue;
                        }

                        // If Id is provided, try to retrieve record via Id
                        //if (source.Id != null && source.Id != Guid.Empty)
                        //    target.Id = source.Id;

                        // Try to retrieve via combination of tariff and valid to date
                        //else
                        //{
                            if (source.Valid_To.HasValue)
                            {
                                if (!target.GetViaValidTo(tariff.Id, source.Valid_To.Value))
                                {
                                    target.New();
                                }
                            }
                            else
                            {
                                if (!target.GetViaValidTo(tariff.Id))
                                {
                                    target.New();
                                }
                            }

                        //}

                        target.idTariff = tariff.Id;
                        if (source.Valid_To.HasValue) 
                            target.DateValidTo = source.Valid_To.Value.Date;

                        // *** import and validate table data ***
                        target.WorkTimeWeekly = source.Work_Hours_per_Week;
                        if (source.FTE_Factor > 0) target.FTEFactor = source.FTE_Factor;
                        target.RatioShiftNight = source.Ratio_Night_Shift;
                        target.RatioShiftSpecial = source.Ratio_Special_Shift;
                        target.RatioOvertime = source.Ratio_Overtime;
                        target.AnnualLeave = source.Annual_Days_Leave;
                        target.StandardHolidays = source.Annual_Holidays;
                        target.BaseSalaryMonthly = source.Base_Salary_per_Month;
                        target.RateShiftNight = source.Rate_Add_Night_Shift;
                        target.RateShiftSpecial = source.Rate_Add_Special_Shift;
                        target.RateOvertime = source.Rate_Overtime;
                        target.RateAnnualBonus = source.Rate_Annual_Bonus;
                        target.AnnualBonusMonth = source.Bonus_Month;

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen der Importtabelle {table_name}, Eintrag: {source.Tariff_Title}, Valid to {source.Valid_To}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportPlanInflationRule(Guid idPlan, TextBox trace_listener)
        {
            const string table_name = "InflationRule";
            string trace = "";
            int count = 0;
            var target = new PlanInflationRule();
            vPlanInflationRule source;

            var dataset = ReadExcelTable(table_name);
            if (dataset  == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vPlanInflationRule>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Title == null || source.Title == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new PlanInflationRule();

                        if (!target.SelectViaKey(source.Title, idPlan))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        target.idPlan = idPlan;
                        target.TitleInflationRule = source.Title;

                        if (Enum.IsDefined(typeof(TypeRegularPeriods), source.Interval_in_Months)) 
                            target.InflationInterval = source.Interval_in_Months;
                        else
                            target.InflationInterval = 1;

                        target.InflationRateAnnual = source.Rate_Annual;
                        target.InflationRuleComment = source.Description;

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

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportPlanParameterContingency(Guid idPlan, TextBox trace_listener)
        {
            const string table_name = "ContingencyRate";
            string trace = "";
            int count = 0;
            var target = new PlanParameter();
            vPlanParameterContingency source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vPlanParameterContingency>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Title == null || source.Title == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new PlanParameter();

                        if (!target.SelectViaKey(source.Title, idPlan))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        target.idPlan = idPlan;
                        target.TitlePlanParameter = source.Title;

                        target.TypePlanParameter = (short)TypePlanParameterEnum.ContingencyRate;
                        target.ValueNum = source.Rate;
                        target.PlanParameterComment = source.Description;

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

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportPlanParameterDate(Guid idPlan, TextBox trace_listener)
        {
            const string table_name = "TriggerDate";
            string trace = "";
            int count = 0;
            var target = new PlanParameter();
            vPlanParameterDate source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vPlanParameterDate>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Title == null || source.Title == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new PlanParameter();

                        if (!target.SelectViaKey(source.Title, idPlan))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        target.idPlan = idPlan;
                        target.TitlePlanParameter = source.Title;

                        target.TypePlanParameter = (short)TypePlanParameterEnum.TriggerDate;
                        target.ValueDate = source.Date;
                        target.PlanParameterComment = source.Description;

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

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportPlanParameterPrice(Guid idPlan, TextBox trace_listener)
        {
            const string table_name = "PriceFactor";
            string trace = "";
            int count = 0;
            var target = new PlanParameter();
            vPlanParameterPriceFactor source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vPlanParameterPriceFactor>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Title == null || source.Title == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new PlanParameter();

                        if (!target.SelectViaKey(source.Title, idPlan))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        target.idPlan = idPlan;
                        target.TitlePlanParameter = source.Title;

                        target.TypePlanParameter = (short)TypePlanParameterEnum.PriceFactor;
                        target.ValueNum = source.Value;
                        target.PlanParameterComment = source.Description;

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

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportReferenceCode(TextBox trace_listener)
        {
            const string table_name = "ReferenceCode";
            string trace = "";
            int count = 0;
            var target = new ReferenceCode();
            vReferenceCode source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name }\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vReferenceCode>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Code == null || source.Code == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new ReferenceCode();

                        if (!target.SelectViaKey(source.Code))
                        {
                            if (source.Id == null || source.Id == Guid.Empty) target.New();
                            else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        target.idClient = VerumInstance.IdClient;
                        target.RefCode = source.Code;
                        target.FlagActive = source.FlagActive;

                        if (source.Title != null && source.Title != "")
                            target.TitleRefCode = source.Title;

                        if (source.Description != null && source.Description != "")
                            target.RefCodeComment = source.Description;

                        if (source.Group != null && source.Group != "")
                        {
                            var obj = new ReferenceGroup();
                            if (obj.SelectViaKey(source.Group))
                                target.idReferenceGroup = obj.Id;
                            else
                                trace += $"Warnung: Ungültige Referenzgruppe (ReferenceGroup) {source.Group} für Referenz {source.Code}.\n";
                        }
                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen von {table_name} {source.Code}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportReferenceGroup(TextBox trace_listener)
        {
            const string table_name = "ReferenceGroup";
            string trace = "";
            int count = 0;
            var target = new ReferenceGroup();
            vReferenceGroup source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vReferenceGroup>(dataRow);

                    // do not read empty rows
                    if (source.Title == null || source.Title == "") continue;

                    try
                    {
                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 

                        if (!target.SelectViaKey(source.Title))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        target.TitleReferenceGroup = source.Title;
                        target.TypeReferenceGroup = source.Type;
                        target.BaseCode = source.Base_Code;
                        target.NextNum = source.Next_Num;
                        target.FlagAutoGen = source.Flag_Auto;
                        target.AutoDigits = source.Auto_Digits;

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

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportTypeGroupDef(TextBox trace_listener)
        {
            const string table_name = "TypeGroup";
            string trace = "";
            int count = 0;
            var target = new TypeGroupDef();
            vTypeGroupDef source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vTypeGroupDef>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.TypeGroupID == null || source.TypeGroupID == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new TypeGroupDef();

                        if (!target.SelectViaKey(source.TypeGroupID))
                        {
                            if (source.Id == null || source.Id == Guid.Empty) target.New();
                            else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        target.TypeGroupID = source.TypeGroupID;

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen von {table_name} {source.TypeGroupID}.\n";
                    }

                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportTypeCodeDef(TextBox trace_listener)
        {
            const string table_name = "TypeCode";
            string trace = "";
            int count = 0;
            var target = new TypeCodeDef();
            vTypeCodeDef source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vTypeCodeDef>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Type_ID == null || source.Type_ID == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 

                        if (!target.SelectViaKey(source.Type_ID))
                        {
                            if (source.Id == null || source.Id == Guid.Empty) target.New();
                            else target.Id = source.Id;
                        }

                        // Establish foreign keys
                        // TypeGroupDef
                        if (source.Group_ID != null && source.Group_ID != "")
                        {
                            var obj = new TypeGroupDef();
                            if (obj.SelectViaKey(source.Group_ID))
                                target.idTypeGroupDef = obj.Id;
                            else
                            {
                                trace += $"Warning: Ungültige Group ID {source.Group_ID} für TypeCode {source.Type_ID}. Cancel import.\n";
                                continue;
                            }
                        }
                        else
                        {
                            trace += $"Warning: Fehlende Group ID {source.Group_ID} für TypeCode {source.Type_ID}. Cancel import.\n";
                            continue;
                        }

                        // *** import and validate table data ***
                        target.TypeID = source.Type_ID;
                        target.TypeCode = source.Type_Code;

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen von {table_name} {source.Type_ID}.\n";
                    }

                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportUser(TextBox trace_listener)
        {
            const string table_name = "User";
            string trace = "";
            int count = 0;
            var target = new User();
            vUser source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name}\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vUser>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.User_Login == null || source.User_Login == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 

                        if (!target.SelectViaKey(source.User_Login))
                        {
                            if (source.Id == null || source.Id == Guid.Empty) target.New();
                            else target.Id = source.Id;
                        }

                        // Establish foreign keys
                        // Client
                        if (source.Client_Title != null && source.Client_Title != "")
                        {
                            var obj = new Client();
                            if (obj.SelectViaKey(source.Client_Title))
                                target.idClientDefault = obj.Id;
                            else
                            {
                                trace += $"Error: Ungültiger Mandant (Client Title) {source.Client_Title} für User {source.User_Login}. Import abgebrochen.\n";
                                continue;
                            }
                        }

                        // *** import and validate table data ***
                        target.UserName = source.User_Name;
                        target.UserLogin = source.User_Login;
                        target.UserPasswordHash = source.User_Password_Hash;
                        target.TypeUser = source.User_Type;
                        target.DATEVImportFolder = source.DATEVImportFolder;
                        target.DataImportFolder = source.DataImportFolder;

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen von {table_name} {source.User_Login}.\n";
                    }

                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

        private void ImportVATRule(TextBox trace_listener)
        {
            const string table_name = "VATRule";
            string trace = "";
            int count = 0;
            var target = new VATRule();
            vVATRule source;

            var dataset = ReadExcelTable(table_name);
            if (dataset == null || dataset.Tables.Count == 0) trace += $"Tabelle \'{table_name }\' wurde nicht gefunden.\n";
            else
            {
                // Read data into entity model
                foreach (DataRow dataRow in dataset.Tables[0].Rows)
                {
                    // Eintrag einlesen
                    source = ExcelImport.GetEntityFromXLS<vVATRule>(dataRow);

                    try
                    {
                        // do not read empty rows
                        if (source.Code == null || source.Code == "") continue;

                        // Zielobjekte zum Import anlegen und initialisieren, je nach dem, ob eine gültige Id definiert ist 
                        target = new VATRule();

                        if (!target.SelectViaKey(source.Code))
                        {
                            target.New();
                            //if (source.Id == null || source.Id == Guid.Empty) target.New();
                            //else target.Id = source.Id;
                        }

                        // *** import and validate table data ***
                        target.VATRuleCode = source.Code;
                        target.TitleVATRule = source.Title;
                        target.RateCurrent = source.Rate_Current;
                        if (source.Date_Rate_Change != null && source.Date_Rate_Change > DateTime.MinValue)  target.DateRateChange = source.Date_Rate_Change;
                        if (source.Rate_Future != null) target.RateFuture = source.Rate_Future;
                        target.SettlementTerm = source.Settlement_Term;
                        target.FlagReverseCharge = source.Flag_Reverse_Charge;

                        if (source.Account_VAT_In != null && source.Account_VAT_In > 0)
                        {
                            var obj = new Account();
                            if (obj.SelectViaKey(source.Account_VAT_In.Value))
                                target.idAccountVATInput = obj.Id;
                            else
                                trace += $"Warnung: Ungültiges Vorsteuerkonto {source.Account_VAT_In} für Umsatzsteuerregel {source.Code}.\n";
                        }

                        if (source.Account_VAT_Out != null && source.Account_VAT_Out > 0)
                        {
                            var obj = new Account();
                            if (obj.SelectViaKey(source.Account_VAT_Out.Value))
                                target.idAccountVATOutput = obj.Id;
                            else
                                trace += $"Warnung: Ungültiges Umsatzsteuerkonto {source.Account_VAT_Out} für Umsatzsteuerregel {source.Code}.\n";
                        }

                        if (source.Account_VAT_Settlement != null && source.Account_VAT_Settlement > 0)
                        {
                            var obj = new Account();
                            if (obj.SelectViaKey(source.Account_VAT_Settlement.Value))
                                target.idAccountVATBalance = obj.Id;
                            else
                                trace += $"Warnung: Ungültiges Umsatzsteuerausgleichskonto {source.Account_VAT_Settlement} für Umsatzsteuerregel {source.Code}.\n";
                        }

                        // Commit Changes
                        target.CommitChanges();
                        count++;
                    }
                    catch (Exception ex)
                    {
                        BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                        trace += $"Fehler beim Einlesen von {table_name} Umsatzsteuerregel {source.Code}.\n";
                    }
                }

                trace_listener.Text += $"{table_name}: {count} Einträg(e) eingelesen.\n";
                trace_listener.Text += trace;
            }
        }

    }
}
