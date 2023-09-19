namespace VerumBusinessObjects
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.Linq;
    using VerumBusinessObjects.Framework;

    public partial interface IPlanAllocationSchedule
    {

    }

    /// <summary>
    /// Class <c>PlanAllocationSchedule</c>: Schedule of budget rates per period for creation of booking records. 
    /// Used to distribute items over several periods or create repetitive schedules with varying rates.
    /// Individual rates per period are contained in PlanAllocationScheduleItems
    /// </summary>    
	public partial class PlanAllocationSchedule : BusinessObject<tPlanAllocationSchedule>, IPlanAllocationSchedule
    {
        BOCollection<PlanAllocationScheduleItems, tPlanAllocationScheduleItems> ScheduleItems;

        public override void _CustomInit()
        {
            // if (Bound) 
            //    ScheduleItems = PlanAllocationScheduleChildren();
        }

        public List<TxScheduleItem> GetTransactionSchedule(DateTime curDate, double baseAmount, DateTime endDate, short typeRepeat,
                                                            PlanInflationRule inflationRule = null, DateTime? priceDate = null, 
                                                            VATRule vatRule = null, Guid? idPlan = null, Guid? idCurrency = null)
        {
            var schedule = PlanAllocationScheduleChildren();
            double itemAmount;
            List<TxScheduleItem> tx_schedule_items = new List<TxScheduleItem>();

            if (curDate <= endDate)
            {
                do
                {
                    foreach (PlanAllocationScheduleItems item in schedule)
                    {
                        if (curDate < endDate)
                        {
                            if (item.ItemRate != 0)
                            {
                                // use schedule amounts in absolute currency if flag is set to absolute rates - else calculate as ratio of base amount from plan element
                                if (FlagAbsoluteRates)
                                    itemAmount = item.ItemRate;
                                else
                                    itemAmount = baseAmount * item.ItemRate;

                                // Apply inflation if supplied
                                if (inflationRule != null && priceDate.HasValue)
                                    itemAmount *= inflationRule.InflationFactor(curDate, priceDate.Value);

                                // Apply VAT if supplied
                                if (vatRule != null)
                                    itemAmount = vatRule.GrossAmount(itemAmount, curDate);

                                // Apply exchange rate if applicable
                                if (idCurrency.HasValue && idPlan.HasValue)
                                    itemAmount = Currency.ApplyCurrency(itemAmount, curDate, idPlan.Value, idCurrency.Value);

                                //and exchange rate based on current date
                                tx_schedule_items.Add(new TxScheduleItem(curDate, itemAmount));
                            }
                        }

                        curDate = curDate.AddMonths(MonthsBetweenItems);
                    }

                    // if a perpetual rate is given and the plan element repeat type is "Schedule" => repeat perpetual rate until end date
                    if (PerpetualRate != 0 && (typeRepeat == (short)TypeRepeatEnum.Schedule))
                    {
                        do
                        {
                            // use schedule amounts in absolute currency if flag is set to absolute rates - else calculate as ratio of base amount from plan element
                            if (FlagAbsoluteRates)
                                itemAmount = PerpetualRate;
                            else
                                itemAmount = baseAmount * PerpetualRate;

                            // Apply inflation if supplied
                            if (inflationRule != null && priceDate.HasValue)
                                itemAmount *= inflationRule.InflationFactor(curDate, priceDate.Value);

                            // Apply VAT if supplied
                            if (vatRule != null)
                                itemAmount = vatRule.GrossAmount(itemAmount, curDate);

                            // Apply exchange rate if applicable
                            if (idCurrency.HasValue && idPlan.HasValue)
                                itemAmount = Currency.ApplyCurrency(itemAmount, curDate, idPlan.Value, idCurrency.Value);

                            //and exchange rate based on current date
                            tx_schedule_items.Add(new TxScheduleItem(curDate, itemAmount));

                            curDate = curDate.AddMonths(MonthsBetweenItems);
                        } while (curDate < endDate);
                    }

                } while (curDate < endDate && (typeRepeat == (short)TypeRepeatEnum.Schedule));
            }

            return tx_schedule_items;
        }

        /// <summary>
        /// Method <c>PlanAllocationScheduleChildren</c> Return BOCollection with all dependant Plan Allocation Schedule Items
        /// </summary>
        public BOCollection<PlanAllocationScheduleItems, tPlanAllocationScheduleItems> PlanAllocationScheduleChildren()
        {
            // select all element instances for the current schedule
            var query = _db.tPlanAllocationScheduleItems.Where<tPlanAllocationScheduleItems>(b => b.idPlanAllocationSchedule == Id).OrderBy(b => b.OrderNum);
            return new BOCollection<PlanAllocationScheduleItems, tPlanAllocationScheduleItems>(query);
        }

        public static BOCollection<PlanAllocationSchedule, tPlanAllocationSchedule> GetBOCollection(Guid idPlan)
        {
            // select all allocation schedules for a plan
            var query = VerumInstance.Context.tPlanAllocationSchedule.Where<tPlanAllocationSchedule>(b => b.idPlan == idPlan).OrderBy(b => b.TitleAllocationSchedule);
            return new BOCollection<PlanAllocationSchedule, tPlanAllocationSchedule>(query);
        }

        public bool SelectViaKey(string title, Guid idPlan)
        {
            var attr = (StringLengthAttribute)typeof(tPlanAllocationSchedule).GetProperty("TitleAllocationSchedule").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (title.Length > len)
                    title = title.Substring(0, len);
            }

            var obj = VerumInstance.Context.tPlanAllocationSchedule.Where(b => b.TitleAllocationSchedule == title && b.idPlan == idPlan);

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
                // check whether schedule is still referenced in plan element
                var cnt =   _db.tPlanElementBooking.Count(b => b.idAllocationSchedule == Id) +
                            _db.tPlanElementContract.Count(b => b.idAllocationSchedule == Id);

                if (cnt > 0)
                    return BOResult.PlanAllocationScheduleNotDeleted;

                _db.Database.ExecuteSqlCommand($"DELETE FROM [dbo].[tPlanAllocationScheduleItems] WHERE idPlanAllocationSchedule=Cast('{Id}' as uniqueidentifier)");
                VerumInstance.SaveChanges(true);
                _db.Database.ExecuteSqlCommand($"DELETE FROM [dbo].[tPlanAllocationSchedule] WHERE Id=Cast('{Id}' as uniqueidentifier)");
                VerumInstance.SaveChanges(true);

                return BOResult.Success;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex);
                return BOResult.GeneralError;
            }
        }

        public PlanAllocationSchedule GetCopy(Plan targetPlan)
        {
            PlanAllocationSchedule target;

            if (Bound)
            {
                try
                {
                    //VerumInstance.TransactionStart();

                    // seek schedule if already migrated to targetPlan
                    var query = VerumInstance.Context.tPlanAllocationSchedule.SingleOrDefault<tPlanAllocationSchedule>(b => b.idPlan == targetPlan.Id && b.IdMigrate==this.Id);

                    if (query == null)
                    {
                        target = new PlanAllocationSchedule();
                        target.Clone(this);
                        target.idPlan = targetPlan.Id;
                        target.CommitChanges();

                        // for auto plans the schedule items have already been created in CustomCommitAfter
                        if (!target.FlagAuto)
                            foreach (PlanAllocationScheduleItems item in PlanAllocationScheduleChildren())
                                if (item.Copy(target) != BOResult.Success) throw new InvalidOperationException("Error during plan allocation schedule item copy");
                    }
                    else
                        target = new PlanAllocationSchedule(query.Id);

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

        partial void _MonthsBetweenItemsValid(int value, ref bool valid)
        {
            if (Enum.IsDefined(typeof(TypeRegularPeriods), (short)value)) valid = true;
            else throw new BOException("Invalid schedule interval assigned for allocation schedule", BOResult.AllocationScheduleIntervalInvalid, value.ToString());
        }

        partial void _Period2Valid(short? value, ref bool valid)
        {
            if (Period1 == null || Period1 >= value)
               throw new BOException("Allocation schedule period 2 invalid.", BOResult.AllocationSchedulePeriodInvalid);
        }

        partial void _Period3Valid(short? value, ref bool valid)
        {
            if (Period2 == null || Period2 >= value)
                throw new BOException("Allocation schedule period 3 invalid.", BOResult.AllocationSchedulePeriodInvalid);
        }

        public override BOResult _CustomCommitBefore()
        {
            if (FlagAuto && !Period1.HasValue) throw new BOException("PlanAllocationSchedule with auto generation must have at least one defined period.",
                BOResult.AllocationScheduleAutoGenInvalidDef);

            if (Period1.HasValue && !Rate1.HasValue) throw new BOException("PlanAllocationSchedule: Period 1 specified without Rate.");
            if (Period2.HasValue && !Rate2.HasValue) throw new BOException("PlanAllocationSchedule: Period 2 specified without Rate.");
            if (Period3.HasValue && !Rate3.HasValue) throw new BOException("PlanAllocationSchedule: Period 3 specified without Rate.");

            return BOResult.Success;
        }


        /// <summary>
        /// Optional auto generation of allocation schedule from up to three specified periods
        /// </summary>
        public override void _CustomCommitAfter()
        {
            int period_number = 0;

            if (FlagAuto)
            {
                // First delete any existing schedule
                var obj = VerumInstance.Context.tPlanAllocationScheduleItems.Where(b => b.idPlanAllocationSchedule == Id);

                if (obj != null && obj.Count() > 0)
                    VerumInstance.Context.tPlanAllocationScheduleItems.RemoveRange(obj);

                // determine number of periods
                if (Period3.HasValue && Period3.Value > 0) period_number = Period3.Value;
                else if (Period2.HasValue && Period2.Value > 0) period_number = Period2.Value;
                else if (Period1.HasValue && Period1.Value > 0) period_number = Period1.Value;

                // Create schedule
                for (int i = 1; i <= period_number; i++)
                {
                    var item = new PlanAllocationScheduleItems();
                    item.New();
                    item.idPlanAllocationSchedule = Id;
                    item.OrderNum = i;

                    if (i == Period1.GetValueOrDefault()) item.ItemRate = Rate1.Value;
                    else if (i == Period2.GetValueOrDefault()) item.ItemRate = Rate2.Value;
                    else if (i == Period3.GetValueOrDefault()) item.ItemRate = Rate3.Value;
                    else item.ItemRate = 0;

                    item.CommitChanges();
                }
            }
        }

    }
}
