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
    using System.Threading.Tasks;
    using System.Data.Entity.Infrastructure.Interception;
    using System.Windows.Threading;
    using System.ComponentModel.DataAnnotations;
    using System.Data.Entity.Migrations;
    using VerumBusinessObjects.Views;

    public partial class Plan : BusinessObject<tPlan>
    {
        /// <summary>
        /// Method <c>ImplementPlan</c> generates booking records for all element instances defined for the plan
        /// </summary>
        public BOResult ImplementPlan(bool ForceUpdate = false)
        {
            IQueryable<tPlanElementInstance> query;

            try
            {
                if (!Bound)
                    query = VerumInstance.Context.tPlanElementInstance.Where<tPlanElementInstance>(b => b.FlagUpdate && !b.FlagBaseline);

                else if (TypeStatus == (short)TypePlanStatusEnum.Baseline)          // Approved plan cannot be implemented
                    return BOResult.PlanApprovedAlready;

                else if (TypeStatus == (short)TypePlanStatusEnum.Obsolete)          // Obsolete plan cannot be implemented
                    return BOResult.PlanObsolete;
                else if (ForceUpdate)
                    query = VerumInstance.Context.tPlanElementInstance.Where<tPlanElementInstance>(b => b.idPlan == Id && !b.FlagBaseline);
                else
                    query = VerumInstance.Context.tPlanElementInstance.Where<tPlanElementInstance>(b => b.idPlan == Id && b.FlagUpdate && !b.FlagBaseline);

                if (query.Count() > 0)
                {
                    var list = query.ToList();
                    var count = query.Count();

                    foreach (var o in list)
                    {
                        OnRaiseProgressEvent(new PlanImplementationProgress(count));

                        var instance = new PlanElementInstance();
                        instance.data = o;
                        instance.ImplementPlanElementInstance(ForceUpdate);
                        count--;
                    }

                    OnRaiseProgressEvent(new PlanImplementationProgress(count));
                }

                return BOResult.Success;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex);
                return BOResult.GeneralError;
            }
        }


        /// <summary>
        /// Creates forecast for the selected plan. This includes the following steps:
        /// 1.) All booking transactions currently marked as forecast are unflagged
        /// 2.) All actuals before startDate are flagged forecast
        /// 3.) All plan transactions between start and end date are flagged forecast
        /// 4.) All budget transactions between start and end date are flagged forecast
        /// 5.) All budget transactions between start and end date are flagged forecast for plan elements which are also included in the plan are unflagged again
        /// </summary>
        /// <param name="startDate">Start date for forecast transactions from plan or budget. Prior to startDate actuals are included in the forecast</param>
        /// <param name="endDate">End date of the forecast</param>
        /// <returns></returns>
        public BOResult ToForecast(DateTime? startDate, DateTime? endDate, bool flagReplace)
        {
            try
            {
                if (!startDate.HasValue)
                    startDate = DateValidFrom;

                if (!endDate.HasValue)
                    endDate = DateValidTo;

                VerumInstance.TransactionStart();
                VerumInstance.Context.Database.CommandTimeout = 500;
                // if replace mode: 
                if (flagReplace)
                {
                    // step 0   mark all FlagForecast transactions as not FlagForecast and not FlagBaseline
                    VerumInstance.Context.Database.ExecuteSqlCommand(
                    "UPDATE dbo.tBookTransaction SET dbo.tBookTransaction.FlagForecast = 0, dbo.tBookTransaction.FlagBaseline = 0 " +
                    "FROM dbo.tBookTransaction " +
                    "WHERE((dbo.tBookTransaction.FlagForecast = 1) " +
                    "AND (dbo.tBookTransaction.idClient = @p0));",
                    idClient);

                    // step 0a  mark all remaining FlagBaseline transactions as not FlagBaseline
                    VerumInstance.Context.Database.ExecuteSqlCommand(
                    "UPDATE dbo.tBookTransaction SET dbo.tBookTransaction.FlagBaseline = 0 " +
                    "FROM dbo.tBookTransaction " +
                    "WHERE((dbo.tBookTransaction.FlagBaseline = 1) " +
                    "AND (dbo.tBookTransaction.idClient = @p0));",
                    idClient);

                    // step 1   mark all actuals transactions before timeframe as forecast
                    VerumInstance.Context.Database.ExecuteSqlCommand(
                    "UPDATE dbo.tBookTransaction SET dbo.tBookTransaction.FlagForecast = 1 " +
                    "FROM dbo.tBookTransaction " +
                    "WHERE((dbo.tBookTransaction.TypeBookRecord = @p0) " +
                    "AND (dbo.tBookTransaction.BookingDate <  @p1) " +
                    "AND (dbo.tBookTransaction.idClient = @p2));",
                    (short)TypeBookRecordEnum.Actual, startDate.Value, idClient);


                    // step 2   mark all budget transactions in forecast timeframe as forecast and baseline
                    VerumInstance.Context.Database.ExecuteSqlCommand(
                    "UPDATE dbo.tBookTransaction SET dbo.tBookTransaction.FlagForecast = 1, dbo.tBookTransaction.FlagBaseline = 1  " +
                    "FROM dbo.tBookTransaction " +
                    "WHERE((dbo.tBookTransaction.TypeBookRecord = @p0) " +
                    "AND (dbo.tBookTransaction.BookingDate >=  @p1) " +
                    "AND (dbo.tBookTransaction.BookingDate <=  @p2) " +
                    "AND (dbo.tBookTransaction.idClient = @p3));",
                    (short)TypeBookRecordEnum.Budget, startDate.Value, endDate.Value, idClient);

                    // step 3   mark all remaining budget transactions as baseline 
                    VerumInstance.Context.Database.ExecuteSqlCommand(
                    "UPDATE dbo.tBookTransaction SET dbo.tBookTransaction.FlagBaseline = 1  " +
                    "FROM dbo.tBookTransaction " +
                    "WHERE ((dbo.tBookTransaction.TypeBookRecord = @p0) " +
                    "AND (dbo.tBookTransaction.BookingDate < @p1) " +
                    "AND (dbo.tBookTransaction.idClient = @p2));",
                    (short)TypeBookRecordEnum.Budget, startDate.Value, idClient);

                    // step 4   reset all plans with status Forecast back to Plan 
                    VerumInstance.Context.Database.ExecuteSqlCommand(
                    "UPDATE dbo.tPlan SET dbo.tPlan.TypeStatus = @p0 " +
                    "FROM dbo.tPlan " +
                    "WHERE dbo.tPlan.TypeStatus = @p1 " +
                    "AND dbo.tPlan.idClient = @p2;",
                    (short)TypePlanStatusEnum.Plan, (short)TypePlanStatusEnum.Forecast, idClient);
                }

                // step 5: mark all transactions of current plan from forecast cutoff to forecast end as forecast and as baseline
                VerumInstance.Context.Database.ExecuteSqlCommand(
                    "UPDATE dbo.tBookTransaction SET dbo.tBookTransaction.FlagForecast = 1, dbo.tBookTransaction.FlagBaseline = 1 " +
                    "FROM dbo.tBookTransaction " +
                    "WHERE dbo.tBookTransaction.idPlan = @p0 " +
                    "AND dbo.tBookTransaction.BookingDate >=  @p1 " +
                    "AND dbo.tBookTransaction.BookingDate <=  @p2 " +
                    "AND dbo.tBookTransaction.idClient = @p3;",
                    Id, startDate.Value, endDate.Value, idClient);

                // step 5a: mark all transactions of current plan from plan start date before forecast cutoff as baseline
                VerumInstance.Context.Database.ExecuteSqlCommand(
                    "UPDATE dbo.tBookTransaction SET dbo.tBookTransaction.FlagBaseline = 1 " +
                    "FROM dbo.tBookTransaction " +
                    "WHERE dbo.tBookTransaction.idPlan = @p0 " +
                    "AND dbo.tBookTransaction.BookingDate >=  @p1 " +
                    "AND dbo.tBookTransaction.BookingDate <  @p2 " +
                    "AND dbo.tBookTransaction.idClient = @p3;",
                    Id, DateValidFrom, startDate.Value, idClient);

                // step 6: mark all transactions of other plans within timeframe as not forecast where the respective plan element is part of the forecasted plan
                VerumInstance.Context.Database.ExecuteSqlCommand(
                    "UPDATE dbo.tBookTransaction SET dbo.tBookTransaction.FlagForecast = 0 " +
                    "FROM dbo.tBookTransaction t " +
                    "INNER JOIN dbo.tPlanElementInstance i ON t.idPlanElement = i.idPlanElement " +
                    "WHERE i.idPlan = @p0 " +
                    "AND t.idPlan <> @p0 " +
                    "AND t.BookingDate >=  @p1 " +
                    "AND t.BookingDate <  @p2 " +
                    "AND t.idClient = @p3;",
                    Id, startDate.Value, endDate.Value, idClient);

                // step 6a: mark all transactions of other plans from plan start date to end date as not extended baseline where the respective plan element is part of the forecasted plan
                VerumInstance.Context.Database.ExecuteSqlCommand(
                    "UPDATE dbo.tBookTransaction SET dbo.tBookTransaction.FlagBaseline = 0 " +
                    "FROM dbo.tBookTransaction t " +
                    "INNER JOIN dbo.tPlanElementInstance i ON t.idPlanElement = i.idPlanElement " +
                    "WHERE i.idPlan = @p0 " +
                    "AND t.idPlan <> @p0 " +
                    "AND t.FlagBaseline = 1 " +
                    "AND t.BookingDate >=  @p1 " +
                    "AND t.BookingDate <  @p2 " +
                    "AND t.idClient = @p3;",
                    Id, startDate.Value, endDate.Value, idClient);

                // step 7: mark transactions for current plan as plan except if marked as budget
                VerumInstance.Context.Database.ExecuteSqlCommand(
                    "UPDATE dbo.tBookTransaction SET dbo.tBookTransaction.TypeBookRecord = @p0 " +
                    "FROM dbo.tBookTransaction " +
                    "WHERE dbo.tBookTransaction.TypeBookRecord <> @p1 " +
                    "AND dbo.tBookTransaction.FlagForecast = 1 " +
                    "AND dbo.tBookTransaction.idPlan = @p2 " +
                    "AND dbo.tBookTransaction.idClient = @p3;",
                    (short)TypeBookRecordEnum.Plan, (short)TypeBookRecordEnum.Budget, Id, idClient);

                // step 8: mark book records for current plan as plan except if marked as budget
                VerumInstance.Context.Database.ExecuteSqlCommand(
                    "UPDATE dbo.tBookRecord SET dbo.tBookRecord.TypeBookRecord = @p0 " +
                    "FROM dbo.tBookTransaction " +
                    "INNER JOIN dbo.tBookRecord ON dbo.tBookTransaction.idBookingRecord = dbo.tBookRecord.Id " +
                    "WHERE dbo.tBookTransaction.TypeBookRecord <> @p1 " +
                    "AND dbo.tBookTransaction.FlagForecast = 1 " +
                    "AND dbo.tBookTransaction.idPlan = @p2;",
                    (short)TypeBookRecordEnum.Plan, (short)TypeBookRecordEnum.Budget, Id);

                if (TypeStatus != (short)TypePlanStatusEnum.Baseline)
                {
                    // step 9: mark plan as "plan" if not baseline
                    TypeStatus = (short)TypePlanStatusEnum.Forecast;
                }

                VerumInstance.TransactionEnd();

                return BOResult.Success;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex);
                return BOResult.GeneralError;
            }

        }

        /// <summary>
        /// Creates budget for the selected plan. This includes the following steps:
        /// 1 - mark current budget transactions within budget timeframe as historical
        /// 2 - flag plan transactions as budget
        /// 3 - flag booking records for budget transactions as budget
        /// 4 - flag booking records for historical transactions as budget
        /// 5 - flag plans with status budget as obsolete (historical)
        /// 6 - flag current plan as plan (budget)
        /// </summary>
        /// <param name="startDate">Start date for budget transactions from plan.</param>
        /// <param name="endDate">End date of the budget</param>
        /// <returns></returns>
        public BOResult ToBudget(DateTime? startDate, DateTime? endDate, bool flagReplace, bool flagForecast)
        {
            try
            {
                if (!startDate.HasValue)
                    startDate = DateValidFrom;

                if (!endDate.HasValue)
                    endDate = DateValidTo;

                VerumInstance.TransactionStart();

                // step 1: 
                // remove old budget and forecast entries within timeframe
                // replace mode:
                // - all transactions within timeframe with status plan or budget are marked as archived or obsolete
                // incremental mode:
                // - transactions within timeframe with status plan or budget are marked by plan element

                if (flagReplace)
                {
                    // mark current budget transactions within budget timeframe as historical
                    VerumInstance.Context.Database.ExecuteSqlCommand(
                        "UPDATE dbo.tBookTransaction SET dbo.tBookTransaction.TypeBookRecord = @p0 " +
                        "FROM dbo.tBookTransaction " +
                        "WHERE(((dbo.tBookTransaction.TypeBookRecord) = @p1) " +
                        "AND ((dbo.tBookTransaction.BookingDate) >=  @p2) " +
                        "AND ((dbo.tBookTransaction.BookingDate) <=  @p3) " +
                        "AND ((dbo.tBookTransaction.idClient) = @p4));",
                        (short)TypeBookRecordEnum.Historical, (short)TypeBookRecordEnum.Budget, startDate.Value, endDate.Value, idClient);
                }
                else
                {
                    // mark current budget transactions within budget timeframe as historical where plan element is included in new budget plan
                    VerumInstance.Context.Database.ExecuteSqlCommand(
                        "UPDATE dbo.tBookTransaction SET dbo.tBookTransaction.TypeBookRecord = @p0 " +
                        "FROM dbo.tBookTransaction " +
                        "INNER JOIN dbo.tPlanElementInstance ON dbo.tBookTransaction.idPlanElement = dbo.tPlanElementInstance.idPlanElement " +
                        "WHERE(((dbo.tBookTransaction.TypeBookRecord) = @p1)" +
                        "AND ((dbo.tBookTransaction.BookingDate) >=  @p2) " +
                        "AND ((dbo.tBookTransaction.BookingDate) <=  @p3) " +
                        "AND((dbo.tPlanElementInstance.idPlan) = @p4) " +
                        "AND((dbo.tBookTransaction.idClient) = @p5));",
                        (short)TypeBookRecordEnum.Historical, (short)TypeBookRecordEnum.Budget, startDate.Value, endDate.Value, Id, idClient);
                }

                // step 2: 
                // mark new budget transactions within timeframe
                VerumInstance.Context.Database.ExecuteSqlCommand(
                    "UPDATE dbo.tBookTransaction SET dbo.tBookTransaction.TypeBookRecord = @p0 " +
                    "FROM dbo.tBookTransaction " +
                    "WHERE(((dbo.tBookTransaction.idPlan) = @p1)" +
                    "AND ((dbo.tBookTransaction.BookingDate) >=  @p2) " +
                    "AND ((dbo.tBookTransaction.BookingDate) <=  @p3) " +
                    "AND((dbo.tBookTransaction.idClient) = @p4));",
                    (short)TypeBookRecordEnum.Budget, Id, startDate.Value, endDate.Value, idClient);

                VerumInstance.Context.Database.ExecuteSqlCommand(
                    "UPDATE dbo.tBookRecord SET dbo.tBookRecord.TypeBookRecord = @p0 " +
                    "FROM dbo.tBookRecord " +
                    "INNER JOIN dbo.tBookTransaction ON dbo.tBookTransaction.idBookingRecord = dbo.tBookRecord.Id " +
                    "WHERE(((dbo.tBookTransaction.idPlan) = @p1)" +
                    "AND ((dbo.tBookTransaction.BookingDate) >=  @p2) " +
                    "AND ((dbo.tBookTransaction.BookingDate) <=  @p3) " +
                    "AND((dbo.tBookTransaction.idClient) = @p4));",
                    (short)TypeBookRecordEnum.Budget, Id, startDate.Value, endDate.Value, idClient);

                // Step 3 - flag current plan as budget (plan)
                TypeStatus = (short)TypePlanStatusEnum.Baseline;
                ApprovedTo = endDate.Value;

                VerumInstance.TransactionEnd();

                // Step 4 - all budgeted transactions are also marked as forecast. If flag forecast is set also all plan transactions after budget timeframe are marked as forecast
                if (flagForecast)
                    ToForecast(startDate, DateValidTo, flagReplace);
                else
                    ToForecast(startDate, endDate, flagReplace);

                return BOResult.Success;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex);
                return BOResult.GeneralError;
            }
        }

        public event EventHandler<PlanImplementationProgress> ProgressEvent;

        public BOResult Delete()
        {
            try
            {
                switch (TypeStatus)
                {
                    case (short)TypePlanStatusEnum.New:
                        VerumInstance.TransactionStart();
                        VerumInstance.Context.tPlan.Remove(data);               // ACTION: Delete dependant items if possible!!
                        VerumInstance.TransactionEnd();
                        return BOResult.Success;
                    default:
                        return BOResult.PlanAppliedCannotDelete;
                }
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                return BOResult.GeneralError;
            }
        }

        protected virtual void OnRaiseProgressEvent(PlanImplementationProgress e)
        {
            // Raise event if event handler is set (i.e. not null)
            ProgressEvent?.Invoke(this, e);
        }

        /// <summary>
        /// Method <c>PlanElementInstanceChildren</c> Return BOCollection with all dependant Plan Element Instances
        /// </summary>
        BOCollection<PlanElementInstance, tPlanElementInstance> PlanElementInstanceChildren()
        {
            // select all element instances for the current plan
            var query = VerumInstance.Context.tPlanElementInstance.Where<tPlanElementInstance>(b => b.idPlan == Id);
            return new BOCollection<PlanElementInstance, tPlanElementInstance>(query);
        }

        public bool SelectViaKey(string title)
        {
            var attr = (StringLengthAttribute)typeof(tPlan).GetProperty("TitlePlan").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (title.Length > len)
                    title = title.Substring(0, len);
            }

            var obj = VerumInstance.Context.tPlan.Where(b => b.TitlePlan == title && b.idClient == VerumInstance.IdClient);

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

        public override void _CustomInit()
        {
            if (!Bound)
                idClient = VerumInstance.IdClient;
        }

        public static BOCollection<Plan, tPlan> GetBOCollection()
        {
            // select all plans for the current client
            var query = VerumInstance.Context.tPlan.Where<tPlan>(b => b.idClient == VerumInstance.IdClient);
            return new BOCollection<Plan, tPlan>(query);
        }

        /// <summary>
        /// Returns observable collection of all plan element instances assigned to the plan combining their PlanElement and PlanElementInstance data into a single view
        /// Collection can be used for dynamic display of items in WPF GUI
        /// </summary>
        /// <returns></returns>
        public ObservableCollection<vPlanElementInstances> GetPlanElements()
        {
            if (Bound)
            {
                var query = VerumInstance.Context.vPlanElementInstances.Where<vPlanElementInstances>(b => b.idPlan == Id).OrderBy(b => b.CostCenterCode).ThenBy(b => b.TitlePlanElement);
                return new ObservableCollection<vPlanElementInstances>(query);
            }
            else
                return null;
        }

        /// <summary>
        /// Returns observable collection of all plan parameters assigned to the plan
        /// Collection can be used for dynamic display of items in WPF GUI
        /// </summary>
        /// <returns></returns>
        public ObservableCollection<tPlanParameter> GetParameters()
        {
            if (Bound)
            {
                var query = VerumInstance.Context.tPlanParameter.Where<tPlanParameter>(b => b.idPlan == Id);
                return new ObservableCollection<tPlanParameter>(query);
            }
            else
                return null;
        }

        /// <summary>
        /// Returns observable collection of all plan allocation schedules
        /// Collection can be used for dynamic display of items in WPF GUI
        /// </summary>
        /// <returns></returns>
        public ObservableCollection<tPlanAllocationSchedule> GetAllocationSchedules()
        {
            if (Bound)
            {
                var query = VerumInstance.Context.tPlanAllocationSchedule.Where<tPlanAllocationSchedule>(b => b.idPlan == Id);
                return new ObservableCollection<tPlanAllocationSchedule>(query);
            }
            else
                return null;
        }

        /// <summary>
        /// Returns observable collection of all plan inflation rules
        /// Collection can be used for dynamic display of items in WPF GUI
        /// </summary>
        /// <returns></returns>
        public ObservableCollection<tPlanInflationRule> GetInflationRules()
        {
            if (Bound)
            {
                var query = VerumInstance.Context.tPlanInflationRule.Where<tPlanInflationRule>(b => b.idPlan == Id);
                return new ObservableCollection<tPlanInflationRule>(query);
            }
            else
                return null;
        }

        /// <summary>
        /// Returns observable collection of all plan HR Tariffs
        /// Collection can be used for dynamic display of items in WPF GUI
        /// </summary>
        /// <returns></returns>
        public ObservableCollection<tPlanHRTariff> GetHRTariffs()
        {
            if (Bound)
            {
                var query = VerumInstance.Context.tPlanHRTariff.Where<tPlanHRTariff>(b => b.idPlan == Id);
                return new ObservableCollection<tPlanHRTariff>(query);
            }
            else
                return null;
        }

        
        /// <summary>
        /// Returns observable collection of all plan HR Expense Groups
        /// Collection can be used for dynamic display of items in WPF GUI
        /// </summary>
        /// <returns></returns>
        public ObservableCollection<tPlanHRExpenseGroup> GetHRExpenseGroups()
        {
            if (Bound)
            {
                var query = VerumInstance.Context.tPlanHRExpenseGroup.Where<tPlanHRExpenseGroup>(b => b.idPlan == Id);
                return new ObservableCollection<tPlanHRExpenseGroup>(query);
            }
            else
                return null;
        }

        /// <summary>
        /// Returns observable collection of all plan Plan Currency Exchange Rates
        /// Collection can be used for dynamic display of items in WPF GUI
        /// </summary>
        /// <returns></returns>
        public ObservableCollection<vCurrencyExchangeRate> GetExchangeRates()
        {
            if (Bound)
            {
                var query = VerumInstance.Context.vCurrencyExchangeRate.Where<vCurrencyExchangeRate>(b => b.idPlan == Id);
                return new ObservableCollection<vCurrencyExchangeRate>(query);
            }
            else
                return null;
        }
    }

    public class PlanImplementationProgress : EventArgs
    {
        public int ItemsRemaining { get; set; }
        public PlanImplementationProgress(int items)
        {
            ItemsRemaining = items;
        }
    }
}
