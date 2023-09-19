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

    public partial interface IPlanHRTariffDetail
    {

    }

    public partial class PlanHRTariffDetail : BusinessObject<tPlanHRTariffDetail>, IPlanHRTariffDetail
    {

        public bool GetViaValidTo(Guid idTariff, DateTime? valid_to = null)
        {
            IQueryable<tPlanHRTariffDetail> obj;

            if (valid_to.HasValue)
            {
                // Search only by date (ignore time )
                valid_to = valid_to.Value.Date;

                obj = VerumInstance.Context.tPlanHRTariffDetail.Where(b => b.DateValidTo == valid_to && b.idTariff == idTariff);
            }
            else
                obj = VerumInstance.Context.tPlanHRTariffDetail.Where(b => b.DateValidTo == null && b.idTariff == idTariff);

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

        public BOResult Delete()
        {
            try
            {
                VerumInstance.TransactionStart();
                VerumInstance.Context.tPlanHRTariffDetail.Remove(data);
                VerumInstance.TransactionEnd();
                return BOResult.Success;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                return BOResult.GeneralError;
            }
        }

        public BOResult Copy(PlanHRTariff targetDetail)
        {
            if (Bound)
            {
                try
                {
                    var targetItem = new PlanHRTariffDetail();
                    targetItem.Clone(this);
                    targetItem.idTariff = targetDetail.Id;
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

    }
}
