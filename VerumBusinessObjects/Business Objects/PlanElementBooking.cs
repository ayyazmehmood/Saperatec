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

    public partial interface IPlanElementBooking
    {
    }

    /// <summary>
    /// Class <c>PlanElementBooking</c>: Planning element for direct accounting transactions with debit and credit account
    /// </summary>    
    public partial class PlanElementBooking : BusinessObject<tPlanElementBooking>, IPlanElementBooking, IPlanItem
    {
        // PUBLIC PROPERTIES
        public Guid idClient { get => PlanInstanceParent.PlanParent.idClient; }

        public Guid idPlan { get => PlanInstanceParent.idPlan; }

        public Guid? idCurrency { get => PlanInstanceParent.PlanElementParent.idCurrency; }

        public double Budget { get => _Budget; set => _Budget = value; }
        double _Budget;

        /// <summary>
        /// Property <c>ItemType</c> returns the specific item type as Contract
        /// </summary>
        public TypePlanElementEnum ItemType { get => TypePlanElementEnum.BookingRule; }

        // PUBLIC METHODS

        /// <summary>
        /// Method <c>ImplementPlanItem</c> generates booking records for current plan item
        /// </summary>
        public void ImplementPlanItem()
        {
            if (Bound)
            {

                try
                {
                    VerumInstance.TransactionStart();

                    _CreateTxTable();                       // Determine _TxScheduleItems with primary transaction dates and amounts

                    // Book primary transactions on cash or term basis as applies
                    BookRecord.BookPlannedTransactionSchedule(_tx_schedule_items_net, PlanInstanceParent, 
                                                                AccountDebitParent, AccountCreditParent, DateTime.MinValue, "", 0, FlagAccountOpening);

                    VerumInstance.TransactionEnd();

                    return;
                }
                catch (Exception ex)
                {
                    BOUtilities.TraceErrors(ex);
                    VerumInstance.TransactionRollback();

                    throw new BOException("Error during implementation of booking plan element.",
                        BOResult.PlanElementInvalidItemType);
                }
            }
        }

        /// <summary>
        /// Create a full PlanElement structure with Element record, Instance record and Item record. Initialize with existing data if valid Id is provided
        /// </summary>
        /// <param name="id"></param>
        /// <param name="planElement"></param>
        /// <param name="planElementInstance"></param>
        public void GetEntities(Guid? id, string title, Guid idPlan, out PlanElement planElement, out PlanElementInstance planElementInstance, string costCenter = "")
        {
            planElement = new PlanElement();
            planElementInstance = new PlanElementInstance();

            // if an Id for the item record is provided - select via Id
            //if (id.HasValue && id != Guid.Empty)
            //{
            //    Id = id.GetValueOrDefault();
            //    planElementInstance.Id = idPlanInstance;
            //    planElement.Id = planElementInstance.idPlanElement;
            //}

            //// if an Id for the item record is not provided determine the item id via the PlanElement title
            //else 
            if (planElement.SelectViaKey(title, costCenter))
            {
                // Ensure that element type is correct
                if (planElement.TypePlanElement != (short)TypePlanElementEnum.BookingRule)
                    throw new BOException("The type of the plan element and plan item is not the same.", BOResult.PlanElementInvalidItemType, title);

                // if planInstance for plan and element already exists
                else if (planElementInstance.GetViaElement(planElement.Id, idPlan))
                {
                    var par = planElementInstance.Id;
                    var obj = VerumInstance.Context.tPlanElementBooking.Where(b => b.idPlanInstance == par);

                    // if there is no item record for the plan element instance
                    if (obj.Count() == 0)
                    {
                        this.New();
                        this.idPlanInstance = par;
                    }

                    // if item record already exists
                    else
                    {
                        Id = obj.FirstOrDefault().Id;
                    }
                }

                // New plan element instance for existing plan element
                else
                {
                    planElementInstance.New();
                    planElementInstance.idPlan = idPlan;
                    planElementInstance.idPlanElement = planElement.Id;
                    this.New();
                    idPlanInstance = planElementInstance.Id;
                }
            }

            // new plan element with new title
            else
            {
                planElement.New();
                planElement.TypePlanElement = (short)TypePlanElementEnum.BookingRule;
                planElement.idClient = VerumInstance.IdClient;
                planElementInstance.New();
                planElementInstance.idPlan = idPlan;
                planElementInstance.idPlanElement = planElement.Id;
                this.New();
                idPlanInstance = planElementInstance.Id;
            }
        }

        public BOResult Delete()
        {
            try
            {
                if (AllocationScheduleParent != null)
                {
                    var schedule = AllocationScheduleParent;
                    idAllocationSchedule = null;
                    CommitChanges();
                    VerumInstance.SaveChanges(true);

                    if (!schedule.FlagScheduleShared)
                        schedule.Delete();
                }
                
                _db.Database.ExecuteSqlCommand($"DELETE FROM [dbo].[tPlanElementBooking] WHERE idPlanInstance=Cast('{idPlanInstance}' as uniqueidentifier)");
                //VerumInstance.SaveChanges(true);

                return BOResult.Success;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex);
                VerumInstance.TransactionRollback();
                return BOResult.GeneralError;
            }
        }

        public BOResult Copy(Plan targetPlan, PlanElementInstance targetInstance)
        {
            if (Bound)
            {
                try
                {
                    var targetElement = new PlanElementBooking();
                    targetElement.Clone(this);
                    targetElement.idPlanInstance = targetInstance.Id;
                    targetElement.CommitChanges();

                    if (AllocationScheduleParent != null)
                        targetElement.idAllocationSchedule = this.AllocationScheduleParent.GetCopy(targetPlan).Id;

                    if (InflationRuleParent != null)
                        targetElement.idInflationRule = InflationRuleParent.GetCopy(targetPlan).Id;

                    if (ParPrice1Parent != null)
                        targetElement.idParPrice1 = ParPrice1Parent.GetCopy(targetPlan).Id;

                    if (ParPrice2Parent != null)
                        targetElement.idParPrice2 = ParPrice2Parent.GetCopy(targetPlan).Id;

                    if (ParContingencyRateParent != null)
                        targetElement.idParContingencyRate = ParContingencyRateParent.GetCopy(targetPlan).Id;

                    return BOResult.Success;
                }
                catch (Exception ex)
                {
                    BOUtilities.TraceErrors(ex);
                }
            }

            return BOResult.PlanItemCopyError;
        }

        // INTERNAL FIELDS
        private List<TxScheduleItem> _tx_schedule_items_net = new List<TxScheduleItem>();
        private DateTime _actual_price_date;

        // INTERNAL METHODS


        /// <summary>
        /// Method <c>CreateTxTable</c> Creates a list of TxScheduleItems based on the element item's TypeRepeat and AllocationSchedule if any
        /// </summary>
        /// 
        void _CreateTxTable()
        {
            DateTime curDate;
            short monthInc;
            double net_amount;
            double inflation_factor;
            double exchange_rate = 1.0;

            curDate = PlanInstanceParent.BaseDate;
            monthInc = TypeRepeat;

            if (monthInc > 0)               // normal repeat schedule - allocation schedule will be ignored if exists
            {
                while (curDate < PlanInstanceParent.EndDate)
                {
                    // update inflation, VAT and exchange rate based on current date
                    _TxApplyCurrentDate(curDate, out net_amount, out inflation_factor, out exchange_rate);

                    _tx_schedule_items_net.Add(new TxScheduleItem(curDate, net_amount * inflation_factor * exchange_rate));
                    curDate = curDate.AddMonths(monthInc);
                }
            }
            else
            {
                if (AllocationScheduleParent == null)
                {
                    // update inflation, VAT and exchange rate based on current date
                    _TxApplyCurrentDate(curDate, out net_amount, out inflation_factor, out exchange_rate);

                    // simple single transaction w/o repeat or schedule
                    _tx_schedule_items_net.Add(new TxScheduleItem(curDate, net_amount * inflation_factor * exchange_rate));
                }
                else
                {
                    _tx_schedule_items_net = AllocationScheduleParent.GetTransactionSchedule(curDate, Budget, PlanInstanceParent.EndDate, TypeRepeat,
                                                                                                InflationRuleParent, PriceDate, null, idPlan, idCurrency);
                }
            }
        }

        private void _TxApplyCurrentDate(DateTime curDate, out double net_amount, out double inflation_factor, out double exchange_rate)
        {
            net_amount = Budget;

            // Apply inflation if applicable
            if (InflationRuleParent != null) inflation_factor = InflationRuleParent.InflationFactor(curDate, _actual_price_date);
            else inflation_factor = 1;

            // Apply exchange rate if applicable
            exchange_rate = Currency.ApplyCurrency(1, curDate, idPlan, idCurrency);
        }

        /// <summary>
        /// Method <c>CustomInit</c> calculates the base date and end for the item's transactions. It also determines the transaction budget
        /// including the application of inflation and contingency if defined
        /// </summary>
        public override void _CustomInit()
        {
            // only perform init when element is already bound to db
            if (Bound)
            {

                // determine transaction budget: fixed budget if defined, else calculate via units and price
                // apply parameters if defined (PricePar 1 & 2 as factors)
                if (NumberOfUnits == 0) _Budget = Price;
                else
                {
                    _Budget = NumberOfUnits * Price;

                    if (ParPrice1Parent != null) _Budget = _Budget * ParPrice1Parent.ValueNum;
                    if (ParPrice2Parent != null) _Budget = _Budget * ParPrice2Parent.ValueNum;
                }

                // Determine actual price date: use PriceDate <> null is defined, else PriceDate is Jan 1st of _BaseDate
                if (PriceDate.HasValue && PriceDate.Value > DateTime.MinValue) _actual_price_date = PriceDate.Value;
                else _actual_price_date = new DateTime(PlanInstanceParent.BaseDate.Year, 1, 1);

                // Apply contract contingency if defined as rate
                if (ParContingencyRateParent != null) _Budget = _Budget * (1 + ParContingencyRateParent.ValueNum);
            }
            else
            {
                if (idPlanInstance == null || idPlanInstance == Guid.Empty)
                    idPlanInstance = Guid.NewGuid();
            }

        }

    }
}
