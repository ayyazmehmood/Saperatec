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
    using VerumBusinessObjects.Framework;
    using System.ComponentModel.DataAnnotations;

    public partial interface IDepreciationRule
    {

    }

    /// <summary>
    /// Business Object <c>DepreciationRule</c>: A depreciation rule defines a pair of accounts for activation and depreciation 
    /// in combination with the number of periods and length of periods in month for depreciation.
    /// </summary>    
    public partial class DepreciationRule : BusinessObject<tDepreciationRule>, IDepreciationRule
    {
        /// <summary>
        /// Prepares a depreciation schedule table for the specified transaction date and amount according to the loaded depreciation rule. 
        /// The switch flagAggregate allows to aggregate several transactions per period in the depreciation table for repeating plan elements.
        /// </summary>
        /// <param name="transactionDate">Booking date of the underlying transaction</param>
        /// <param name="amount">Net amount of the underlying transaction</param>
        /// <param name="flagAggregate">Switch indicates, that decreciation of several subsequent transactions shall be aggregated.
        /// The method call will only prepare a table of depreciation transactions without commiting these to booking records.
        /// The method CommitDepreciation will later book the aggregated depreciation transactions.</param>
        public void Depreciate( DateTime transactionDate, double amount, PlanElementInstance planElementInstance, Account bookingAccount, bool flagAggregate = false)
        {
            if (_depreciation_table.Count == 0)
            {
                _depr_first_month_index = BOUtilities.YearMonthIndex(transactionDate);  // determine year month index for first depreciation tx
                _depr_next_date = new DateTime(transactionDate.Year, transactionDate.Month, DateTime.DaysInMonth(transactionDate.Year, transactionDate.Month));
            }

            int list_index = _DepreciationNextIndex(transactionDate);                   // determine index of depreciation schedule list entry for frist depr tx


            for (int i = 0; i < NumberOfPeriods; i++)                              // for defined NumberOfPeriods
            {
                // depreciate only up to end of plan (DateValidTo)
                if (_depr_next_date > planElementInstance.PlanParent.DateValidTo) break;

                while (_depreciation_table.Count <= list_index)                              // extend _depreciation_table to next list_index
                {
                    _depreciation_table.Add(new TxScheduleItem(_depr_next_date, 0));
                    _depr_next_date = new DateTime( _depr_next_date.AddMonths(PeriodInMonths).Year, _depr_next_date.AddMonths(PeriodInMonths).Month, 
                                                    DateTime.DaysInMonth(_depr_next_date.AddMonths(PeriodInMonths).Year, _depr_next_date.AddMonths(PeriodInMonths).Month));
                }

                _depreciation_table[list_index].Amount += amount / NumberOfPeriods;         // add depreciation amount for period to item
                list_index++;
            }

            if (!flagAggregate) BookDepreciation(planElementInstance, bookingAccount);                                 // Commit if flagAggregate is not set
        }

        /// <summary>
        /// Creates booking records for recorded depreciation. Must be called after aggregated depreciation of several underlying transactions via Depreciate method
        /// in order to book the depreciation transactions.
        /// </summary>
        /// <param name="planElementInstance">Provides information such as client and booking text</param>
        public void BookDepreciation(PlanElementInstance planElementInstance, Account bookingAccount)
        {
            if (AccountDepreciationParent != null)
                BookRecord.BookPlannedTransactionSchedule(_depreciation_table, planElementInstance, AccountDepreciationParent, 
                    AccountActivationParent, DateTime.MinValue, TitleDepreciationRule);
            else
                BookRecord.BookPlannedTransactionSchedule(_depreciation_table, planElementInstance, bookingAccount,
                    AccountActivationParent, DateTime.MinValue, TitleDepreciationRule);

        }

        public static BOCollection<DepreciationRule, tDepreciationRule> GetBOCollection()
        {
            // select all depreciation rules for the current client
            var query = VerumInstance.Context.tDepreciationRule.Where<tDepreciationRule>(b => b.idClient == VerumInstance.IdClient).OrderBy(b => b.TitleDepreciationRule);
            return new BOCollection<DepreciationRule, tDepreciationRule>(query);
        }

        // INTERNAL FIELDS

        private List<TxScheduleItem> _depreciation_table = new List<TxScheduleItem>();
        private DateTime _depr_next_date;
        private int _depr_first_month_index;

        /// <summary>
        /// Calculates an index to the depreciation transaction table based on the specified date, the start date of depreciation and the PeriodInMonths
        /// according to the depreciation rule.
        /// </summary>
        /// <param name="date">Date for which index is calculated</param>
        /// <returns>index to _tx_depreciation table</returns>
        private int _DepreciationNextIndex(DateTime date)
        {
            var index = BOUtilities.YearMonthIndex(date);

                //date.Year * 12 + date.Month;
            var adjusted_periods = (decimal)(index - _depr_first_month_index + PeriodInMonths - 1) / PeriodInMonths;

            return (int)Math.Ceiling(adjusted_periods) * PeriodInMonths;
        }

        public bool SelectViaKey(string title)
        {
            var attr = (StringLengthAttribute)typeof(tDepreciationRule).GetProperty("TitleDepreciationRule").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (title.Length > len)
                    title = title.Substring(0, attr.MaximumLength);
            }

            var obj = VerumInstance.Context.tDepreciationRule.Where(b => b.TitleDepreciationRule == title && b.idClient == VerumInstance.IdClient);

            if (obj.Count() == 0)
            {
                return false;
            }
            else
            {
                Id = obj.FirstOrDefault().Id;
                return true;
            }
        }

        partial void _TypeDepreciationRuleValid(short value, ref bool valid)
        {
            if (Enum.IsDefined(typeof(TypeDepreciationRuleEnum), value)) valid = true;
            else throw new BOException("Invalid depreciation rule type code assigned", BOResult.DepreciationRuleTypeInvalid, value.ToString());
        }

        public override void _CustomInit()
        {
            if (!Bound)
                idClient = VerumInstance.IdClient;
        }

    }
}
