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

    public partial interface IPlanHRExpenseGroup
    {

    }

    public partial class PlanHRExpenseGroup : BusinessObject<tPlanHRExpenseGroup>, IPlanHRExpenseGroup
    {
        public List<PlanHRExpense> GetExpenses( DateTime date)
        {
            List<PlanHRExpense> list = new List<PlanHRExpense>();
            string lasttitle = "";

            if (Bound)
            {
                if (_Expenses == null)
                    _Expenses = VerumInstance.Context.tPlanHRExpense.Where(b => b.idExpenseGroup == Id).OrderBy( b => b.TitleExpense).ThenByDescending(b => b.DateValidTo);

                foreach ( var item in _Expenses)
                {
                    if ((item.DateValidTo == null || item.DateValidTo >= date) && item.TitleExpense != lasttitle)
                    {
                        var obj = new PlanHRExpense();
                        obj.data = item;
                        list.Add(obj);
                        lasttitle = item.TitleExpense;
                    }
                }

                return (list);
            }
            else
            {
                return null;            }
        }

        public BOCollection<PlanHRExpense, tPlanHRExpense> PlanHRExpenseGroupChildren()
        {
            // select all expense instances for the expense group
            var query = _db.tPlanHRExpense.Where<tPlanHRExpense>(b => b.idExpenseGroup == Id).OrderBy(b => b.DateValidTo);
            return new BOCollection<PlanHRExpense, tPlanHRExpense>(query);
        }

        public static BOCollection<PlanHRExpenseGroup, tPlanHRExpenseGroup> GetBOCollection(Guid idPlan)
        {
            var query = VerumInstance.Context.tPlanHRExpenseGroup.Where<tPlanHRExpenseGroup>(b => b.idPlan == idPlan).OrderBy(b => b.TitleExpenseGroup);
            return new BOCollection<PlanHRExpenseGroup, tPlanHRExpenseGroup>(query);
        }

        public PlanHRExpenseGroup GetCopy(Plan targetPlan)
        {
            PlanHRExpenseGroup target;

            if (Bound)
            {
                try
                {
                    //VerumInstance.TransactionStart();

                    // seek schedule if already migrated to targetPlan
                    var query1 = VerumInstance.Context.tPlanHRExpenseGroup.SingleOrDefault<tPlanHRExpenseGroup>(b => b.idPlan == targetPlan.Id && b.IdMigrate == this.Id);
                    var query2 = VerumInstance.Context.tPlanHRExpenseGroup.SingleOrDefault<tPlanHRExpenseGroup>(b => b.idPlan == targetPlan.Id && b.TitleExpenseGroup == this.TitleExpenseGroup);

                    if (query1 != null)
                        target = new PlanHRExpenseGroup(query1.Id);
                    else if (query2 != null)
                        target = new PlanHRExpenseGroup(query2.Id);
                    else
                    {
                        target = new PlanHRExpenseGroup();
                        target.Clone(this);
                        target.idPlan = targetPlan.Id;
                        target.CommitChanges();

                        foreach (PlanHRExpense item in PlanHRExpenseGroupChildren())
                            if (item.Copy(target) != BOResult.Success) throw new InvalidOperationException("Error during plan HR expense group copy");
                    }

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
            var attr = (StringLengthAttribute)typeof(tPlanHRExpenseGroup).GetProperty("TitleExpenseGroup").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (title.Length > len)
                    title = title.Substring(0, attr.MaximumLength);
            }

            var obj = VerumInstance.Context.tPlanHRExpenseGroup.Where(b => b.TitleExpenseGroup == title && b.idPlan == idPlan);

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

        // PRIVATE FIELDS
        IOrderedQueryable<tPlanHRExpense> _Expenses;

        // PRIVATE METHODS
        public override void _CustomInit()
        {
            _Expenses = null; ;
        }
    }
}
