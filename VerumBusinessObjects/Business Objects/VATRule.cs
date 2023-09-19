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
    using VerumBusinessObjects.Properties;
    using System.ComponentModel.DataAnnotations;

    /// <summary>
    /// Business Object <c>BookRecord</c>: Booking record at account level with debit and credit. Book records can be of actual, baseline or plan type
    /// </summary>    
    public partial class VATRule : BusinessObject<tVATRule>, IVATRule
    {
        /// <summary>
        /// Calculates the net amount based on the transaction amount and VAT rule
        /// </summary>
        /// <param name="grossAmount">Gross transaction amount</param>
        /// <param name="transactionDate">Transaction date used to determine applicable VAT rate depending on possible future VAT rate change</param>
        /// <returns>Net transaction amount. Takes reverse charge option into account</returns>
        internal double NetAmount(double grossAmount, DateTime transactionDate)
        {
            if (!FlagReverseCharge) return grossAmount / (1.0 + VATRate(transactionDate));        // deduct VAT from gross amount
            else return grossAmount;                                                             // except for reverse charge where amount is already net
        }

        /// <summary>
        /// Calculates the gross amount based on the transaction amount and VAT rule
        /// </summary>
        /// <param name="netAmount">Gross transaction amount</param>
        /// <param name="transactionDate">Transaction date used to determine applicable VAT rate depending on possible future VAT rate change</param>
        /// <returns>Net transaction amount. Takes reverse charge option into account</returns>
        internal double GrossAmount(double netAmount, DateTime transactionDate)
        {
            if (!FlagReverseCharge) return netAmount * (1.0 + VATRate(transactionDate));        // add VAT to net amount
            else return netAmount;                                                             // except for reverse charge where amount is already net
        }

        /// <summary>
        /// Determines applicable VAT rate based on transaction date
        /// </summary>
        /// <param name="transactionDate">Date of transaction</param>
        /// <returns>Applicable VAT rate at transaction date</returns>
        internal double VATRate(DateTime transactionDate)
        {
            // determine applicable VAT rate based on transaction date
            if (DateRateChange >= transactionDate || !RateFuture.HasValue) return RateCurrent;
            else return RateFuture.Value;
        }

        internal void BookVATInput(DateTime date, double amount, Account payablesAccount, Account cashAccount, PlanElementInstance planElementInstance)
        {
            if (FlagReverseCharge)
            {
                // Book input VAT to receivables/cash account
                BookRecord.BookPlannedRecord(date, amount * VATRate(date), planElementInstance, AccountVATInputParent, payablesAccount);
                // Book receivables/cash account to output VAT 
                BookRecord.BookPlannedRecord(date, amount * VATRate(date), planElementInstance, payablesAccount, AccountVATOutputParent);
            }
            else
            {
                if (!idAccountVATBalance.HasValue) throw new Exception(Properties.Errors.VATRuleVATBalanceNotDefined);

                // Book input VAT to VAT receivables account
                BookRecord.BookPlannedRecord(date, amount * VATRate(date), planElementInstance, AccountVATInputParent, payablesAccount);
                // Book settlement of input VAT receivable via VAT balanceing account
                BookRecord.BookPlannedRecord(date.AddDays(SettlementTerm), amount * VATRate(date), planElementInstance, cashAccount, AccountVATBalanceParent);
            }
        }

        internal void BookVATOutput(DateTime date, double amount, Account receivablesAccount, Account cashAccount, PlanElementInstance planElementInstance)
        {
            if (FlagReverseCharge)
            {
                // Book output VAT to payables/cash account
                BookRecord.BookPlannedRecord(date, amount * VATRate(date), planElementInstance, receivablesAccount, AccountVATOutputParent);
                // Book payables/cash account to input VAT 
                BookRecord.BookPlannedRecord(date, amount * VATRate(date), planElementInstance, AccountVATInputParent, receivablesAccount);
            }
            else
            {
                if (!idAccountVATBalance.HasValue) throw new Exception(Properties.Errors.VATRuleVATBalanceNotDefined);

                // Book input VAT to VAT receivables account
                BookRecord.BookPlannedRecord(date, amount * VATRate(date), planElementInstance, receivablesAccount, AccountVATOutputParent);
                // Book settlement of input VAT receivable via VAT balanceing account
                BookRecord.BookPlannedRecord(date.AddDays(SettlementTerm), amount * VATRate(date), planElementInstance, AccountVATBalanceParent, cashAccount);
            }
        }

        public bool SelectViaKey(string code)
        {
            var attr = (StringLengthAttribute)typeof(tVATRule).GetProperty("VATRuleCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (code.Length > len)
                    code = code.Substring(0, len);
            }

            var obj = VerumInstance.Context.tVATRule.Where(b => b.VATRuleCode == code && b.idClient == VerumInstance.IdClient);

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

        public static BOCollection<VATRule, tVATRule> GetBOCollection()
        {
            // select all VAT rules for the current client
            var query = VerumInstance.Context.tVATRule.Where<tVATRule>(b => b.idClient == VerumInstance.IdClient).OrderBy(b => b.TitleVATRule);
            return new BOCollection<VATRule, tVATRule>(query);
        }

        public override void _CustomInit()
        {
            if (!Bound)
                idClient = VerumInstance.IdClient;
        }

    }
}
