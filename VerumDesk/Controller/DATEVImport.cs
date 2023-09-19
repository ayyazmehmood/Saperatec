using System;
using System.Linq;
using System.IO;
using VerumBusinessObjects.Framework;
using VerumBusinessObjects.Views;
using VerumBusinessObjects;
using System.Collections.Generic;

namespace VerumDesk.Controller
{
    public class DATEVImport
    {
        public int FileCount
        {
            get
            {
                if (files == null) return 0;
                else
                    return files.Count();
            }
        }

        public BOResult SetImportFolder(string folderName)
        {
            try
            {
                // Acquire list of import files (only OpenXML formats xlsx and xlsm supported)
                directory = new DirectoryInfo(folderName);

                if (!directory.Exists)
                    return BOResult.ExcelInvalidFolderName;

                var masks = new[] { "*.xlsx", "*.xlsm" };
                files = masks.SelectMany(directory.EnumerateFiles);

                if (!files.Any())
                    return BOResult.ExcelEmptyFolder;

                return BOResult.Success;
            }
            catch (Exception ex)
            {
                {
                    BOUtilities.TraceErrors(ex, folderName);
                    return BOResult.GeneralError;
                }
            }
        }

        public BOResult ImportFolder()
        {
            const string JobObject = "DATEV Journal Import";
            string datevClientNumber;
            string bookingRunSerialNum = null;
            int bookingRunYear;
            short bookingRunMonth;
            string bookingRunTitle = "";
            string bookingRunCode;
            short bookingRunVersion = 0;
            bool bookingRunPreliminary = false;
            oDATEVJournal source;
            JobReport job = null;
            string curFileName = "";
            BOResult result = BOResult.Success;

            try
            {
                datevClientNumber = VerumInstance.Client.DATEVClientNumber.Value.ToString();

                if (files == null || !files.Any())
                    return BOResult.ExcelEmptyFolder;

                job = new JobReport();
                if (!job.StartJob(TypeJobEnum.JournalImport))
                    return BOResult.JobReportingError;

                int fileCount = -1;


                foreach (var file in files)
                {
                    fileCount++;
                    OnRaiseProgressEvent(new JobProgress(fileCount, files.Count()));

                    curFileName = file.Name;        // record for error tracing

                    // Import table via OpenXML
                    var import = new ExcelImport();

                    // if no table found continue to next file
                    if (!import.WorkbookOpen(file.FullName) || !import.WorksheetSelectLast())
                    {
                        job.Report(TypeJobSuccessEnum.Warning, BOResult.DATEVJournalInvalidFile, JobObject, file.Name, "Invalid file omitted");
                        result = BOResult.GeneralWarning;
                        continue;
                    }

                    if (import.RowCount < 3)
                    {
                        job.Report(TypeJobSuccessEnum.Warning, BOResult.DATEVJournalEmptyTable, JobObject, file.Name, "Empty table. File omitted.");
                        result = BOResult.GeneralWarning;
                        continue;
                    }

                    // Read and parse booking run code from import file. Check validity - if not correct omit file
                    {
                        string datevTitle = import.GetCellValue(1, 1);

                        if (datevTitle == null ||
                            !datevTitle.Contains(Properties.Resources.DATEVJournalUniqueID1) ||
                            !datevTitle.Contains(datevClientNumber) ||
                            (!datevTitle.Contains(Properties.Resources.DATEVJounralUniqueID2) &&
                            !datevTitle.Contains(Properties.Resources.DATEVJounralUniqueID3)))
                        {
                            job.Report(TypeJobSuccessEnum.Warning, BOResult.DATEVJournalInvalidHeader, JobObject, datevTitle, $"Invalid header. File {file.Name} omitted.");
                            result = BOResult.GeneralWarning;
                            continue;
                        }

                        // Check whether file is preliminary (title contains "Prüfjournal"

                        if (datevTitle.Contains(Properties.Resources.DATEVJounralUniqueID3))
                            bookingRunPreliminary = true;
                        else
                            bookingRunPreliminary = false;

                        // Locate month/year split in booking run ID - determine version code and title
                        int i;
                        bookingRunVersion = 0;

                        for (i = datevTitle.Length - 1; i > 0; i--)
                            if (datevTitle.ElementAt(i) == '/')
                            {
                                bookingRunSerialNum = datevTitle.Substring(i + 1, 4);

                                int titlePos = i + 6;

                                if (datevTitle.Length > i + 5 && datevTitle.Substring(i + 5, 1) == "-")
                                {
                                    short.TryParse(datevTitle.Substring(i + 6, 1), out bookingRunVersion);
                                    titlePos = i + 8;
                                }

                                // Determine optional booking run name
                                if (datevTitle.Length > titlePos)
                                    bookingRunTitle = datevTitle.Substring(titlePos);

                                break;
                            }

                        if (bookingRunSerialNum == null)
                        {
                            job.Report(TypeJobSuccessEnum.Warning, BOResult.DATEVJournalInvalidHeader, JobObject, datevTitle, $"Invalid header. File {file.Name} omitted.");
                            result = BOResult.GeneralWarning;
                            continue;
                        }

                        int.TryParse(datevTitle.Substring(i - 4, 4), out bookingRunYear);

                        if (bookingRunYear < 1900 || bookingRunYear > DateTime.Now.Year)
                        {
                            job.Report(TypeJobSuccessEnum.Warning, BOResult.DATEVJournalInvalidHeader, JobObject, datevTitle, $"Invalid booking run year {bookingRunYear}. File {file.Name} omitted.");
                            result = BOResult.GeneralWarning;
                            continue;
                        }

                        short.TryParse(datevTitle.Substring(i - 7, 2), out bookingRunMonth);
                        if (bookingRunMonth < 1 || bookingRunMonth > 12)
                        {
                            job.Report(TypeJobSuccessEnum.Warning, BOResult.DATEVJournalInvalidHeader, JobObject, datevTitle, $"Invalid booking run month {bookingRunMonth}. File {file.Name} omitted.");
                            result = BOResult.GeneralWarning;
                            continue;
                        }

                        bookingRunCode = datevTitle.Substring(i - 7, 12);           // ACTION: Include version number???
                    }

                    // Check whether booking run entry already exists
                    var bookingRun = new BookingRun();

                    if (bookingRun.SelectViaKey(bookingRunCode))
                    {
                        if (!bookingRun.StatusPreliminary)
                        {
                            job.Report(TypeJobSuccessEnum.Success, BOResult.Success, JobObject, bookingRunCode, $"File {file.Name} already imported on {bookingRun.ImportedDate.ToLocalTime()}.");
                            result = BOResult.GeneralWarning;
                            continue;
                        }
                        else if (bookingRun.ImportFileDate > file.LastWriteTimeUtc)
                        {
                            // JobReport success, "Older or same date as last import"
                            job.Report(TypeJobSuccessEnum.Success, BOResult.Success, JobObject, bookingRunCode, "Older or same date as last import, import skipped");
                            result = BOResult.GeneralWarning;
                            continue;
                        }
                        else
                        {
                            bookingRun.ClearAllBookRecords();
                            // Bookrecords zählen, wenn > 0 JobReport Error, "Deletion of Bookrecords for existing Bookingrun failed"
                            if (BookRecord.GetBOCollection(bookingRun.Id).Count != 0)
                            {
                                job.Report(TypeJobSuccessEnum.Error, BOResult.GeneralError, JobObject, bookingRunCode, "Deletion of Bookrecords for existing Bookingrun failed");
                                result = BOResult.GeneralWarning;
                                continue;
                            }
                        }
                    }
                    else
                    {
                        bookingRun.New();
                    }

                    // Read journal table starting row 2 in the Excel spreadsheet
                    var t = import.GetDataTable(2);

                    if (t == null)
                    {
                        job.Report(TypeJobSuccessEnum.Warning, BOResult.DATEVJournalInvalidTable, JobObject, bookingRunCode, $"Invalid table format. File {file.Name} omitted.");
                        result = BOResult.GeneralWarning;
                        continue;
                    }

                    // Wrap import of entire booking run into a transaction
                    VerumInstance.TransactionStart();



                    bookingRun.ImportedDate = DateTime.UtcNow;
                    bookingRun.ImportFileName = file.Name;
                    bookingRun.ImportFileDate = file.LastWriteTimeUtc;
                    bookingRun.BookingRunCode = bookingRunCode;
                    bookingRun.VersionCode = bookingRunVersion;
                    bookingRun.StatusPreliminary = bookingRunPreliminary;
                    bookingRun.PeriodYear = bookingRunYear;
                    bookingRun.PeriodMonth = bookingRunMonth;
                    bookingRun.SerialNum = bookingRunSerialNum;
                    if (bookingRunTitle != "") bookingRun.BookingRunTitle = bookingRunTitle;
                    bookingRun.CommitChanges();
                    VerumInstance.SaveChanges(true);

                    // Import records of the booking run row by row
                    BookRecord bookRecord = null;
                    int accountDebitCode;
                    int accountCreditCode;
                    int recordsImported = 0;
                    int recordsOmitted = 0;
                    bool flagAccountOpening = false;

                    for (var i = 0; i < t.Rows.Count; i++)
                    {
                        // Eintrag einlesen
                        source = ExcelImport.GetEntityFromXLS<oDATEVJournal>(t.Rows[i]);

                        // if next journal entry (only new journal entries have a number in the Nr field)
                        if (source.Nr > 0)
                        {
                            if (bookRecord != null)
                            {
                                if (bookRecord.TotalDebit != bookRecord.TotalCredit)
                                {
                                    job.Report(TypeJobSuccessEnum.Warning, BOResult.DATEVUnbalancedTransactions, JobObject, bookingRunCode, $"Record transactions not balanced. Record {bookRecord.BookingSequenceNum} omitted.");
                                    recordsOmitted++;
                                }
                                else
                                {
                                    bookRecord.CommitChanges();
                                    recordsImported++;
                                }
                            }

                            if (source.S_H == 'H')
                            {
                                accountDebitCode = source.Gegenkonto;
                                accountCreditCode = source.Konto;
                            }
                            else
                            {
                                accountDebitCode = source.Konto;
                                accountCreditCode = source.Gegenkonto;
                            }

                            var accountDebit = new Account();
                            var accountCredit = new Account();
                            CostCenter costCenter = new CostCenter();

                            if (!accountDebit.SelectViaKey(accountDebitCode))
                            {
                                accountDebit.New();
                                accountDebit.AccountCode = accountDebitCode;

                                var accountGroup = new AccountGroup();

                                if (accountGroup.SelectViaAccountCode(accountDebitCode))
                                {
                                    accountDebit.idAccountGroup = accountGroup.Id;
                                    accountDebit.idAccountReporting = accountGroup.idAccountReportingDefault;
                                    accountDebit.TypeAccount = accountGroup.TypeAccountDefault;
                                    accountDebit.TitleLocalAccount = accountGroup.TitleLocalAccountGroup + $" {accountDebitCode}";
                                    accountDebit.TitleEnglishAccount = accountGroup.TitleEnglishAccountGroup + $" {accountDebitCode}";
                                    accountDebit.CommitChanges();

                                    // force save commit to DB, so the transaction can find the new account
                                    VerumInstance.SaveChanges(true);
                                    job.Report(TypeJobSuccessEnum.Warning, BOResult.DATEVInvalidAccountNumber, JobObject, bookingRunCode, $"Missing account number {accountDebitCode} created for record no. {source.Nr}.");
                                }
                                else
                                {
                                    job.Report(TypeJobSuccessEnum.Warning, BOResult.DATEVInvalidAccountNumber, JobObject, bookingRunCode, $"Invalid account number {accountDebitCode} in record no. {source.Nr}");
                                    recordsOmitted++;
                                    continue;
                                }
                            }

                            if (!accountCredit.SelectViaKey(accountCreditCode))
                            {
                                accountCredit.New();
                                accountCredit.AccountCode = accountCreditCode;

                                var accountGroup = new AccountGroup();

                                if (accountGroup.SelectViaAccountCode(accountCreditCode))
                                {
                                    accountCredit.idAccountGroup = accountGroup.Id;
                                    accountCredit.idAccountReporting = accountGroup.idAccountReportingDefault;
                                    accountCredit.TypeAccount = accountGroup.TypeAccountDefault;
                                    accountCredit.TitleLocalAccount = accountGroup.TitleLocalAccountGroup + $" {accountCreditCode}";
                                    accountCredit.TitleEnglishAccount = accountGroup.TitleEnglishAccountGroup + $" {accountCreditCode}";
                                    accountCredit.CommitChanges();

                                    // force save commit to DB, so the transaction can find the new account
                                    VerumInstance.SaveChanges(true);
                                    job.Report(TypeJobSuccessEnum.Warning, BOResult.DATEVInvalidAccountNumber, JobObject, bookingRunCode, $"Missing account number {accountCreditCode} created for record no. {source.Nr}.");
                                }
                                else
                                {
                                    job.Report(TypeJobSuccessEnum.Warning, BOResult.DATEVInvalidAccountNumber, JobObject, bookingRunCode, $"Invalid account number {accountCreditCode} in record no. {source.Nr}");
                                    recordsOmitted++;
                                    continue;
                                }
                            }

                            if (source.KOST1 != null && source.KOST1 != "")
                            {
                                if (!costCenter.SelectViaKey(source.KOST1))
                                    job.Report(TypeJobSuccessEnum.Warning, BOResult.DATEVInvalidCostCenter, JobObject, bookingRunCode, $"Invalid cost center code {source.KOST1} in record no. {source.Nr}. Record imported without cost center");
                            }

                            // determine whether record is for account opening booking (EB-Wert)
                            if ((accountCreditCode >= 9000 && accountCreditCode <= 9099) || (accountDebitCode >= 9000 && accountDebitCode <= 9099))
                                flagAccountOpening = true;
                            else
                                flagAccountOpening = false;

                            // Create booking record
                            bookRecord = new BookRecord();
                            bookRecord.New();

                            bookRecord.TypeBookRecord = (short)TypeBookRecordEnum.Actual;
                            bookRecord.idAccountDebit = accountDebit.Id;
                            bookRecord.AccountCodeDebit = accountDebitCode;
                            bookRecord.idAccountCredit = accountCredit.Id;
                            bookRecord.AccountCodeCredit = accountCreditCode;
                            if (costCenter.Bound) bookRecord.idCostCenterBookRecord = costCenter.Id;
                            bookRecord.idBookingRun = bookingRun.Id;
                            bookRecord.BookingRunCode = bookingRunCode;
                            bookRecord.BookingSequenceNum = source.Nr;
                            bookRecord.TitleBookRecord = source.Buchungstext;

                            if (source.Leistungsdatum > DateTime.MinValue)
                                bookRecord.BookingDate = source.Leistungsdatum;
                            else
                                bookRecord.BookingDate = source.Datum;

                            bookRecord.Amount = source.Umsatz;
                            bookRecord.BookingDocument = source.Belegfeld_1;
                            bookRecord.FlagAccountOpening = flagAccountOpening;
                            bookRecord.ReferenceIDBookRecord = source.KOST2;

                            if (source.BU > 0)
                                bookRecord.DATEVBUCode = source.BU;
                        }

                        // there is usually at least one transaction row in addtion to every book record row, sometimes up to 3
                        // they contain additional transactions which relate back to the preceding book record
                        if (bookRecord != null)
                        {
                            if (source.Kontobuchung_USt_Konto != 0)
                            {
                                if (source.KB_SH == 'H')
                                    bookRecord.AddTransaction(source.Kontobuchung_USt_Konto, source.Kontobuchung_USt, 0, null, flagAccountOpening);
                                else
                                    bookRecord.AddTransaction(source.Kontobuchung_USt_Konto, 0, source.Kontobuchung_USt, null, flagAccountOpening);
                            }

                            if (source.Steuerbuchung_USt_Konto != 0)
                            {
                                if (source.SB_SH == 'H')
                                    bookRecord.AddTransaction(source.Steuerbuchung_USt_Konto, source.Steuerbuchung_USt, 0, null, flagAccountOpening);
                                else
                                    bookRecord.AddTransaction(source.Steuerbuchung_USt_Konto, 0, source.Steuerbuchung_USt, null, flagAccountOpening);
                            }
                        }
                    }

                    // commit final book record
                    if (bookRecord != null)
                    {
                        if (bookRecord.TotalDebit != bookRecord.TotalCredit)
                        {
                            job.Report(TypeJobSuccessEnum.Warning, BOResult.DATEVUnbalancedTransactions, JobObject, bookingRunCode, $"Transactions not balanced in record no. {bookRecord.BookingSequenceNum }");
                            recordsOmitted++;
                        }
                        else
                        {
                            bookRecord.CommitChanges();
                            recordsImported++;
                        }
                    }

                    // Update booking run record with number of records read upon successful import
                    bookingRun.RecordsImported = recordsImported;
                    bookingRun.RecordsOmitted = recordsOmitted;

                    bookingRun.CommitChanges();
                    VerumInstance.TransactionEnd();

                    if (recordsOmitted == 0)
                        job.Report(TypeJobSuccessEnum.Success, BOResult.Success, JobObject, bookingRunCode,
                                    $"Successfully imported {recordsImported} records for booking run {bookingRunCode} from file {file.Name}.");
                    else
                        job.Report(TypeJobSuccessEnum.Warning, BOResult.GeneralWarning, JobObject, bookingRunCode,
                                    $"Successfully imported {recordsImported} records for booking run {bookingRunCode} from file {file.Name}. Omitted {recordsOmitted} records.");

                }

                fileCount++;
                OnRaiseProgressEvent(new JobProgress(fileCount, files.Count()));

                job.EndJob();

                return result;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, curFileName);
                VerumInstance.TransactionRollback();
                if (job != null)
                {
                    job.Report(TypeJobSuccessEnum.Error, BOResult.GeneralError, "DATEV Journal Import", curFileName, "Unexpected error during DATEV journal import. See tracing for further information.");
                    job.EndJob();
                }
                return BOResult.GeneralError;
            }
        }

        public event EventHandler<JobProgress> ProgressEvent;

        protected virtual void OnRaiseProgressEvent(JobProgress e)
        {
            // Raise event if event handler is set (i.e. not null)
            ProgressEvent?.Invoke(this, e);
        }

        // PRIVATE FIELDS
        DirectoryInfo directory = null;
        IEnumerable<FileInfo> files = null;
    }


}
