namespace VerumBusinessObjects
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;
    using System.Dynamic;
    using System.Diagnostics;
    using VerumBusinessObjects;
    using VerumBusinessObjects.Views;
    using VerumBusinessObjects.Framework;

    /// <summary>
    /// Class <c>PlanElementInstance</c>: Links type-specific implementations of a plan element to plan. 
    /// Enables simple overview of all element instances that exist for a particular plan
    /// </summary>    
    public partial class PlanElementInstance : BusinessObject<tPlanElementInstance>
    {
        // PUBLIC PROPERTIES
        public TypePlanElementEnum TypePlanElement { get => (TypePlanElementEnum)PlanElementParent.TypePlanElement; }

        public DateTime BaseDate { get => _BaseDate; set => _BaseDate = value; }
        DateTime _BaseDate;

        public DateTime EndDate { get => _EndDate; set => _EndDate = value; }
        DateTime _EndDate;

        /// <summary>
        /// Method <c>PlanItemChild</c> selects the plan item child record depending on the type of item
        /// </summary>
        public IPlanItem PlanItemChild
        {
            get
            {
                try
                {
                    switch (PlanElementParent.TypePlanElement)
                    {
                        case (short)TypePlanElementEnum.BookingRule:
                            {
                                var t = _db.tPlanElementBooking.Where(b => b.idPlanInstance == Id).FirstOrDefault();

                                if (t == null) throw new BOException("PlanElementBooking record for PlanElementInstance of type BookingRule not found.", BOResult.PlanElementInstanceWithoutItemRecord);
                                else
                                {
                                    var o = new PlanElementBooking(t.Id);
                                    return (IPlanItem)o;
                                }
                            }

                        case (short)TypePlanElementEnum.Purchase:
                        case (short)TypePlanElementEnum.Sale:
                            {
                                var t = _db.tPlanElementContract.Where(b => b.idPlanInstance == Id).FirstOrDefault();

                                if (t == null) throw new BOException("PlanElementContract record for PlanElementInstance of type Purchase not found.", BOResult.PlanElementInstanceWithoutItemRecord);
                                else
                                {
                                    var o = new PlanElementContract(t.Id);
                                    return (IPlanItem)o;
                                }
                            }

                        case (short)TypePlanElementEnum.Personnel:
                            {
                                var t = _db.tPlanElementHR.Where(b => b.idPlanInstance == Id).FirstOrDefault();

                                if (t == null) throw new BOException("PlanElementHR record for PlanElementInstance of type Personnel not found.", BOResult.PlanElementInstanceWithoutItemRecord);
                                else
                                {
                                    var o = new PlanElementHR(t.Id);
                                    return (IPlanItem)o;
                                }
                            }

                        default:
                            throw new NotImplementedException();
                    }
                }
                catch (Exception ex)
                {
                    BOUtilities.TraceErrors(ex);
                    return null;
                }
            }
        }

        // PUBLIC METHODS

        /// <summary>
        /// Method <c>ImplementPlanElementInstance</c> generates booking records for the attached plan element depending on the plan element type (i.e. PlanElementContract)
        /// </summary>
        public void ImplementPlanElementInstance(bool ForceUpdate = false)
        {
                if (FlagUpdate || ForceUpdate)
                {
                    if(DeleteBookRecords() == BOResult.DeleteBookRecordsFailed) throw new Exception("Löschen der Einträge fehlgeschlagen");
                    PlanItemChild.ImplementPlanItem();
                    FlagUpdate = false;
                    CommitChanges();
                }
            
        }

        internal BOResult ApprovePlanElementInstance(DateTime dateApprovedTo)
        {
            try
            {
                throw new NotImplementedException();
                return BOResult.Success;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex);
                return BOResult.GeneralError;
            }
        }

        /// <summary>
        /// Method <c>DeleteBookRecords</c> removes all book records of the plan element instance - typically for reimplementation
        /// </summary>
        public BOResult DeleteBookRecords()
        {
            long cnt = 0;
            long iterations = 0;
            const int max_iterations = 3;

                if (PlanParent.PlanFlagBaseline) throw new InvalidOperationException(Properties.Errors.PlanBaselineRecordsAreProtected);

                while (iterations < max_iterations && (cnt = _db.tBookRecord.Where(b => b.idPlanElementInstance == Id).Count()) > 0)
                {
                    try
                    {
                        _db.Database.ExecuteSqlCommand($"DELETE FROM [dbo].[tBookRecord] WHERE idPlanElementInstance=Cast('{Id.ToString()}' as uniqueidentifier)");
                        _db.SaveChanges();
                    }
                    catch(Exception ex)
                    {
                        BOUtilities.TraceErrors(ex);
                    }
                }

                if (cnt > 0)
                    return BOResult.DeleteBookRecordsFailed;
                else
                    return BOResult.Success;
        }

        public BOResult DeletePlanInstance( bool DeletePlanElement = false)
        {
            try
            {
                var element = PlanElementParent;

                //VerumInstance.TransactionStart();
                if (DeleteBookRecords() != BOResult.Success)
                    return BOResult.PlanElementInstanceNotDeleted;

                var child = PlanItemChild;

                if (child != null && child.Delete() != BOResult.Success)
                    return BOResult.PlanElementInstanceNotDeleted;

                //_db.tPlanElementInstance.Remove(_data);
                _db.Database.ExecuteSqlCommand($"DELETE FROM [dbo].[tPlanElementInstance] WHERE Id=Cast('{Id.ToString()}' as uniqueidentifier)");
                _db.SaveChanges();

                if (DeletePlanElement)
                    element.Delete();

                //VerumInstance.TransactionEnd();
                return BOResult.Success;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex);
                return BOResult.GeneralError;
            }
        }


        public BOResult Copy( Plan targetPlan)
        {
            if (Bound)
            {
                try
                {
                    var cnt = _db.tPlanElementInstance.Where(b => b.idPlan == targetPlan.Id && b.idPlanElement == idPlanElement).Count();

                    if (cnt == 0)
                    {
                        var targetInstance = new PlanElementInstance();
                        targetInstance.Clone(this);
                        targetInstance.idPlan = targetPlan.Id;
                        targetInstance.CommitChanges();

                        return PlanItemChild.Copy(targetPlan, targetInstance);
                    }
                    else
                    {
                        return BOResult.PlanItemCopyError;
                    }

                }
                catch (Exception ex)
                {
                    BOUtilities.TraceErrors(ex);
                    VerumInstance.TransactionRollback();
                    return BOResult.PlanItemCopyError;
                }
            }

            return BOResult.GeneralError;
        }

        public bool GetViaElement( Guid idPlanElement, Guid idPlan)
        {
            var obj = VerumInstance.Context.tPlanElementInstance.Where(b => b.idPlanElement == idPlanElement && b.idPlan == idPlan);

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

        public BOCollection<BookTransaction, tBookTransaction> GetBookTransactions()
        {
            // select all booking transactions for current element instance
            var query = VerumInstance.Context.tBookTransaction.Where<tBookTransaction>(b => b.idPlan == idPlan && b.idPlanElement == idPlanElement).OrderBy(b => b.BookingDate);
            return new BOCollection<BookTransaction, tBookTransaction>(query);
        }

        public Views.vPlanElementInstances GetView()
        {
            var obj = VerumInstance.Context.vPlanElementInstances.Where(b => b.Id == Id);

            if (obj.Count() == 0)
            {
                return null;
            }
            else
            {
                return obj.FirstOrDefault();
            }
        }

        // PRIVATE METHODS

        public override void _CustomInit()
        {
            if (Bound)
            {
                // Determine transaction base and end date from due date, offset flag, trigger date and plan valid from date

                // if date determined by offset
                if (FlagDateOffset)
                {
                    // Start relative date calculation from plan valid or trigger date if defined
                    if (ParTriggerDueDateParent == null || !ParTriggerDueDateParent.ValueDate.HasValue)
                        _BaseDate = PlanParent.DateValidFrom;
                    else
                        _BaseDate = ParTriggerDueDateParent.ValueDate.Value;

                    // If UntilDate is null (or 0) - take plan valid to date by default
                    if (!UntilDateYear.HasValue || !UntilDateMonth.HasValue || !UntilDateDay.HasValue)
                        _EndDate = PlanParent.DateValidTo;

                    else if (UntilDateYear == 0 && UntilDateMonth == 0 && UntilDateDay == 0)
                        _EndDate = PlanParent.DateValidTo;

                    // Else add until offset to start date for relative calculation
                    else
                        _EndDate = _BaseDate.AddYears(UntilDateYear.Value).AddMonths(UntilDateMonth.Value).AddDays(UntilDateDay.Value);

                    // add due date offset to base date
                    _BaseDate = _BaseDate.AddYears(DueDateYear).AddMonths(DueDateMonth).AddDays(DueDateDay);
                }

                // absolute date determination
                else
                {
                    // Basedate: Use due date absolute if valid
                    if (BOUtilities.IsValidDate(DueDateYear, DueDateMonth, DueDateDay))
                        _BaseDate = new DateTime(DueDateYear, DueDateMonth, DueDateDay);

                    // Else use plan from date by default
                    else if (!FlagDateOffset)
                        _BaseDate = PlanParent.DateValidFrom;

                    // If UntilDate is null - take plan valid to date by default
                    if (!UntilDateYear.HasValue || !UntilDateMonth.HasValue || !UntilDateDay.HasValue)
                        _EndDate = PlanParent.DateValidTo;

                    // End date: Use until date absolute if valid 
                    else if (BOUtilities.IsValidDate(UntilDateYear.Value, UntilDateMonth.Value, UntilDateDay.Value))
                        _EndDate = new DateTime(UntilDateYear.Value, UntilDateMonth.Value, UntilDateDay.Value);

                    // Else use plan date valid to by default
                    else if (!FlagDateOffset)
                        _EndDate = PlanParent.DateValidTo;
                }

                // Ensure that item end date does not exceed plan valid to date
                _EndDate = new DateTime(Math.Min(PlanParent.DateValidTo.Ticks, _EndDate.Ticks)).Date;
                _BaseDate = _BaseDate.Date;     // only use date component
            }
            else
            {
                if (idPlanElement == null || idPlanElement == Guid.Empty)
                    idPlanElement = Guid.NewGuid();

                FlagUpdate = true;
            }
        }


    }
}
