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

    public partial class PlanElement : BusinessObject<tPlanElement>, IPlanElement
    {
        IQueryable<tPlanElement> element;
        CostCenter cc;


        public static BOCollection<PlanElement, tPlanElement> GetBOCollection()
        {
            // select all cost centers for the current client
            var query = VerumInstance.Context.tPlanElement.Where<tPlanElement>(b => b.idClient == VerumInstance.IdClient).OrderBy(b => b.TitlePlanElement);
            return new BOCollection<PlanElement, tPlanElement>(query);
        }

        public BOResult PlanElementInstanceExists( Plan plan)
        {
            try
            {
                var query = VerumInstance.Context.tPlanElementInstance.Where<tPlanElementInstance>(b => b.idPlan == plan.Id && b.idPlanElement == Id);

                if (query.Any())
                    return BOResult.PlanElementInstanceExists;
                else
                    return BOResult.PlanElementInstanceExistsNot;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                return BOResult.GeneralError;
            }
        }

        public BOResult Delete()
        {
            try
            {
                var cnt = _db.tPlanElementInstance.Count(b => b.idPlanElement == Id);

                if (cnt == 0)
                {
                    _db.Database.ExecuteSqlCommand($"DELETE FROM [dbo].[tPlanElement] WHERE Id=Cast('{Id.ToString()}'as uniqueidentifier)");
                    VerumInstance.SaveChanges(true);
                }

                return BOResult.Success;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                return BOResult.GeneralError;
            }
        }

        public bool SelectViaKey(string title, string costCenter = "")
        {
            var attr = (StringLengthAttribute)typeof(tPlanElement).GetProperty("TitlePlanElement").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (title.Length > len)
                    title = title.Substring(0, len);
            }

            if (costCenter != "")
            {
                cc = new CostCenter();
                cc.SelectViaKey(costCenter);
            }

            if (cc.Bound)
                element = VerumInstance.Context.tPlanElement.Where(b => b.TitlePlanElement == title && b.idCostCenterPlanElement == cc.Id);
            else
                element = VerumInstance.Context.tPlanElement.Where(b => b.TitlePlanElement == title && b.idClient == VerumInstance.IdClient);

            if (element.Count() == 0)
            {
                return false;
            }
            else
            {
                Id = element.FirstOrDefault().Id;
                return true;
            }
        }

        public override void _CustomInit()
        {
            if (!Bound)
                idClient = VerumInstance.IdClient;
        }
    }
}
