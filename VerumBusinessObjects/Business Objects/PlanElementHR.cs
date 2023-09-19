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

    public partial interface IPlanElementHR
    {
    }

    /// <summary>
    /// Class <c>PlanElementHR</c>: Planning element for personnel expenses
    /// </summary>    
    public partial class PlanElementHR : BusinessObject<tPlanElementHR>, IPlanElementHR, IPlanItem
    {
        // PUBLIC PROPERTIES
        public Guid idClient { get => PlanInstanceParent.PlanParent.idClient; }

        public Guid idPlan { get => PlanInstanceParent.idPlan; }

        public Plan PlanParent { get => PlanInstanceParent.PlanParent; }
        public Guid? idCurrency { get => PlanInstanceParent.PlanElementParent.idCurrency; } 

        public double Budget { get => _Budget; set => _Budget = value; }
        double _Budget;

        /// <summary>
        /// Property <c>ItemType</c> returns the specific item type as Contract
        /// </summary>
        public TypePlanElementEnum ItemType { get => TypePlanElementEnum.Personnel; }

        // PUBLIC METHODS

        /// <summary>
        /// Method <c>ImplementPlanItem</c> generates booking records for current plan item
        /// </summary>
        public void ImplementPlanItem()
        {
            DateTime curDate;
            List<PlanHRExpense> planHRExpenses;
            double salary;
            double expense_contribution;
            double bonus;
            double expense;
            double expense_cap;
            Account cashAccount;
            double exchange_rate = 1;
            double inflation_factor = 1;
            double start_prorate = 1;

            if (Bound)
            {
                try
                {
                    VerumInstance.TransactionStart();

                    // Determine first booking date based on standard element base date and pay day according to tariff
                    var a = Math.Min(DateTime.DaysInMonth(PlanInstanceParent.BaseDate.Year, PlanInstanceParent.BaseDate.Month), TariffParent.PayDay);
                    curDate = new DateTime(PlanInstanceParent.BaseDate.Year, PlanInstanceParent.BaseDate.Month, a);
                    cashAccount = PlanAccountFunction.GetAccountFunctionFirst(TypeAccountFunctionEnum.CashDefault);

                    // Partial salary in case of start date within month
                    if (PlanInstanceParent.BaseDate.Month == curDate.Month && PlanInstanceParent.BaseDate.Day > 1)
                    {
                        double n = DateTime.DaysInMonth(PlanInstanceParent.BaseDate.Year, PlanInstanceParent.BaseDate.Month);
                        start_prorate = (n - PlanInstanceParent.BaseDate.Day + 1) / n;
                    }

                    while (curDate <= PlanInstanceParent.EndDate)
                    {
                        // Determine inflation factor for salary and bonus if applicable - based on tariff base date
                        if (InflationRuleParent != null)
                        {
                            if (TariffParent.DateInflationBase.HasValue && TariffParent.DateInflationBase.Value.Year > 2000)        // avoid unlogical inflation base date
                                inflation_factor = InflationRuleParent.InflationFactor(curDate, TariffParent.DateInflationBase.Value);
                            else
                                inflation_factor = InflationRuleParent.InflationFactor(curDate, BOUtilities.FirstOfYear(PlanParent.DateValidFrom));
                        }
                        else inflation_factor = 1;

                        // Determine salary and bonus with inflation
                        salary = TariffParent.AdjustedSalary(curDate) * inflation_factor * start_prorate;
                        start_prorate = 1;                                                                  // no pro rata after first month
                        bonus = TariffParent.Bonus(curDate) * inflation_factor;
                        expense_contribution = 0;

                        // Determine expenses
                        planHRExpenses = ExpenseGroupParent.GetExpenses(curDate);
                        if (planHRExpenses == null) throw new BOException("Invalid HR expense records while implementing an HR plan.");

                        foreach (var item in planHRExpenses)
                        {
                            // Apply exchange rate if applicable
                            exchange_rate = Currency.ApplyCurrency(1, curDate, idPlan, idCurrency);

                            // Determine inflation factor for expenses if applicable, for expenses the inflation factor is only applied to the ExpenseAmount and SalaryCap, as the salary is separately inflated
                            if (InflationRuleParent != null)
                            {
                                if (ExpenseGroupParent.DateInflationBase.HasValue && ExpenseGroupParent.DateInflationBase.Value.Year > 2000)    // avoid unlogical inflation base date
                                    inflation_factor = InflationRuleParent.InflationFactor(curDate, ExpenseGroupParent.DateInflationBase.Value);
                                else
                                    inflation_factor = InflationRuleParent.InflationFactor(curDate, BOUtilities.FirstOfYear(PlanParent.DateValidFrom));
                            }
                            else inflation_factor = 1;

                            // when expense is specified only as absolute amount - use the absolute amount
                            if (item.RatioToSalary == 0)
                                expense = item.ExpenseAmount * inflation_factor;

                            // if an expense rate from salary is defined:
                            else
                            {
                                // calculate base salary expense and cap at expense amount
                                expense = salary * item.RatioToSalary;                                  // inflation not applied to expense ratio, as inflation already applied to salary
                                expense_cap = item.SalaryCap * item.RatioToSalary * inflation_factor;   // inflation applied to salary cap

                                if (expense_cap > 0) expense = Math.Min(expense, expense_cap);

                                // check whether expense rate is applied on bonus payment as well
                                if (bonus > 0 && item.ApplyToBonusMode != (short)TypeBonusExpenseModeEnum.Exclude)
                                {
                                    // if expense rate is applied to full bonus without cap (or no cap defined)
                                    if (item.ApplyToBonusMode == (short)TypeBonusExpenseModeEnum.Add || expense_cap == 0)
                                    {
                                        expense += bonus * item.RatioToSalary;
                                        if (expense_cap > 0) expense = Math.Min(expense, expense_cap * inflation_factor);
                                    }

                                    // if expense is calculated by spreading bonus over 12 months and applying monthly cap
                                    else
                                        expense = 12 * (Math.Min(expense + (bonus / 12 * item.RatioToSalary), expense_cap) - expense) + expense;
                                }
                            }

                            // determine portion of expense deducted from salary
                            expense_contribution += expense * item.DeductFromSalary;

                            // book expense - Cost Center from plan element except if fixed cost center is defined for expense item
                            BookRecord.BookPlannedRecord(curDate, expense * exchange_rate, PlanInstanceParent, item.AccountExpenseParent, 
                                                                cashAccount, item.TitleExpense, item.CostCenterFixedParent);
                        }

                        // book salary and bonus
                        BookRecord.BookPlannedRecord(curDate, (salary - expense_contribution) * exchange_rate, 
                                                        PlanInstanceParent, TariffParent.AccountSalaryParent, cashAccount, "Gehalt"); // ACTION: Literal string, localize
                        if (bonus > 0)
                            BookRecord.BookPlannedRecord(curDate, bonus * exchange_rate, PlanInstanceParent, 
                                                        TariffParent.AccountSalaryParent, cashAccount, "Bonus"); // ACTION: Literal string, localize

                        // next month
                        curDate = curDate.AddMonths(1);
                    }

                    VerumInstance.TransactionEnd();

                    return;
                }
                catch (Exception ex)
                {

                    BOUtilities.TraceErrors(ex);
                    VerumInstance.TransactionRollback();

                    throw new BOException("Error during implementation of HR plan element.",
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
                if (planElement.TypePlanElement != (short)TypePlanElementEnum.Personnel)
                    throw new BOException("The type of the plan element and plan item is not the same.", BOResult.PlanElementInvalidItemType, title);

                // if planInstance for plan and element already exists
                else if (planElementInstance.GetViaElement(planElement.Id, idPlan))
                {
                    var par = planElementInstance.Id;
                    var obj = VerumInstance.Context.tPlanElementHR.Where(b => b.idPlanInstance == par);

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
                planElement.TypePlanElement = (short)TypePlanElementEnum.Personnel;
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
                var tariff = TariffParent;

                _db.Database.ExecuteSqlCommand($"DELETE FROM [dbo].[tPlanElementHR] WHERE idPlanInstance=Cast('{idPlanInstance}' as uniqueidentifier)");
                VerumInstance.SaveChanges(true);

                if (tariff != null && !tariff.FlagShared) 
                        tariff.Delete();


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
                    var targetElement = new PlanElementHR();
                    targetElement.Clone(this);
                    targetElement.idPlanInstance = targetInstance.Id;
                    targetElement.CommitChanges();

                    if (TariffParent != null)
                        targetElement.idTariff = this.TariffParent.GetCopy(targetPlan).Id;

                    if (ExpenseGroupParent != null)
                        targetElement.idExpenseGroup = this.ExpenseGroupParent.GetCopy(targetPlan).Id;

                    if (InflationRuleParent != null)
                        targetElement.idInflationRule = InflationRuleParent.GetCopy(targetPlan).Id;

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

            }
            else
            {
                if (idPlanInstance == null || idPlanInstance == Guid.Empty)
                    idPlanInstance = Guid.NewGuid();
            }

        }
    }
}
