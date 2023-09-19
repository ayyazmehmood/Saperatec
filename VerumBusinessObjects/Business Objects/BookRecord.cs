namespace VerumBusinessObjects
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;
    using System.Dynamic;
    using System.Diagnostics;
    using System.Data.Entity.Validation;
    using System.Collections.Generic;
    using System.Collections;
    using System.ComponentModel;
    using VerumBusinessObjects.Framework;
    using DocumentFormat.OpenXml.Office2010.Excel;
    using DocumentFormat.OpenXml.Drawing.Diagrams;
    using System.Configuration;

    public partial interface IBookRecord
    {

    }

    public partial class tBookRecord
    {
        // Navigation property referencing tBookTransaction
        [ForeignKey("idBookingRecord")]
        public virtual ICollection<tBookTransaction> tBookTransaction { get; set; }
    }
    /// <summary>
    /// Business Object <c>BookRecord</c>: Booking record at account level with debit and credit. Book records can be of actual, baseline or plan type
    /// </summary>    
    public partial class BookRecord : BusinessObject<tBookRecord>, IBookRecord
    {
        /// <summary>
        /// Creates planned booking records for each TxScheduleItem in a list. 
        /// </summary>
        /// <param name="txScheduleItems">List of TxScheduleItems</param>
        /// <param name="planElementInstance">PlanElementInstance providing information such as client and booking text</param>
        /// <param name="accountDebit">Account for debit record</param>
        /// <param name="accountCredit">Account for credit record</param>
        /// <param name="comment">Optional booking record comment</param>
        /// <param name="DateIgnoreTransactionsUntil">All transactions up tup this date (included) will be ignored. Used for advance payments.</param>
        public static void BookPlannedTransactionSchedule(List<TxScheduleItem> txScheduleItems,
                                                            PlanElementInstance planElementInstance,
                                                            Account accountDebit, Account accountCredit,
                                                            DateTime DateIgnoreTransactionsUntil,
                                                            string comment = "",
                                                            int DaysOffset = 0,
                                                            bool flagAccountOpening = false)
        {
            foreach (var o in txScheduleItems)
            {
                // create records only up to end date of plan (DateValidTo)
                if (o.Date.AddDays(DaysOffset) > planElementInstance.PlanParent.DateValidTo) break;
                else
                    if (o.Date.AddDays(DaysOffset).Date > DateIgnoreTransactionsUntil)
                    BookPlannedRecord(o.Date.AddDays(DaysOffset), o.Amount, planElementInstance, accountDebit, accountCredit, comment, null, flagAccountOpening);
            }
        }

        /// <summary>
        /// Books a planned booking record
        /// </summary>
        /// <param name="transactionDate">Booking date</param>
        /// <param name="transactionAmount">Booking amount</param>
        /// <param name="planElementInstance">PlanElementInstance providing information such as client and booking text</param>
        /// <param name="accountDebit">Account for debit record</param>
        /// <param name="accountCredit">Account for credit record</param>
        /// <param name="comment">Optional booking record comment</param>
        public static void BookPlannedRecord(DateTime transactionDate, double transactionAmount,
                                                    PlanElementInstance planElementInstance,
                                                    Account accountDebit, Account accountCredit,
                                                    string comment = "", CostCenter costCenter = null,
                                                    bool flagAccountOpening = false)
        {
            transactionDate = transactionDate.Date;
            var fromDate = planElementInstance.PlanParent.DateValidFrom.Date;
            var toDate = planElementInstance.PlanParent.DateValidTo.Date;

            if (transactionDate >= fromDate && transactionDate <= toDate)
            {
                BookRecord record = new BookRecord();
                record.New();
                record.idClient = planElementInstance.PlanParent.idClient;
                record.idPlanElementInstance = planElementInstance.Id;
                record.idAccountDebit = accountDebit.Id;
                record.idAccountCredit = accountCredit.Id;
                record.TypeBookRecord = (short)TypeBookRecordEnum.Plan;

                if (costCenter == null)
                    record.idCostCenterBookRecord = planElementInstance.PlanElementParent.idCostCenterPlanElement;
                else
                    record.idCostCenterBookRecord = costCenter.Id;

                record.ReferenceIDBookRecord = planElementInstance.PlanElementParent.ReferenceIDPlanElement;
                record.TitleBookRecord = planElementInstance.PlanElementParent.TitlePlanElement;
                record.BookingDate = transactionDate;
                record.Amount = transactionAmount;
                record.BookRecordComment = comment;

                record.FlagAccountOpening = flagAccountOpening;

                record.AddTransaction(accountDebit, 0, transactionAmount, planElementInstance, flagAccountOpening);
                record.AddTransaction(accountCredit, transactionAmount, 0, planElementInstance, flagAccountOpening);
                record.CommitChanges();                // ACTION commit changes only once all records have been created
            }
        }

        /// <summary>
        /// Add transaction to new book record. Book record must not yet be committed. 
        /// All transaction debit and credit amounts must match before book record can be committed
        /// </summary>
        /// <param name="accountCode">Code of the booking account</param>
        /// <param name="amount">Transaction amount. Negative numbers are booked as debit.</param>
        /// <returns></returns>
        public bool AddTransaction(int accountCode, double credit, double debit, PlanElementInstance planElementInstance = null, bool flagAccountOpening = false, int? BCTransactionNo = null, int? BCGeneralLedgerPageAPIEntryNo = null)
        {
            // Transactions can only be added while a new book record is not yet comitted
            if (Bound) return false;

            // find account Id
            var obj = VerumInstance.Context.tAccount.Where(b => b.AccountCode == accountCode && b.idClient == VerumInstance.IdClient);
            if (obj.Count() == 0) return false;
            else
            {
                var acc = new Account();
                acc.data = obj.First();

                return AddTransaction(acc, credit, debit, planElementInstance, flagAccountOpening, BCTransactionNo: BCTransactionNo, BCGeneralLedgerPageAPIEntryNo: BCGeneralLedgerPageAPIEntryNo);
            }
        }

        /// <summary>
        /// Add transaction to new book record. Book record must not yet be committed. 
        /// All transaction debit and credit amounts must match before book record can be committed
        /// </summary>
        /// <param name="accountId">Guid of the booking account</param>
        /// <param name="amount">Transaction amount. Negative numbers are booked as debit.</param>
        /// <returns></returns>
        public bool AddTransaction(Account accountTx, double credit, double debit, PlanElementInstance planElementInstance = null, bool flagAccountOpening = false, int? BCTransactionNo = null, int? BCGeneralLedgerPageAPIEntryNo = null)
        {
            if (Bound) return false;


            if (_BookTransactions == null) _BookTransactions = new List<BookTransaction>();
            var tx = new BookTransaction();
            tx.New();
            tx.idBookingRecord = Id;
            tx.idAccountBooking = accountTx.Id;

            debit = Math.Round(debit, 2);
            credit = Math.Round(credit, 2);

            tx.AmountDebit = debit;
            tx.AmountCredit = credit;

            _TotalDebit += debit;
            _TotalCredit += credit;

            // The following data is redundant and purely for fast reporting purpose (data warehouse functionality)
            tx.TypeBookRecord = TypeBookRecord;
            tx.BookingDate = BookingDate;
            tx.MonthIndex = BOUtilities.YearMonthIndex(BookingDate);
            tx.FlagAccountOpening = flagAccountOpening;
            tx.ReferenceIDBookTransaction = ReferenceIDBookRecord; // referenceID;

            if (accountTx.AccountReportingParent == null)
            {
                tx.idAccountReport = accountTx.Id;
                tx.AccountCodeReport = accountTx.AccountCode;
            }
            else
            {
                tx.idAccountReport = accountTx.AccountReportingParent.Id;
                tx.AccountCodeReport = accountTx.AccountReportingParent.AccountCode;
            }


            if (CostCenterBookRecordParent != null)
            {
                tx.idCostCenter = idCostCenterBookRecord;
                tx.CostCenterCode = CostCenterBookRecordParent.CostCenterCode;
            }

            if (planElementInstance != null)
            {
                tx.idPlan = planElementInstance.PlanParent.Id;
                tx.idPlanElement = planElementInstance.PlanElementParent.Id;
            }

            if (BCTransactionNo != null)
                tx.BCTransactionNo = BCTransactionNo;

            if (BCGeneralLedgerPageAPIEntryNo != null)
                tx.BCGeneralLedgerPageAPIEntryNo = BCGeneralLedgerPageAPIEntryNo;

            _BookTransactions.Add(tx);
            return true;
        }

        public double TotalDebit { get => Math.Round(_TotalDebit, 2); set => _TotalDebit = value; }
        public double TotalCredit { get => Math.Round(_TotalCredit, 2); set => _TotalCredit = value; }

        public List<BookTransaction> _BookTransactions;
        double _TotalDebit = 0;
        double _TotalCredit = 0;

        public override BOResult _CustomCommitBefore()
        {
            if (AccountCreditParent != null)
                AccountCodeCredit = AccountCreditParent.AccountCode;
            else
                return (BOResult.GeneralError);

            if (AccountDebitParent != null)
                AccountCodeDebit = AccountDebitParent.AccountCode;
            else
                return (BOResult.GeneralError);

            if (Math.Round(_TotalCredit, 2) != Math.Round(_TotalDebit, 2))
                return (BOResult.BookRecordUnbalancedTransactions);
            else
                return (BOResult.Success);

        }

        public override void _CustomCommitAfter()
        {
            foreach (var o in _BookTransactions)
            {
                o.CommitChanges();
            }
        }

        public override void _CustomInit()
        {
            if (!Bound)
                idClient = VerumInstance.IdClient;
        }

        public static string CommitChangesBulk(List<tBookRecord> tBookRecords, List<tBookTransaction> tBookTransactions)
        {
                using (var transaction = VerumInstance.Context.Database.BeginTransaction())
                {
                    try
                    {
                        VerumInstance.Context.tBookRecord.AddRange(tBookRecords);
                        VerumInstance.Context.tBookTransaction.AddRange(tBookTransactions);

                        VerumInstance.Context.SaveChanges();

                        // Commit the transaction if everything is successful
                        transaction.Commit();

                        // return blank if there is no error
                        return string.Empty;
                    }
                    catch (Exception ex)
                    {
                        // Rollback the transaction in case of an error
                        transaction.Rollback();
                        Console.WriteLine($"An error occurred: {ex.Message}");

                        return ex.Message;
                    }
            }
        }

        public static BOCollection<BookRecord, tBookRecord> GetBOCollection(Guid bookingRunId)
        {
            // select all reference codes for the current client
            var query = VerumInstance.Context.tBookRecord.Where<tBookRecord>(b => b.idClient == VerumInstance.IdClient && b.idBookingRun == bookingRunId);
            return new BOCollection<BookRecord, tBookRecord>(query);
        }

        /// <summary>
        /// This function are using for getting last date entered recored into tBookRecord 
        /// that entry are entered by Busines Center API i.e. GeneralLedgerPage.
        /// </summary>
        /// <returns></returns>
        public static BOCollection<BookRecord, tBookRecord> GetBOCollectionLastEntryBC()
        {
            var query = VerumInstance.Context.tBookRecord.Where<tBookRecord>(b => b.idClient == VerumInstance.IdClient && b.BCDateUpdated > DateTime.MinValue).OrderByDescending(b => b.BCDateUpdated).Take(1);

            if (query.FirstOrDefault() == null)
                query = VerumInstance.Context.tBookRecord.Where<tBookRecord>(b => b.idClient == VerumInstance.IdClient).OrderByDescending(b => b.DateCreated).Take(1);

            return new BOCollection<BookRecord, tBookRecord>(query);
        }

        public static IQueryable<tBookRecord> GetBookRecordTransaction(List<int> BCTransactionNos)
        {
            var query = VerumInstance.Context.tBookRecord
                .Where(b => b.idClient == VerumInstance.IdClient && BCTransactionNos.Select(i => (int?)i).ToList().Contains(b.BCTransactionNo))
                .Include(x => x.tBookTransaction);

            return query;
        }

        public static IQueryable<tBookRecord> GetBookRecord(List<int> BCTransactionNos)
        {
            var query = VerumInstance.Context.tBookRecord
                .Where(b => b.idClient == VerumInstance.IdClient && BCTransactionNos.Select(i => (int?)i).ToList().Contains(b.BCTransactionNo));

            return query;
        }

        public static bool UpdateBookRecordAndTransactionAmount(double vatAmountDr, double vatAmountCr, double AmountDr, double AmountCr, Guid? VatTranGuid, Guid? TranGuid, Guid BookRecordGuid, double totalAmoutRecord)
        {
                using (var transaction = VerumInstance.Context.Database.BeginTransaction())
                {
                    try
                    {
                        var updateTime = DateTime.UtcNow;
                        
                        var bookr = VerumInstance.Context.tBookRecord.Where(x=>x.Id == BookRecordGuid && x.BCTransactionNo > 0).FirstOrDefault();
                        var transactions = VerumInstance.Context.tBookTransaction.Where(x=>x.idBookingRecord == BookRecordGuid).ToList();
                        var mainTransaction = transactions.Where(x => x.Id != VatTranGuid && x.Id != TranGuid).FirstOrDefault();
                        var vattran = transactions.Where(x => x.Id == VatTranGuid).FirstOrDefault();
                        var tran = transactions.Where(x => x.Id == TranGuid).FirstOrDefault();

                        if (mainTransaction == null || tran == null)
                            return false;

                        if(bookr != null)
                        {

                            double Debit = vatAmountDr + AmountDr;
                            double Credit = vatAmountCr + AmountCr;

                            double mainCr  = Debit - Credit > 0d ? Debit - Credit : 0d;
                            double mainDr  = Debit - Credit < 0d ? Credit - Debit: 0d;

                            if(vattran != null)
                            {
                                vattran.AmountCredit = Math.Round(vatAmountCr,2);
                                vattran.AmountDebit = Math.Round(vatAmountDr,2);
                                vattran.DateUpdated = updateTime;
                            }

                            tran.AmountCredit = Math.Round(AmountCr, 2);
                            tran.AmountDebit = Math.Round(AmountDr, 2);
                            tran.DateUpdated = updateTime;

                            mainTransaction.AmountCredit = Math.Round(mainCr, 2);
                            mainTransaction.AmountDebit = Math.Round(mainDr, 2);
                            mainTransaction.DateUpdated = updateTime;

                            bookr.DateUpdated = updateTime;
                            bookr.Amount = Math.Round(totalAmoutRecord, 2);
                        }

                        VerumInstance.Context.SaveChanges();

                        transaction.Commit();

                        return true;
                    }
                    catch (Exception)
                    {
                        transaction.Rollback();
                        return false;
                    }
                }
        }

        private string _bcEntryNumber;

        // Property to get and set the BCEntryNumber
        public string BCEntryNumber
        {
            get { return _bcEntryNumber; }
            set
            {
                _bcEntryNumber = value;
            }
        }
    }
}
