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

    /// <summary>
    /// Business Object <c>PlanInflationRule</c>: Defines the period and rate of inflatio. Specific per plan.
    /// </summary>    
    public partial class PlanInflationRule : BusinessObject<tPlanInflationRule>, IPlanInflationRule
    {
        partial void _InflationIntervalValid(short value, ref bool valid)
        {
            if (Enum.IsDefined(typeof(TypeRegularPeriods), value)) valid = true;
            else throw new BOException("Invalid inflation interval assigned", BOResult.InflationIntervalInvalid, value.ToString());
        }

        /// <summary>
        /// Calculates the inflation factor for a specified transaction date with reference to a specified price date. Inflation is calculated as of the first day of 
        /// each period as specified by the InflationRule InflationInterval (1, 3, 6 or 12 months) starting with January each year.
        /// </summary>
        /// <param name="CurrentDate">Transaction date</param>
        /// <param name="PriceDate">Date for which the original price is valid</param>
        /// <returns>Inflation factor by which the original price has to be adjusted as of the transaction date under consideration of the inflation period
        /// according to the inflation rule.</returns>
        public double InflationFactor(DateTime CurrentDate, DateTime PriceDate)
        {
            if (CurrentDate > PriceDate)
            {
                int price_date_index = BOUtilities.YearMonthIndex(PriceDate) - 1;
                int current_date_index = CurrentDate.Year * 12 + (int)Math.Truncate((double)((CurrentDate.Month - 1)
                                                / InflationInterval)) * InflationInterval;
                return (Math.Pow(1.0 + InflationRateAnnual, (current_date_index - price_date_index) / 12.0));
            }
            else
                return 1.0;
        }

        public PlanInflationRule GetCopy(Plan targetPlan)
        {
            PlanInflationRule target;

            if (Bound)
            {
                try
                {
                    //VerumInstance.TransactionStart();

                    // seek object if already migrated to targetPlan
                    var query = VerumInstance.Context.tPlanInflationRule.SingleOrDefault<tPlanInflationRule>(b => b.idPlan == targetPlan.Id && b.IdMigrate == this.Id);

                    if (query == null)
                    {
                        target = new PlanInflationRule();
                        target.Clone(this);
                        target.idPlan = targetPlan.Id;
                        target.CommitChanges();

                    }
                    else
                        target = new PlanInflationRule(query.Id);

                    VerumInstance.SaveChanges();

                    return target;
                }
                catch (Exception ex)
                {
                    BOUtilities.TraceErrors(ex);
                    //VerumInstance.TransactionRollback();
                }
            }

            return null;
        }

        public bool SelectViaKey(string title, Guid idPlan)
        {
            var attr = (StringLengthAttribute)typeof(tPlanInflationRule).GetProperty("TitleInflationRule").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (title.Length > len)
                    title = title.Substring(0, len);
            }

            var obj = VerumInstance.Context.tPlanInflationRule.Where(b => b.TitleInflationRule == title && b.idPlan == idPlan);

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

    }
}
