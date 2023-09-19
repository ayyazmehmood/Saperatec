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

    public partial interface IPlanElementContract
    {
    }

    /// <summary>
    /// Class <c>PlanElementContract</c>: Planning element for contracts with a broad range of functionality to plan for CAPEX and OPEX
    /// </summary>    
    public partial class PlanElementContract : BusinessObject<tPlanElementContract>, IPlanElementContract, IPlanItem
    {
        // PUBLIC PROPERTIES
        public Guid idClient { get => PlanInstanceParent.PlanParent.idClient;  }

        public Guid idPlan { get => PlanInstanceParent.idPlan;  }

        public Guid? idCurrency { get => PlanInstanceParent.PlanElementParent.idCurrency; }

        public double Budget { get => _Budget; set => _Budget = value; }
        double _Budget;

        /// <summary>
        /// Property <c>ItemType</c> returns the specific item type as Contract
        /// </summary>
        public TypePlanElementEnum ItemType { get => (TypePlanElementEnum) PlanInstanceParent.PlanElementParent.TypePlanElement; }

        // PUBLIC METHODS

        /// <summary>
        /// Method <c>ImplementPlanItem</c> generates booking records for current plan item
        /// </summary>
        public void ImplementPlanItem()
        {
            double accrued_depreciation_amount = 0;
            TypePlanElementEnum type;
            Account directDebit = null;
            Account directCredit = null;

            if (Bound)
            { 
                try
                {
                    var accCash = new PlanAccountFunction().CashAccountDefault();
                    var accPayables = new PlanAccountFunction().PayablesAccountDefault();
                    var accReceivables = new PlanAccountFunction().ReceivablesAccountDefault();
                    DateTime dateCashUntil;         // For advance payments until advance conversion according to HGB direct booking to cash even with payment term
                    type = ItemType;

                    VerumInstance.TransactionStart();

                    _CreateTxTable();        //500ms               // Determine _TxScheduleItems with primary transaction dates and amounts

                    // determine and book direct transactions
                    if ((type == TypePlanElementEnum.Purchase))
                    { 
                        if (PaymentTerm > 0)
                            directCredit = accPayables;
                        else
                            directCredit = accCash;

                        /*if (_advanceAccount != null)
                            directDebit = _advanceAccount;
                        else *** REWORK 19.12.2020 ****/
                        
                        if (DepreciationRuleParent != null)
                            directDebit = DepreciationRuleParent.AccountActivationParent;
                        else
                            directDebit = MainAccount;
                    }
                    else
                    {
                        if (PaymentTerm > 0)
                            directDebit = accReceivables;
                        else
                            directDebit = accCash;

                        /*   if (_advanceAccount != null)
                               directCredit = _advanceAccount;
                           else
                               directCredit = MainAccount; ****REWORK 19.12.2020****/

                        directCredit = MainAccount;
                    }

                    // For booking advance payments according to HGB booking to cash account until conversion of advance
                    if (_advanceAccount == null)
                        dateCashUntil = DateTime.MinValue;
                    else
                        dateCashUntil = _advanceConversionDate.AddDays(PaymentTerm+1);

                    // Book primary transactions starting at advance conversion date (set to min if no advance)
                    BookRecord.BookPlannedTransactionSchedule(_tx_schedule_items_net, PlanInstanceParent, directDebit, directCredit, _advanceConversionDate);

                    // Book advance payment transactions
                    if (_advanceAccount != null)
                    {
                        if (type == TypePlanElementEnum.Purchase)
                        {
                            BookRecord.BookPlannedTransactionSchedule(_tx_schedule_items_advance, PlanInstanceParent, _advanceAccount,
                                    accCash, DateTime.MinValue);
                            BookRecord.BookPlannedRecord(_advanceConversionDate, AdvanceAccrualAmount,
                                                        PlanInstanceParent, MainAccount, _advanceAccount,
                                                        "Conversion of accrued advance payment.");
                        }

                        // sale transaction
                        else
                        {
                            BookRecord.BookPlannedTransactionSchedule(_tx_schedule_items_advance, PlanInstanceParent, accCash, 
                                _advanceAccount, DateTime.MinValue);
                            BookRecord.BookPlannedRecord(_advanceConversionDate, AdvanceAccrualAmount,
                                                        PlanInstanceParent, _advanceAccount, MainAccount,
                                                        "Conversion of accrued advance payment.");
                        }
                    }

                    // Book settlement transactions based on payment term (if defined)
                    if (PaymentTerm > 0)
                    {
                        if (type == TypePlanElementEnum.Purchase)
                            BookRecord.BookPlannedTransactionSchedule(_tx_schedule_items_gross, PlanInstanceParent, accPayables,
                                accCash, dateCashUntil, "", PaymentTerm);

                        // sale transaction 
                        else
                            BookRecord.BookPlannedTransactionSchedule(_tx_schedule_items_gross, PlanInstanceParent, accCash,
                                accReceivables, dateCashUntil, "", PaymentTerm);
                    }

                    // apply depreciation and VAT transactions
                    if (DepreciationRuleParent != null || VATRuleParent != null)
                    {
                        foreach (var o in _tx_schedule_items_net)
                        {
                            // apply depreciation if transaction date is past delayed depreciation start date. Else accrue amount for depreciation
                            if (DepreciationRuleParent != null && type == TypePlanElementEnum.Purchase)
                            {
                                if (o.Date < _deprDelayDate) 
                                    accrued_depreciation_amount += o.Amount;
                                else
                                {
                                    DepreciationRuleParent.Depreciate(o.Date.AddDays(DepreciationDelay), o.Amount + accrued_depreciation_amount, PlanInstanceParent, AccountMainParent, true);
                                    accrued_depreciation_amount = 0;
                                }
                            }

                            if (VATRuleParent != null)
                            {
                                if (type == TypePlanElementEnum.Purchase)
                                {
                                    if (PaymentTerm > 0 && o.Date > _advanceConversionDate) VATRuleParent.BookVATInput(o.Date, o.Amount, accPayables, accCash, PlanInstanceParent);
                                    else VATRuleParent.BookVATInput(o.Date, o.Amount, accCash, accCash, PlanInstanceParent);
                                }
                                else
                                {
                                    if (PaymentTerm > 0 && o.Date > _advanceConversionDate) VATRuleParent.BookVATOutput(o.Date, o.Amount, accReceivables, accCash, PlanInstanceParent);
                                    else VATRuleParent.BookVATOutput(o.Date, o.Amount, accCash, accCash, PlanInstanceParent);
                                }
                            }
                        }
                    }

                    if (DepreciationRuleParent != null && type == TypePlanElementEnum.Purchase)
                    {
                        if (accrued_depreciation_amount > 0)
                            DepreciationRuleParent.Depreciate(_deprDelayDate, accrued_depreciation_amount, PlanInstanceParent, AccountMainParent, true);
                        DepreciationRuleParent.BookDepreciation(PlanInstanceParent, AccountMainParent);
                        accrued_depreciation_amount = 0;
                    }

                    VerumInstance.TransactionEnd();

                    return;
                }
                catch (Exception ex)
                {
                    BOUtilities.TraceErrors(ex);
                    VerumInstance.TransactionRollback();

                    throw new BOException("Error during implementation of plan purchase/sale.",
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
                if (planElement.TypePlanElement != (short)TypePlanElementEnum.Purchase && planElement.TypePlanElement != (short)TypePlanElementEnum.Sale)
                    throw new BOException("The type of the plan element and plan item is not the same.", BOResult.PlanElementInvalidItemType, title);

                // if planInstance for plan and element already exists
                else if (planElementInstance.GetViaElement( planElement.Id, idPlan))
                {
                    var par = planElementInstance.Id;
                    var obj = VerumInstance.Context.tPlanElementContract.Where(b => b.idPlanInstance == par);

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
                planElement.TypePlanElement = (short)TypePlanElementEnum.Purchase;
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
                //VerumInstance.TransactionStart();

                if (AllocationScheduleParent != null)
                {
                    var schedule = AllocationScheduleParent;
                    idAllocationSchedule = null;
                    CommitChanges();
                    VerumInstance.SaveChanges();

                    if (!schedule.FlagScheduleShared)
                        schedule.Delete();
                }

                //_db.tPlanElementContract.Remove(_data);
                _db.Database.ExecuteSqlCommand($"DELETE FROM [dbo].[tPlanElementContract] WHERE idPlanInstance=Cast('{idPlanInstance.ToString()}' as uniqueidentifier)");
                _db.SaveChanges();
                //VerumInstance.TransactionEnd();
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
                    var targetElement = new PlanElementContract();
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

                    if (ParTriggerAdvanceParent != null)
                        targetElement.idParTriggerAdvance = ParTriggerAdvanceParent.GetCopy(targetPlan).Id;

                    if (DepreciationTriggerParent != null)
                        targetElement.idDepreciationTrigger = DepreciationTriggerParent.GetCopy(targetPlan).Id;

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
        private List<TxScheduleItem> _tx_schedule_items_gross = new List<TxScheduleItem>();
        private List<TxScheduleItem> _tx_schedule_items_advance = new List<TxScheduleItem>();
        private double AdvanceAccrualAmount;
        private DateTime _actual_price_date;
        private Account _advanceAccount;
        private Account MainAccount;
        private Account CashAccount;
        private DateTime _advanceConversionDate;
        private DateTime _deprDelayDate;

        // INTERNAL METHODS

        /// <summary>
        /// Method <c>CustomInit</c> calculates the base date and end for the item's transactions. It also determines the transaction budget
        /// including the application of inflation and contingency if defined
        /// </summary>
        public override void _CustomInit()
        {
            // only perform init when element is already bound to db
            if (Bound)
            {
                // ***** Determine applicable booking accounts for planning element ****

                // debit to activation account if DepreciationRule defined, else use specified account for final booking
                if (DepreciationRuleParent != null) MainAccount = DepreciationRuleParent.AccountActivationParent;
                else
                    MainAccount = AccountMainParent;

                // determine cash account
                var acc = PlanAccountFunction.GetAccountFunctionFirst(TypeAccountFunctionEnum.CashDefault);
                if (acc == null) throw new Exception(Properties.Errors.PlanAccountFunctionCashDefaultNotDefined);
                else CashAccount = acc;

                // Determine account for advance booking if applicable => when either an advance trigger date is defined or an allocation schedule has an advance delay > 0
                if (idParTriggerAdvance != Guid.Empty || AdvanceDelay > 0 || (idAllocationSchedule != Guid.Empty && AllocationScheduleParent.AdvanceDelayPeriods > 0))
                {
                    // If a specific advance account is specified use this, else use the default account
                    if (idAccountAdvance != Guid.Empty && idAccountAdvance != null) _advanceAccount = AccountAdvanceParent;
                    else if (ItemType == TypePlanElementEnum.Purchase) _advanceAccount = new PlanAccountFunction().AdvancePaidDefault();
                    else _advanceAccount = new PlanAccountFunction().AdvanceReceivedDefault();
                }
                else _advanceAccount = null;

                // determine transaction budget: fixed budget if defined, else calculate via units and price
                // apply parameters if defined (PricePar 1 & 2 as factors)
                if (NumberOfUnits == 0) _Budget = Price;
                else
                {
                    _Budget = NumberOfUnits * Price;

                    if (ParPrice1Parent != null) _Budget = _Budget * ParPrice1Parent.ValueNum;
                    if (ParPrice2Parent != null) _Budget = _Budget * ParPrice2Parent.ValueNum;
                }

                // Determine advance conversion date if applicable. If no conversion date is available, the advance mechanism is
                // deactivated
                if (_advanceAccount != null)
                {
                    if (idParTriggerAdvance != Guid.Empty && idParTriggerAdvance != null && ParTriggerAdvanceParent.ValueDate.HasValue)
                        _advanceConversionDate = ParTriggerAdvanceParent.ValueDate.Value.AddDays(AdvanceDelay);
                    else if (AdvanceDelay > 0) _advanceConversionDate = PlanInstanceParent.BaseDate.AddDays(AdvanceDelay);
                    else if (idAllocationSchedule != null) _advanceConversionDate =
                                    PlanInstanceParent.BaseDate.AddMonths(AllocationScheduleParent.AdvanceDelayPeriods * AllocationScheduleParent.MonthsBetweenItems);
                    else _advanceAccount = null;
                }

                // Determine start of depreciation date
                if (idDepreciationRule != null && idDepreciationRule != Guid.Empty)
                {
                    if (idDepreciationTrigger != null && idDepreciationTrigger != Guid.Empty && DepreciationTriggerParent.ValueDate.HasValue)
                        _deprDelayDate = DepreciationTriggerParent.ValueDate.Value;
                    else if (PlanInstanceParent.FlagDateOffset)
                    {
                        _deprDelayDate = PlanInstanceParent.BaseDate.AddYears(DepreciationStartYear.GetValueOrDefault());
                        _deprDelayDate = _deprDelayDate.AddMonths(DepreciationStartMonth.GetValueOrDefault());
                        _deprDelayDate = _deprDelayDate.AddDays(DepreciationStartDay.GetValueOrDefault());
                    }
                    else if (BOUtilities.IsValidDate(DepreciationStartYear.GetValueOrDefault(), DepreciationStartMonth.GetValueOrDefault(), DepreciationStartDay.GetValueOrDefault()))
                        _deprDelayDate = new DateTime(DepreciationStartYear.GetValueOrDefault(), DepreciationStartMonth.GetValueOrDefault(), DepreciationStartDay.GetValueOrDefault());
                    else
                        _deprDelayDate = PlanInstanceParent.BaseDate;

                    _deprDelayDate.AddDays(DepreciationDelay);

                    if (_deprDelayDate < _advanceConversionDate) _deprDelayDate = _advanceConversionDate;
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

        /// <summary>
        /// Method <c>CreateTxTable</c> Creates a list of TxScheduleItems based on the element item's TypeRepeat and AllocationSchedule if any
        /// </summary>
        /// 
        void _CreateTxTable()
        {
            DateTime curDate;
            short monthInc;
            double gross_amount;
            double net_amount;
            double inflation_factor;
            double exchange_rate = 1.0;

            curDate = PlanInstanceParent.BaseDate;
            monthInc = TypeRepeat;
            net_amount = Budget;

            if (monthInc > 0)               // normal repeat schedule - allocation schedule will be ignored if exists
            {
                while (curDate < PlanInstanceParent.EndDate)
                {
                    // update inflation, VAT and exchange rate based on current date
                    _TxApplyCurrentDate(curDate, out gross_amount, out inflation_factor, out exchange_rate);

                    _tx_schedule_items_net.Add(new TxScheduleItem(curDate, net_amount * inflation_factor * exchange_rate));
                    _tx_schedule_items_gross.Add(new TxScheduleItem(curDate, gross_amount * inflation_factor * exchange_rate));
                    curDate = curDate.AddMonths(monthInc);
                }
            }
            else
            {
                if (AllocationScheduleParent == null)
                {
                    // update inflation, VAT and exchange rate based on current date
                    _TxApplyCurrentDate(curDate, out gross_amount, out inflation_factor, out exchange_rate);

                    // simple single transaction w/o repeat or schedule
                    _tx_schedule_items_net.Add(new TxScheduleItem(curDate, net_amount * inflation_factor * exchange_rate));
                    _tx_schedule_items_gross.Add(new TxScheduleItem(curDate, gross_amount * inflation_factor * exchange_rate));
                }
                else
                {
                    if (InflationRuleParent != null)
                    {
                        var priceDate = new DateTime();

                        if (PriceDate.HasValue && PriceDate.Value > DateTime.MinValue)
                            priceDate = PriceDate.Value;
                        else
                            priceDate = PlanInstanceParent.BaseDate;

                        _tx_schedule_items_net = AllocationScheduleParent.GetTransactionSchedule(curDate, Budget, PlanInstanceParent.EndDate, TypeRepeat,
                                                                                                    InflationRuleParent, priceDate, null, idPlan, idCurrency);
                        _tx_schedule_items_gross = AllocationScheduleParent.GetTransactionSchedule(curDate, Budget, PlanInstanceParent.EndDate, TypeRepeat,
                                                                                                    InflationRuleParent, priceDate, VATRuleParent, idPlan, idCurrency);

                    }
                    else
                    {
                        _tx_schedule_items_net = AllocationScheduleParent.GetTransactionSchedule(curDate, Budget, PlanInstanceParent.EndDate, TypeRepeat,
                                                                                                    null, null, null, idPlan, idCurrency);
                        _tx_schedule_items_gross = AllocationScheduleParent.GetTransactionSchedule(curDate, Budget, PlanInstanceParent.EndDate, TypeRepeat,
                                                                                                    null, null, VATRuleParent, idPlan, idCurrency);
                    }

                }
            }

            // Advance payment mechanism - convert net transactions until conversion date to advance transactions
            if (_advanceAccount != null)
            {
                int i = 0;
                _tx_schedule_items_advance = new List<TxScheduleItem>();
                AdvanceAccrualAmount = 0.0;

                while (i < _tx_schedule_items_net.Count() && _tx_schedule_items_net[i].Date.Date <= _advanceConversionDate.Date)
                {
                    // Nach HGB für Anzahlungen Buchung erst bei Zahlung und nicht bei Rechnungserhalt
                    if (PaymentTerm > 0)
                    {
                        DateTime effective_date = _tx_schedule_items_net[i].Date.Date.AddDays(PaymentTerm);
                        if (effective_date > _advanceConversionDate)
                            effective_date = _advanceConversionDate;

                        _tx_schedule_items_net[i].Date = effective_date;
                        _tx_schedule_items_gross[i].Date = effective_date;
                    }

                    _tx_schedule_items_advance.Add(_tx_schedule_items_net[i]);
                    AdvanceAccrualAmount += _tx_schedule_items_net[i].Amount;
                    i++;
                }
            }
        }

        private void _TxApplyCurrentDate(DateTime curDate, out double gross_amount, out double inflation_factor, out double exchange_rate)
        {
            // Apply VAT to transaction amount if defined
            if (VATRuleParent == null) gross_amount = Budget;
            else gross_amount = VATRuleParent.GrossAmount(Budget, curDate);

            // Apply inflation if applicable
            if (InflationRuleParent != null) inflation_factor = InflationRuleParent.InflationFactor(curDate, _actual_price_date);
            else inflation_factor = 1;

            // Apply exchange rate if applicable
            exchange_rate = Currency.ApplyCurrency(1, curDate, idPlan, idCurrency);
        }

    }
}
