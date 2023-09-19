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

    public partial interface IPlanHRExpense
    {

    }

    public partial class PlanHRExpense : BusinessObject<tPlanHRExpense>, IPlanHRExpense
    {
        public BOResult Copy(PlanHRExpenseGroup targetGroup)
        {
            if (Bound)
            {
                try
                {
                    var targetItem = new PlanHRExpense();
                    targetItem.Clone(this);
                    targetItem.idExpenseGroup = targetGroup.Id;
                    targetItem.CommitChanges();

                    return BOResult.Success;
                }
                catch (Exception ex)
                {
                    BOUtilities.TraceErrors(ex);
                    return BOResult.PlanItemCopyError;
                }
            }

            return BOResult.GeneralError;
        }

        public bool SelectViaKey(string title, Guid idExpenseGroup, DateTime? valid_to = null)
        {
            IQueryable<tPlanHRExpense> obj;

            var attr = (StringLengthAttribute)typeof(tPlanHRExpense).GetProperty("TitleExpense").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (title.Length > len)
                    title = title.Substring(0, attr.MaximumLength);
            }

            if (valid_to.HasValue)
            {
                // Search only by date (ignore time )
                valid_to = valid_to.Value.Date;

                obj = VerumInstance.Context.tPlanHRExpense.Where(b => b.TitleExpense == title && b.idExpenseGroup == idExpenseGroup && b.DateValidTo == valid_to);
            }
            else
                obj = VerumInstance.Context.tPlanHRExpense.Where(b => b.TitleExpense == title && b.idExpenseGroup == idExpenseGroup && b.DateValidTo == null);

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
