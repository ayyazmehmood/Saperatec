namespace VerumBusinessObjects
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;
    using System.Dynamic;
    using System.Diagnostics;
    using System.Collections.ObjectModel;
    using VerumBusinessObjects.Framework;
    using System.ComponentModel.DataAnnotations;

    public partial class PlanParameter : BusinessObject<tPlanParameter>, IPlanParameter
    {

        public static BOCollection<PlanParameter, tPlanParameter> GetBOCollection(Guid idPlan, TypePlanParameterEnum parType)
        {
            // select all parameters of type parType for the plan idPlan
            var query = VerumInstance.Context.tPlanParameter.Where<tPlanParameter>(b => b.idPlan == idPlan && b.TypePlanParameter == (short)parType).OrderBy(b => b.TitlePlanParameter);
            return new BOCollection<PlanParameter, tPlanParameter>(query);
        }

        public bool SelectViaKey(string title, Guid idPlan)
        {
            var attr = (StringLengthAttribute)typeof(tPlanParameter).GetProperty("TitlePlanParameter").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (title.Length > len)
                    title = title.Substring(0, len);
            }

            var obj = VerumInstance.Context.tPlanParameter.Where(b => b.TitlePlanParameter == title && b.idPlan == idPlan);

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

        public PlanParameter GetCopy(Plan targetPlan)
        {
            PlanParameter target;

            if (Bound)
            {
                try
                {
                    //VerumInstance.TransactionStart();

                    // seek object if already migrated to targetPlan
                    var query = VerumInstance.Context.tPlanParameter.SingleOrDefault<tPlanParameter>(b => b.idPlan == targetPlan.Id && b.IdMigrate == this.Id);

                    if (query == null)
                    {
                        target = new PlanParameter();
                        target.Clone(this);
                        target.idPlan = targetPlan.Id;
                        target.CommitChanges();

                    }
                    else
                        target = new PlanParameter(query.Id);

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

    }
}
