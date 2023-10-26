using DocumentFormat.OpenXml.Bibliography;
using DocumentFormat.OpenXml.Office2013.Excel;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.Entity;
using System.Drawing.Text;
using System.Linq;
using System.Net;
using System.Security.Permissions;
using System.Security.Policy;
using System.Security.RightsManagement;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Interop;
using VerumBusinessObjects.Framework;
using VerumBusinessObjects.Views;

namespace VerumBusinessObjects
{
    public class BookingImport
    {
        private BOCollection<BookRecord, tBookRecord> BOColl;
        private BOCollection<Client, tClient> BOCollClient;
        private ObservableCollection<Client> client;
        private ObservableCollection<BookRecord> bookRecords;

        public async Task<BOResult> InsertBookRecord(GeneralLedgerPageResModel resModel, RunningClientModel model)
        {
            JobReport job = null;
            try
            {

                job = new JobReport();
                if (!job.StartJob(TypeJobEnum.BusinessCenterImport))
                    return BOResult.JobReportingError;

                //var query = resModel.value.Where(y => y.DocumentType != "Invoice"  && ( y.DocumentType == "Credit Memo" || y.DocumentType == "Payment" || y.DocumentType.Trim() == ""));
                var query = resModel.value.ToList(); 
                var transactionnumber = query.OrderBy(x => x.LastModifiedDate).Select(x => x.Transaktionsnummer).Distinct().ToList<int>();

                BookingRun bookingRun = null;

                if (transactionnumber.Count > 0)
                    bookingRun = BusinessCenterBookingRunNew();

                // get accoutcode from api list
                var accoutCode = query.Select(x => x.GLAccountNo).Distinct().ToList<Int32>();
                var accoutCode2 = query.Where(x => !string.IsNullOrEmpty(x.SourceNo.Trim()) && x.SourceNo.ToLower() != "coba").Select(x => Convert.ToInt32(x.SourceNo)).Distinct().ToList<Int32>();
                var accoutCode3 = accoutCode.Concat(accoutCode2).Distinct();

                // get already exist into database
                var dbAccountCode = Account.GetAccountCode();

                // save accout Code which are not exist into db
                NewAccount(accoutCode3.Where(x => !dbAccountCode.Contains(x)).ToList<Int32>(), ref job, bookingRun == null ? "" : bookingRun.BookingRunCode);

                // get updated accoutCode and id list from db
                var dbAccountCodeUpdated = Account.GetAccountCodeModels();

                var listCostCenter = CostCenter.GetCollection();
                int recordsImported = 0, recordsOmitted = 0;
                double VatAmountDr = 0d, VatAmountCr = 0d, AmountDr = 0d, AmountCr = 0d;
                Guid? VatTranGuid = null;

                var alreadyExistTransactions = await BookRecord.GetBookRecordTransaction(transactionnumber).ToListAsync();

                List<tBookRecord> tBookRecords = new List<tBookRecord>();
                List<tBookTransaction> tBookTransactions = new List<tBookTransaction>();

                foreach (var tran in transactionnumber)
                {
                    try
                    {

                        // check transaction number already exist..
                        var entry = resModel.value.Where(x => x.Transaktionsnummer == tran).OrderBy(x => x.EntryNo).ToList();
                        var listbook = new List<BookRecord>();

                        // if transaction already exist then update it
                        if (alreadyExistTransactions.Where(x => x.BCTransactionNo == tran).Count() > 0)
                        {
                            continue;

                            // Call API for get particular transaction list
                            var transactionEntry = await GetParticularTransactionEntry(tran, model);
                            entry = transactionEntry.value.Where(x => x.Transaktionsnummer == tran).OrderBy(x => x.EntryNo).ToList();

                            List<double> VatAmountList = entry.Where(x => !string.IsNullOrEmpty(x.GenPostingType) && x.VATAmount != 0).Select(x => x.VATAmount).ToList<double>();
                            var isInvoice = false;
                            var mainAccountNumber = GetMainAccountEntries(entry, VatAmountList, out isInvoice);

                            // check Transaction is Payment Type Case 1
                            //if (entry.Where(x => x.DocumentType == "Payment").Count() == entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).Count()
                            //    && entry.Count() == 2)
                            //{
                            //    mainAccountNumber = entry.OrderByDescending(x => x.EntryNo).ToList();
                            //}
                            //else if (entry.Where(x => !string.IsNullOrEmpty(x.GenPostingType.Trim()) &&
                            //                    x.DocumentType == "Payment").Count() == entry.Count() &&
                            //        entry.Where(x => string.IsNullOrEmpty(x.SourceNo)).Count() == 1)
                            //{
                            //    mainAccountNumber = entry.Where(x => string.IsNullOrEmpty(x.SourceNo)).OrderByDescending(x => x.EntryNo).ToList();
                            //}

                            if (mainAccountNumber.FirstOrDefault() == null)
                                continue;

                            for (int i = 0; i < entry.Count(); i++)
                            {
                                if (!(IsValidEntryCondition(entry, i, mainAccountNumber)))
                                    continue;

                                if (mainAccountNumber.FirstOrDefault().EntryNo == entry[i].EntryNo)
                                    continue;

                                double TotalAmout = (entry[i].Amount + entry[i].VATAmount) < 0 ? -(entry[i].Amount + entry[i].VATAmount) : (entry[i].Amount + entry[i].VATAmount);
                                Guid BookRecordGuid = alreadyExistTransactions.SelectMany(x => x.tBookTransaction.Where(y => y.BCGeneralLedgerPageAPIEntryNo == entry[i].EntryNo)).Select(x => x.idBookingRecord).FirstOrDefault();

                                VatAmountDr = 0d;
                                VatAmountCr = 0d;
                                VatTranGuid = null;

                                AmountDr = entry[i].DebitAmount;
                                AmountCr = entry[i].CreditAmount;
                                Guid TranGuid = alreadyExistTransactions.SelectMany(x => x.tBookTransaction.Where(y => y.BCGeneralLedgerPageAPIEntryNo == entry[i].EntryNo)).Select(x => x.Id).FirstOrDefault();

                                if (entry[i].VATAmount != 0)
                                {
                                    var VatAccountNo = entry.Where(x => x.Amount == entry[i].VATAmount).FirstOrDefault();
                                    if (VatAccountNo != null)
                                    {
                                        VatAmountCr = VatAccountNo.CreditAmount;
                                        VatAmountDr = VatAccountNo.DebitAmount;
                                        VatTranGuid = alreadyExistTransactions.SelectMany(x => x.tBookTransaction.Where(y => y.BCGeneralLedgerPageAPIEntryNo == VatAccountNo.EntryNo)).Select(x => x.Id).FirstOrDefault();
                                    }
                                }

                                if (TranGuid == Guid.Empty)
                                {
                                    var bookRecord = InsertBookRecord(ref entry, i, ref mainAccountNumber, ref listCostCenter, ref bookingRun, ref dbAccountCodeUpdated, ref job, ref VatAmountList);
                                    listbook.Add(bookRecord);
                                }
                                else
                                {
                                    BookRecord.UpdateBookRecordAndTransactionAmount(VatAmountDr, VatAmountCr, AmountDr, AmountCr, VatTranGuid, TranGuid, BookRecordGuid, TotalAmout);
                                }
                            }
                        }
                        else
                        {
                            List<double> VatAmountList = entry.Where(x => !string.IsNullOrEmpty(x.GenPostingType) && x.VATAmount != 0).Select(x => x.VATAmount).ToList<double>();
                            var isInvoice = false;

                            var mainAccountNumber = GetMainAccountEntries(entry, VatAmountList, out isInvoice);

                            if (mainAccountNumber.FirstOrDefault() == null)
                            {
                                var msg = "Not inserted transasction number " + entry[1].Transaktionsnummer;
                                job.Report(TypeJobSuccessEnum.Error, BOResult.GeneralError, "Business Center API", message: msg, forBulkCommit: true);
                                continue;
                            }

                            if (isInvoice)
                            {
                                for (int i = 0; i < entry.Count(); i++)
                                {
                                    if (!(IsValidEntryCondition(entry, i, mainAccountNumber)))
                                        continue;

                                    var bookRecord = InsertBookRecord(ref entry, i, ref mainAccountNumber, ref listCostCenter, ref bookingRun, ref dbAccountCodeUpdated, ref job, ref VatAmountList);
                                    listbook.Add(bookRecord);
                                }
                            }
                            else
                            {
                                var bookRecord = InsertBookRecordGeneral(ref entry, ref mainAccountNumber, ref listCostCenter, ref bookingRun, ref dbAccountCodeUpdated, ref job);
                                listbook.Add(bookRecord);
                            }
                        }

                        foreach (var bookrecord in listbook)
                        {
                            var res1 = bookrecord._CustomCommitBefore();
                            if (res1 != BOResult.Success)
                            {
                                recordsOmitted++;
                                var msg = "Someting went grong into transaction number " + bookrecord.BCTransactionNo + " and BC Entry Numbers is " + bookrecord.BCEntryNumber;
                                job.Report(TypeJobSuccessEnum.Error, BOResult.GeneralError, "Business Center API", message: msg, forBulkCommit: true);
                            }
                            else
                            {
                                recordsImported++;
                                tBookRecords.Add(bookrecord.data);
                                foreach (var tbooktran in bookrecord._BookTransactions)
                                {
                                    tBookTransactions.Add(tbooktran.data);
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        if (job != null)
                        {
                            job.Report(TypeJobSuccessEnum.Error, BOResult.GeneralError, "Business Center API", message: "someting went wrong transaction number : " + tran + ". Error : " + ex.Message, forBulkCommit: true);
                        }
                    }
                }

                BookRecord.CommitChangesBulk(tBookRecords, tBookTransactions);

                if (bookingRun != null)
                {
                    // Update booking run record with number of records read upon successful import
                    bookingRun.RecordsImported = recordsImported;
                    bookingRun.RecordsOmitted = recordsOmitted;

                    bookingRun.CommitChanges();
                }

                List<tJobReportItem> tJobReportItems = new List<tJobReportItem>();
                foreach (var item in job.JobReportItemList)
                {
                    tJobReportItems.Add(item.data);
                }

                if (tJobReportItems.Count > 0) JobReport.CommitChangesBulkJobReportItem(tJobReportItems);
                job.EndJob();

                // get inserted recored and export
                var bookingrecored = await BookRecord.GetBookRecord(transactionnumber).ToListAsync();
                var bookingrecoredTran = await BookTransaction.GetBookRecordTran(transactionnumber).ToListAsync();
                ExcelImportExport.ExportExcel<tBookTransaction>(bookingrecoredTran, Convert.ToDateTime(model.RunDateTime).ToString("yyyy_MM_dd_HH_mm_ss_ffZ") + "_tBookTransaction", "BookTransaction");
                ExcelImportExport.ExportExcel<tBookRecord>(bookingrecored, Convert.ToDateTime(model.RunDateTime).ToString("yyyy_MM_dd_HH_mm_ss_ffZ") + "_tBookRecord", "BookRecord");
                ExcelImportExport.ExportExcel<tJobReportItem>(JobReportItem.GetTableList(job), Convert.ToDateTime(model.RunDateTime).ToString("yyyy_MM_dd_HH_mm_ss_ffZ") + "_tJobReportItem", "JobReportItem");
                ExcelImportExport.ExportExcel<tJobReport>(JobReport.GetJob(job.Id), Convert.ToDateTime(model.RunDateTime).ToString("yyyy_MM_dd_HH_mm_ss_ffZ") + "_tJobReport", "JobReport");
                ExcelImportExport.ExportExcel<tAccount>(Account.GetAccountAllList(), Convert.ToDateTime(model.RunDateTime).ToString("yyyy_MM_dd_HH_mm_ss_ffZ") + "_tAccount", "Account");
                ExcelImportExport.ExportExcel<tAccountGroup>(AccountGroup.GetAccountGroupAllList(), Convert.ToDateTime(model.RunDateTime).ToString("yyyy_MM_dd_HH_mm_ss_ffZ") + "_tAccountGroup", "tAccountGroup");

                return BOResult.Success;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                if (job != null)
                {
                    job.Report(TypeJobSuccessEnum.Error, BOResult.GeneralError, "Business Center API", message: ex.Message);
                    job.EndJob();
                }
                return BOResult.GeneralError;
            }
        }

        public async Task<BOResult> UpdateBookTransactionAndRecord(RunningClientModel model)
        {
            var client = Client.GetBOCollection().GetObservableCollection().AsQueryable().FirstOrDefault();

            string nextLink = "";
            var generalLedger = new GeneralLedgerPageResModel();
            var datetime = DateTime.UtcNow;

            if (client == null)
                return BOResult.GeneralError;

            if (client.BCLastUpdate <= DateTime.MinValue)
                nextLink = model.BCUrl;
            else
                nextLink = model.BCUrl + "?$filter=Erstellt gt " + Uri.EscapeDataString(Convert.ToDateTime(client.BCLastUpdate).ToString("yyyy-MM-ddTHH:mm:ss.fffffffZ"));

            while (!string.IsNullOrEmpty(nextLink))
            {
                var nextData = await DynamicBusinessCenter.sendRequest<GeneralLedgerPageResModel>(nextLink);
                generalLedger.value.AddRange(nextData.value);
                nextLink = nextData.NextLink;
            }

            ExcelImportExport.ExportExcel<GeneralLedgerPageResModel.GeneralLedgerValue>(generalLedger.value, Convert.ToDateTime(model.RunDateTime).ToString("yyyy_MM_dd_HH_mm_ss_ffZ") + "_BC", "GeneralLedger");
            return await InsertBookRecord(generalLedger, model);
        }

        public async Task<GeneralLedgerPageResModel> GetParticularTransactionEntry(int BCTransactionId, RunningClientModel model)
        {
            var generalLedger = new GeneralLedgerPageResModel();
            try
            {
                var nextLink = model.BCUrl + "?$filter=Transaktionsnummer eq " + BCTransactionId;
                while (!string.IsNullOrEmpty(nextLink))
                {
                    var nextData = await DynamicBusinessCenter.sendRequest<GeneralLedgerPageResModel>(nextLink);
                    generalLedger.value.AddRange(nextData.value);
                    nextLink = nextData.NextLink;
                }

                return generalLedger;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public async Task<BOResult> UpdateInsertSingleTransaction(int BCTransactionId, RunningClientModel model)
        {
            if (string.IsNullOrEmpty(model.BCUrl))
                return BOResult.BCURLNotFound;

            var data = await GetParticularTransactionEntry(BCTransactionId, model);
            ExcelImportExport.ExportExcel<GeneralLedgerPageResModel.GeneralLedgerValue>(data.value, Convert.ToDateTime(model.RunDateTime).ToString("yyyy_MM_dd_HH_mm_ss_ffZ") + "_BC", "GeneralLedger");

            if (data == null)
                return BOResult.GeneralError;

            if (data.value.Count == 0)
                return BOResult.BCBookImportRecordNotFound;

            var res = await InsertBookRecord(data, model);
            return res;
        }

        public BookRecord InsertBookRecord(ref List<GeneralLedgerPageResModel.GeneralLedgerValue> entry, int i, 
            ref List<GeneralLedgerPageResModel.GeneralLedgerValue> mainAccountNumber, ref List<tCostCenter> listCostCenter, 
            ref BookingRun bookingRun, ref List<AccountCodeModel> dbAccountCodeUpdated, ref JobReport job, ref List<double> VatAmountList)
        {

            if (entry[i].SourceNo == "COBA" || entry[i].SourceNo.Trim() == "")
                entry[i].SourceNo = "1803";

            int accountDebitCode, accountCreditCode, recordsOmitted = 0;
            Guid accountDebitGuid, accountCreditGuid;
            bool flagAccountOpening = false;

            accountDebitCode = entry[i].DebitAmount > 0 ? entry[i].GLAccountNo : Convert.ToInt32(entry[i].SourceNo);
            accountCreditCode = entry[i].CreditAmount > 0 ? entry[i].GLAccountNo : Convert.ToInt32(entry[i].SourceNo);

            #region find and save account code and set value into accountDebitGuid & accountCreditGuid 
            if (dbAccountCodeUpdated.Where(x => x.AccountCode == accountDebitCode).Count() > 0)
                accountDebitGuid = dbAccountCodeUpdated.Where(x => x.AccountCode == accountDebitCode).FirstOrDefault().Guid;
            else
            {
                var accountDebit = new Account();
                NewAccount(accountDebitCode, ref accountDebit, ref job, bookingRun == null ? "" : bookingRun.BookingRunCode);
                accountDebitGuid = accountDebit.Id;
            }

            if (dbAccountCodeUpdated.Where(x => x.AccountCode == accountCreditCode).Count() > 0)
                accountCreditGuid = dbAccountCodeUpdated.Where(x => x.AccountCode == accountCreditCode).FirstOrDefault().Guid;
            else
            {
                var accountCredit = new Account();
                NewAccount(accountCreditCode, ref accountCredit, ref job, bookingRun == null ? "" : bookingRun.BookingRunCode);
                accountCreditGuid = accountCredit.Id;
            }

            var accountNo = (mainAccountNumber.FirstOrDefault().SourceNo == "COBA" || mainAccountNumber.FirstOrDefault().SourceNo.Trim() == "") ? 1803 : Convert.ToInt32(mainAccountNumber.FirstOrDefault().SourceNo);
            if (dbAccountCodeUpdated.Where(x => x.AccountCode == accountNo).Count() == 0)
            {
                var account = new Account();
                NewAccount(accountCreditCode, ref account, ref job, bookingRun == null ? "" : bookingRun.BookingRunCode);
            }
            #endregion

            // determine whether record is for account opening booking (EB-Wert)
            if ((accountCreditCode >= 9000 && accountCreditCode <= 9099) || (accountDebitCode >= 9000 && accountDebitCode <= 9099))
                flagAccountOpening = true;
            else
                flagAccountOpening = false;

            // get cost center id
            var GlobalDimension1Code = entry[i].GlobalDimension1Code;
            var costCenterId = listCostCenter.Where(x => x.CostCenterCode == GlobalDimension1Code).Select(x => x.Id).FirstOrDefault();

            if (costCenterId == Guid.Empty && !string.IsNullOrEmpty(GlobalDimension1Code))
                if (job != null)
                    job.Report(TypeJobSuccessEnum.Error, BOResult.GeneralError, "Business Center API", contextInfo: bookingRun.BookingRunCode, message: "GlobalDimension1Code (" + entry[i].GlobalDimension1Code + ")  not found into tCostCenter table.Check Transaction Number : " + entry[i].Transaktionsnummer, forBulkCommit: true);

            if (string.IsNullOrEmpty(entry[i].GlobalDimension2Code))
                if (job != null)
                    job.Report(TypeJobSuccessEnum.Error, BOResult.GeneralError, "Business Center API", contextInfo: bookingRun.BookingRunCode, message: "BC GlobalDimension2Code is blank. Check Transaction Number : " + entry[i].Transaktionsnummer, forBulkCommit: true);

            if (string.IsNullOrEmpty(GlobalDimension1Code))
                if (job != null)
                    job.Report(TypeJobSuccessEnum.Error, BOResult.GeneralError, "Business Center API", contextInfo: bookingRun.BookingRunCode, message: "BC GlobalDimension1Code is blank. Check Transaction Number : " + entry[i].Transaktionsnummer, forBulkCommit: true);

            var bookRecord = new BookRecord();
            bookRecord.New();

            bookRecord.TypeBookRecord = (short)TypeBookRecordEnum.Actual;
            bookRecord.BCDateCreated = entry[i].CreatedDate;
            bookRecord.BCDateUpdated = entry[i].LastModifiedDate;
            bookRecord.FlagOutdated = false;
            bookRecord.TypeBookRecord = 0;
            bookRecord.FlagAccountOpening = flagAccountOpening;
            bookRecord.idAccountDebit = accountDebitGuid;
            bookRecord.idAccountCredit = accountCreditGuid;
            if (costCenterId != null) bookRecord.idCostCenterBookRecord = costCenterId;
            bookRecord.AccountCodeDebit = accountDebitCode;
            bookRecord.AccountCodeCredit = accountCreditCode;
            bookRecord.BookingDate = entry[i].PostingDate;
            //bookRecord.Amount = (entry[i].Amount + entry[i].VATAmount) < 0 ? -(entry[i].Amount + entry[i].VATAmount) : (entry[i].Amount + entry[i].VATAmount);
            bookRecord.BookingDocument = entry[i].ExternalDocumentNo;
            bookRecord.ReferenceIDBookRecord = entry[i].GlobalDimension2Code;
            bookRecord.BCTransactionNo = entry[i].Transaktionsnummer;
            bookRecord.TransactionMainAccountCode = mainAccountNumber.FirstOrDefault().GLAccountNo;
            bookRecord.idBookingRun = bookingRun.Id;
            bookRecord.BookingRunCode = bookingRun.BookingRunCode;
            bookRecord.BCDocumentType = string.IsNullOrEmpty(entry[i].DocumentType) ? "Blank" : entry[i].DocumentType;
            bookRecord.BCDocumentNo = entry[i].DocumentNo;
            bookRecord.TitleBookRecord = string.Join(", ", entry.Where(x => !string.IsNullOrEmpty(x.Description)).Select(x => x.Description).Distinct().ToList<string>());
            bookRecord.BookingDocument = entry[i].ExternalDocumentNo;

            if (bookRecord != null)
            {
                var vatAmountList = VatAmountList; 
                bookRecord.AddTransaction(entry[i].GLAccountNo, entry[i].CreditAmount, entry[i].DebitAmount, null, flagAccountOpening, BCTransactionNo: entry[i].Transaktionsnummer, BCGeneralLedgerPageAPIEntryNo: entry[i].EntryNo);
                bookRecord.BCEntryNumber = entry[i].EntryNo.ToString();
                var vatAmount2 = 0d;
                if (entry[i].VATAmount != 0)
                {
                    var VatAmount = entry[i].VATAmount;
                    var VatAccountNo = entry.Where(x => x.Amount == VatAmount).FirstOrDefault();

                    if (VatAccountNo != null)
                    {
                        bookRecord.AddTransaction(VatAccountNo.GLAccountNo, (entry[i].VATAmount < 0 ? -(entry[i].VATAmount) : 0), (entry[i].VATAmount > 0 ? entry[i].VATAmount : 0), null, flagAccountOpening, BCTransactionNo: entry[i].Transaktionsnummer, BCGeneralLedgerPageAPIEntryNo: VatAccountNo.EntryNo);
                        bookRecord.BCEntryNumber = bookRecord.BCEntryNumber + ", " + VatAccountNo.EntryNo.ToString();

                        if (entry[i].VATAmount > 0)
                        {
                            if (entry.Where(x => x.CreditAmount == VatAmount && !vatAmountList.Contains(x.Amount)).FirstOrDefault() != null)
                            {
                                var multipleTax = entry.Where(x => x.CreditAmount == VatAmount).FirstOrDefault();

                                bookRecord.AddTransaction(multipleTax.GLAccountNo, (multipleTax.Amount < 0 ? -(multipleTax.Amount) : 0), (multipleTax.Amount > 0 ? multipleTax.Amount : 0), null, flagAccountOpening, BCTransactionNo: entry[i].Transaktionsnummer, BCGeneralLedgerPageAPIEntryNo: multipleTax.EntryNo);
                                bookRecord.BCEntryNumber = bookRecord.BCEntryNumber + ", " + multipleTax.EntryNo.ToString();
                                vatAmount2 = multipleTax.Amount;
                            }
                        }
                        else if (entry[i].VATAmount < 0)
                        {
                            if (entry.Where(x => x.DebitAmount == -(VatAmount) && !vatAmountList.Contains(x.Amount)).FirstOrDefault() != null)
                            {
                                var multipleTax = entry.Where(x => x.DebitAmount == -(VatAmount)).FirstOrDefault();

                                bookRecord.AddTransaction(multipleTax.GLAccountNo, (multipleTax.Amount < 0 ? -(multipleTax.Amount) : 0), (multipleTax.Amount > 0 ? multipleTax.Amount : 0), null, flagAccountOpening, BCTransactionNo: entry[i].Transaktionsnummer, BCGeneralLedgerPageAPIEntryNo: multipleTax.EntryNo);
                                bookRecord.BCEntryNumber = bookRecord.BCEntryNumber + ", " + multipleTax.EntryNo.ToString();
                                vatAmount2 = multipleTax.Amount;
                            }
                        }
                    }
                }

                if ((entry[i].Amount + entry[i].VATAmount + vatAmount2) < 0)
                {
                    bookRecord.Amount = -(entry[i].Amount + entry[i].VATAmount + vatAmount2);
                    bookRecord.AddTransaction(accountNo, 0, bookRecord.Amount, null, flagAccountOpening, BCTransactionNo: entry[i].Transaktionsnummer, BCGeneralLedgerPageAPIEntryNo: mainAccountNumber.FirstOrDefault().EntryNo);  //mainAccountNumber.FirstOrDefault().EntryNo
                }
                else
                {
                    bookRecord.Amount = entry[i].Amount + entry[i].VATAmount + vatAmount2;
                    bookRecord.AddTransaction(accountNo, bookRecord.Amount, 0, null, flagAccountOpening, BCTransactionNo: entry[i].Transaktionsnummer, BCGeneralLedgerPageAPIEntryNo: mainAccountNumber.FirstOrDefault().EntryNo);
                }
            }

            return bookRecord;
        }

        public BookRecord InsertBookRecordGeneral(ref List<GeneralLedgerPageResModel.GeneralLedgerValue> entry, ref List<GeneralLedgerPageResModel.GeneralLedgerValue> mainAccountNumber, ref List<tCostCenter> listCostCenter, ref BookingRun bookingRun, ref List<AccountCodeModel> dbAccountCodeUpdated, ref JobReport job)
        {
            var mainRecord = mainAccountNumber.FirstOrDefault();

            if (mainRecord.SourceNo == "COBA" || mainRecord.SourceNo.Trim() == "")
                mainRecord.SourceNo = "1803";

            int accountDebitCode, accountCreditCode, recordsOmitted = 0;
            Guid accountDebitGuid, accountCreditGuid;
            bool flagAccountOpening = false;

            accountDebitCode = mainRecord.DebitAmount > 0 ? mainRecord.GLAccountNo : Convert.ToInt32(mainRecord.SourceNo);
            accountCreditCode = mainRecord.CreditAmount > 0 ? mainRecord.GLAccountNo : Convert.ToInt32(mainRecord.SourceNo);

            #region find and save account code and set value into accountDebitGuid & accountCreditGuid 
            if (dbAccountCodeUpdated.Where(x => x.AccountCode == accountDebitCode).Count() > 0)
                accountDebitGuid = dbAccountCodeUpdated.Where(x => x.AccountCode == accountDebitCode).FirstOrDefault().Guid;
            else
            {
                var accountDebit = new Account();
                NewAccount(accountDebitCode, ref accountDebit, ref job, bookingRun == null ? "" : bookingRun.BookingRunCode);
                accountDebitGuid = accountDebit.Id;
            }

            if (dbAccountCodeUpdated.Where(x => x.AccountCode == accountCreditCode).Count() > 0)
                accountCreditGuid = dbAccountCodeUpdated.Where(x => x.AccountCode == accountCreditCode).FirstOrDefault().Guid;
            else
            {
                var accountCredit = new Account();
                NewAccount(accountCreditCode, ref accountCredit, ref job, bookingRun == null ? "" : bookingRun.BookingRunCode);
                accountCreditGuid = accountCredit.Id;
            }

            //var accountNo = (mainAccountNumber.FirstOrDefault().SourceNo == "COBA" || mainAccountNumber.FirstOrDefault().SourceNo.Trim() == "") ? 1803 : Convert.ToInt32(mainAccountNumber.FirstOrDefault().SourceNo);
            //if (dbAccountCodeUpdated.Where(x => x.AccountCode == accountNo).Count() == 0)
            //{
            //    var account = new Account();
            //    NewAccount(accountCreditCode, ref account, ref job, bookingRun == null ? "" : bookingRun.BookingRunCode);
            //}
            #endregion

            // determine whether record is for account opening booking (EB-Wert)
            if ((accountCreditCode >= 9000 && accountCreditCode <= 9099) || (accountDebitCode >= 9000 && accountDebitCode <= 9099))
                flagAccountOpening = true;
            else
                flagAccountOpening = false;

            // get cost center id
            var GlobalDimension1Code = mainRecord.GlobalDimension1Code;
            var costCenterId = listCostCenter.Where(x => x.CostCenterCode == GlobalDimension1Code).Select(x => x.Id).FirstOrDefault();

            if (costCenterId == Guid.Empty && !string.IsNullOrEmpty(GlobalDimension1Code))
                if (job != null)
                    job.Report(TypeJobSuccessEnum.Error, BOResult.GeneralError, "Business Center API", contextInfo: bookingRun.BookingRunCode, message: "GlobalDimension1Code (" + mainRecord.GlobalDimension1Code + ")  not found into tCostCenter table.Check Transaction Number : " + mainRecord.Transaktionsnummer, forBulkCommit: true);

            if (string.IsNullOrEmpty(mainRecord.GlobalDimension2Code))
                if (job != null)
                    job.Report(TypeJobSuccessEnum.Error, BOResult.GeneralError, "Business Center API", contextInfo: bookingRun.BookingRunCode, message: "BC GlobalDimension2Code is blank. Check Transaction Number : " + mainRecord.Transaktionsnummer, forBulkCommit: true);

            if (string.IsNullOrEmpty(GlobalDimension1Code))
                if (job != null)
                    job.Report(TypeJobSuccessEnum.Error, BOResult.GeneralError, "Business Center API", contextInfo: bookingRun.BookingRunCode, message: "BC GlobalDimension1Code is blank. Check Transaction Number : " + mainRecord.Transaktionsnummer, forBulkCommit: true);

            var bookRecord = new BookRecord();
            bookRecord.New();

            bookRecord.TypeBookRecord = (short)TypeBookRecordEnum.Actual;
            bookRecord.BCDateCreated = mainRecord.CreatedDate;
            bookRecord.BCDateUpdated = mainRecord.LastModifiedDate;
            bookRecord.FlagOutdated = false;
            bookRecord.TypeBookRecord = 0;
            bookRecord.FlagAccountOpening = flagAccountOpening;
            bookRecord.idAccountDebit = accountDebitGuid;
            bookRecord.idAccountCredit = accountCreditGuid;
            //if (costCenterId != null) bookRecord.idCostCenterBookRecord = costCenterId;
            bookRecord.AccountCodeDebit = accountDebitCode;
            bookRecord.AccountCodeCredit = accountCreditCode;
            bookRecord.BookingDate = mainRecord.PostingDate;
            bookRecord.Amount = mainRecord.Amount < 0 ? -mainRecord.Amount : mainRecord.Amount;
            bookRecord.BookingDocument = mainRecord.DocumentNo;
            //bookRecord.ReferenceIDBookRecord = mainRecord.GlobalDimension2Code;
            bookRecord.BCTransactionNo = mainRecord.Transaktionsnummer;
            bookRecord.TransactionMainAccountCode = mainAccountNumber.FirstOrDefault().GLAccountNo;
            bookRecord.idBookingRun = bookingRun.Id;
            bookRecord.BookingRunCode = bookingRun.BookingRunCode;
            bookRecord.BCDocumentType = string.IsNullOrEmpty(mainRecord.DocumentType) ? "Blank" : mainRecord.DocumentType;
            bookRecord.BCDocumentNo = mainRecord.DocumentNo;
            //bookRecord.TitleBookRecord = string.Join(", ", entry.Where(x => !string.IsNullOrEmpty(x.Description)).Select(x => x.Description).Distinct().ToList<string>());

            if (bookRecord != null)
            {
                foreach(var item in entry)
                {
                    bookRecord.AddTransaction(item.GLAccountNo, item.CreditAmount, item.DebitAmount, null, flagAccountOpening, BCTransactionNo: item.Transaktionsnummer, BCGeneralLedgerPageAPIEntryNo: item.EntryNo, Description:item.Description,ExternalDocumentNo: item.ExternalDocumentNo);
                }
            }

            return bookRecord;
        }


        public void NewAccount(List<int> accountCodes, ref JobReport job, string bookingRunCode)
        {
            var account = new Account();
            foreach (var item in accountCodes)
            {
                NewAccount(item, ref account, ref job, bookingRunCode);
            }
        }

        public void NewAccount(int accountCode, ref Account account, ref JobReport job, string bookingRunCode)
        {
            if (!account.SelectViaKey(accountCode))
            {
                account.New();
                account.AccountCode = accountCode;

                var accountGroup = new AccountGroup();

                if (accountGroup.SelectViaAccountCode(accountCode))
                {
                    account.idAccountGroup = accountGroup.Id;
                    account.idAccountReporting = accountGroup.idAccountReportingDefault;
                    account.TypeAccount = accountGroup.TypeAccountDefault;
                    account.TitleLocalAccount = accountGroup.TitleLocalAccountGroup + $" {accountCode}";
                    account.TitleEnglishAccount = accountGroup.TitleEnglishAccountGroup + $" {accountCode}";
                    account.CommitChanges();

                    VerumInstance.SaveChanges(true);
                }
                else if (accountGroup.SelectViaAccountCodeVender(accountCode))
                {
                    account.idAccountGroup = accountGroup.Id;
                    account.idAccountReporting = accountGroup.idAccountReportingDefault;
                    account.TypeAccount = accountGroup.TypeAccountDefault;
                    account.TitleLocalAccount = accountGroup.TitleLocalAccountGroup + $" {accountCode}";
                    account.TitleEnglishAccount = accountGroup.TitleEnglishAccountGroup + $" {accountCode}";
                    account.CommitChanges();

                    VerumInstance.SaveChanges(true);
                    job.Report(TypeJobSuccessEnum.Warning, BOResult.BCInvalidAccountNumber, "Business Center API", contextInfo: bookingRunCode, message: $"Missing account number {accountCode} created");
                }
                else
                {
                    job.Report(TypeJobSuccessEnum.Warning, BOResult.BCInvalidAccountNumber, "Business Center API", contextInfo: bookingRunCode, message: $"Invalid account number {accountCode}", forBulkCommit: true);
                }
            }
        }

        public List<GeneralLedgerPageResModel.GeneralLedgerValue> GetMainAccountEntries(List<GeneralLedgerPageResModel.GeneralLedgerValue> entry, List<double> VatAmountList, out bool isInvoice)
        {


            isInvoice = false;

            if (entry.Where(x => x.DocumentType.Trim() == "Invoice").ToList().Count > 0)
            {
                if(!(entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim()) && !VatAmountList.Contains(x.Amount)).ToList().Count >1))
                    isInvoice = true;
            }

            if (isInvoice)
            {
                // for invoce case we are getting last entry of entry is main account number.
                return entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim()) &&
                                                                !VatAmountList.Contains(x.Amount))
                                                    .OrderByDescending(i => i.EntryNo).Take(1).ToList();
            }
            else
            {
                entry = entry.OrderBy(x => x.EntryNo).ToList();

                if (entry.Count == 2)
                {
                    if (entry[1].BalAccountType.Trim() == "Bank Account" && entry[1].SourceType.Trim() == "Bank Account")
                    {
                        if (entry.Where(x => x.GenPostingType.Trim() == "").ToList().Count == 0)
                            return entry.Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 1)
                            return entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 2)
                            return entry.Take(1).ToList();
                        else
                            return entry.Take(1).ToList();
                    }

                    else if (entry[1].BalAccountType.Trim() == "G/L Account" && entry[1].SourceType.Trim() == "Bank Account")
                    {
                        if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 0)
                            return entry.Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 1)
                            return entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 2)
                            return entry.Take(1).ToList();
                        else
                            return entry.Take(1).ToList();
                    }

                    else if (entry[1].BalAccountType.Trim() == "Customer" && entry[1].SourceType.Trim() == "Bank Account")
                    {
                        if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 0)
                            return entry.Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 1)
                            return entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 2)
                            return entry.Take(1).ToList();
                        else
                            return entry.Take(1).ToList();
                    }

                    else if (entry[1].BalAccountType.Trim() == "Vendor" && entry[1].SourceType.Trim() == "Vendor")
                    {
                        // change order then get last row
                        if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 0)
                            return entry.OrderByDescending(x => x.EntryNo).Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 1)
                            return entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 2)
                            return entry.Take(1).ToList();
                        else
                            return entry.Take(1).ToList();
                    }

                    else if (entry[1].BalAccountType.Trim() == "Vendor" && entry[1].SourceType.Trim() == "Bank Account")
                    {
                        if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 0)
                            return entry.Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 1)
                            return entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 2)
                            return entry.Take(1).ToList();
                        else
                            return entry.Take(1).ToList();
                    }

                    else if (entry[1].BalAccountType.Trim() == "G/L Account" && entry[1].SourceType.Trim() == "Vendor")
                    {
                        if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 0)
                            return entry.Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 1)
                            return entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 2)
                            return entry.Take(1).ToList();
                        else
                            return entry.Take(1).ToList();
                    }

                    else if (entry[1].BalAccountType.Trim() == "G/L Account" && entry[1].SourceType.Trim() == "")
                    {
                        if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 0)
                            return entry.Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 1)
                            return entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 2)
                            return entry.Take(1).ToList();
                        else
                            return entry.Take(1).ToList();
                    }
                    else if (entry[1].BalAccountType.Trim() == "Bank Account" && entry[1].SourceType.Trim() == "Vendor")
                    {
                        if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 0)
                            return entry.Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 1)
                            return entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 2)
                            return entry.Take(1).ToList();
                        else
                            return entry.Take(1).ToList();
                    }
                    else if (entry[1].BalAccountType.Trim() == "G/L Account" && entry[1].SourceType.Trim() == "Customer")
                    {
                        if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 0)
                            return entry.Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 1)
                            return entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 2)
                            return entry.Take(1).ToList();
                        else
                            return entry.Take(1).ToList();
                    }
                    else
                    {
                        if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 0)
                            return entry.Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 1)
                            entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).Take(1).ToList();

                        else if (entry.Where(x => string.IsNullOrEmpty(x.GenPostingType.Trim())).ToList().Count == 2)
                            return entry.Take(1).ToList();
                        else
                            return entry.Take(1).ToList();
                    }
                }
                else if (entry.Count > 2)
                {
                    if (entry[1].BalAccountType.Trim() == "Bank Account" && entry[1].SourceType.Trim() == "Bank Account")
                        return entry.OrderByDescending(x => x.EntryNo).Take(1).ToList();

                    else if (entry[1].BalAccountType.Trim() == "G/L Account" && entry[1].SourceType.Trim() == "Bank Account")
                        return entry.OrderBy(x => x.EntryNo).Take(1).ToList();

                    else if (entry[1].BalAccountType.Trim() == "Customer" && entry[1].SourceType.Trim() == "Bank Account")
                        return entry.OrderBy(x => x.EntryNo).Take(1).ToList();

                    else if (entry[1].BalAccountType.Trim() == "Vendor" && entry[1].SourceType.Trim() == "Vendor")
                    {
                        var glaccountid = entry.OrderBy(x => x.EntryNo).FirstOrDefault().GLAccountNo;

                        return entry.Where(x => x.BalAccountNo == glaccountid.ToString()).Take(1).ToList();
                    }

                    else if (entry[1].BalAccountType.Trim() == "Vendor" && entry[1].SourceType.Trim() == "Bank Account")
                        return entry.Where(x => !VatAmountList.Contains(x.Amount) && string.IsNullOrEmpty(x.GenPostingType.Trim()))
                            .Take(1).ToList();

                    // 12140, 720
                    else if (entry[1].BalAccountType.Trim() == "G/L Account" && entry[1].SourceType.Trim() == "Vendor")
                        return entry.Where(x => !VatAmountList.Contains(x.Amount) && string.IsNullOrEmpty(x.GenPostingType.Trim()))
                            .OrderByDescending(x => x.EntryNo).Take(1).ToList();

                    else if (entry[1].BalAccountType.Trim() == "G/L Account" && entry[1].SourceType.Trim() == "")
                        return entry.Where(x => !VatAmountList.Contains(x.Amount) && string.IsNullOrEmpty(x.GenPostingType.Trim()))
                            .OrderByDescending(x => x.EntryNo).Take(1).ToList();
                    else if (entry[1].BalAccountType.Trim() == "Bank Account" && entry[1].SourceType.Trim() == "Vendor")
                    {
                        return entry.Where(x => !VatAmountList.Contains(x.Amount) && string.IsNullOrEmpty(x.GenPostingType.Trim()))
                            .OrderBy(x => x.EntryNo).Take(1).ToList();
                    }
                    else if (entry[1].BalAccountType.Trim() == "G/L Account" && entry[1].SourceType.Trim() == "Customer")
                    {
                        return entry.Where(x => !VatAmountList.Contains(x.Amount) && string.IsNullOrEmpty(x.GenPostingType.Trim()))
                            .OrderByDescending(x => x.EntryNo).Take(1).ToList();
                    }
                    else if (entry[1].BalAccountType.Trim() == "G/L Account" && entry[1].SourceType.Trim() == "")
                    {
                        // pending this condition
                    }
                }
            }

            return new List<GeneralLedgerPageResModel.GeneralLedgerValue>();
        }

        public bool IsGeneralEntry(List<GeneralLedgerPageResModel.GeneralLedgerValue> entry, List<double> VatAmountList)
        {
            if (entry.Where(x => x.DocumentType == "Invoice").ToList().Count > 0)
            {
                if (entry.Where(x => x.GenPostingType == " " && !VatAmountList.Contains(x.Amount)).ToList().Count == 0)
                    return false;
            }

            return true;
        }

        public bool IsValidEntryCondition(List<GeneralLedgerPageResModel.GeneralLedgerValue> entry, int i, List<GeneralLedgerPageResModel.GeneralLedgerValue> mainAccountNumber)
        {
            if (!string.IsNullOrEmpty(entry[i].GenPostingType.Trim()))
            {
                if (entry[i].EntryNo == mainAccountNumber.FirstOrDefault().EntryNo)
                    return false;

                //if(mainAccountNumber.Count>1)
                //{
                //    if (mainAccountNumber.Where(x => x.EntryNo != mainAccountNumber.FirstOrDefault().EntryNo &&
                //                            x.EntryNo == entry[i].EntryNo).Count() == 0)
                //        return false;
                //}

                if (entry.Where(x => x.VATAmount == entry[i].Amount && string.IsNullOrEmpty(x.GenPostingType)).Count() > 0)
                    return false;

                // by this condition we can identity is reserve entry of VatAmout or not
                //if(entry.Where(x=>x.Amount == -entry[i].Amount).Count()>0 && entry.Count()>2 && entry.Where(x=>x.VATAmount== -entry[i].Amount).Count()>0)
                //    return false;

                return true;
            }

            return false;
        }

        public BookingRun BusinessCenterBookingRunNew()
        {
            // last import number
            var client = Client.GetBOCollection().GetObservableCollection().AsQueryable().FirstOrDefault();
            var lastnumber = client.BCLastBookingCodeNo + 1;

            client.BCLastBookingCodeNo = lastnumber;
            client.CommitChanges();

            var addedZero = "0000" + lastnumber;

            var bookingRun = new BookingRun();
            bookingRun.New();

            bookingRun.ImportedDate = DateTime.UtcNow;
            bookingRun.ImportFileName = "BusinessCenterAPI";
            bookingRun.ImportFileDate = DateTime.UtcNow;
            bookingRun.idClient = VerumInstance.IdClient;
            bookingRun.BookingRunCode = "BC" + addedZero.Substring(addedZero.Length - 4) + "-" + DateTime.Now.ToString("yyyy-MM-dd");
            bookingRun.VersionCode = 0;
            bookingRun.StatusPreliminary = false;
            bookingRun.PeriodYear = 0;
            bookingRun.PeriodMonth = 0;
            bookingRun.SerialNum = "0";
            bookingRun.RecordsImported = 0;
            bookingRun.RecordsOmitted = 0;
            bookingRun.CommitChanges();
            VerumInstance.SaveChanges(true);

            return bookingRun;
        }

        public void GetLastBCUpdatedDate(out string lastEntryDate)
        {
            BOCollClient = Client.GetBOCollectionLastEntryBC();
            client = new ObservableCollection<Client>();

            foreach (var BO in BOCollClient)
                client.Add(BO);

            if (client.Count > 0)
            {
                lastEntryDate = Convert.ToDateTime(client.FirstOrDefault().BCLastUpdate).ToString("yyyy-MM-ddTHH:mm:ss.fffffffZ");
                return;
            }

            BOColl = BookRecord.GetBOCollectionLastEntryBC();
            bookRecords = new ObservableCollection<BookRecord>();

            foreach (var BO in BOColl)
                bookRecords.Add(BO);

            if (bookRecords.Count > 0)
            {
                lastEntryDate = bookRecords.FirstOrDefault().DateCreated.ToString("yyyy-MM-ddTHH:mm:ss.fffffffZ");
                return;
            }

            lastEntryDate = "";
        }
    }
}
