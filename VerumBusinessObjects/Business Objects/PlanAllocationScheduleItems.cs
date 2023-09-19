namespace VerumBusinessObjects
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;
    using System.Dynamic;
    using System.Diagnostics;
    using VerumBusinessObjects.Framework;

    public partial interface IPlanAllocationScheduleItems
    {

    }

    /// <summary>
    /// Class <c>PlanAllocationScheduleItems</c>: List of schedule rates per period for PlanAllocationSchedule
    /// </summary>    
	public partial class PlanAllocationScheduleItems : BusinessObject<tPlanAllocationScheduleItems>, IPlanAllocationScheduleItems
    {
        public bool GetViaOrderNum(Guid idSchedule, int orderNum)
        {
            var obj = VerumInstance.Context.tPlanAllocationScheduleItems.Where(b => b.idPlanAllocationSchedule == idSchedule && b.OrderNum == orderNum);

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
                VerumInstance.Context.tPlanAllocationScheduleItems.Remove(data);
                VerumInstance.TransactionEnd();
                return BOResult.Success;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                return BOResult.GeneralError;
            }
        }

        public BOResult Copy(PlanAllocationSchedule targetSchedule)
        {
            if (Bound)
            {
                try
                {
                    var targetItem = new PlanAllocationScheduleItems();
                    targetItem.Clone(this);
                    targetItem.idPlanAllocationSchedule = targetSchedule.Id;
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
