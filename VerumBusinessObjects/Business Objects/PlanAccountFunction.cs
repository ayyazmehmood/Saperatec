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
    using VerumBusinessObjects.Properties;

    /// <summary>
    /// Class <c>Plan</c> Assigns accounts to specific planning item functions (eg. Debitor, creditor accounts, selection of accounts for contract items, advance booking, etc.)
    /// </summary>
    public partial interface IPlanAccountFunction
    {
        Account PayablesAccountDefault();
        Account ReceivablesAccountDefault();
    }

    public partial class PlanAccountFunction : BusinessObject<tPlanAccountFunction>, IPlanAccountFunction
    {
        public static Account GetAccountFunctionFirst(TypeAccountFunctionEnum functionCode)
        {
            try
            {
                tPlanAccountFunction query = VerumInstance.Context.tPlanAccountFunction.Where(b => (b.TypeAccountFunction == (short)functionCode && b.idClient == VerumInstance.IdClient)).First();
                var acc = new Account();
                acc.Id = query.idAccountPlanAccountFunction;
                return acc;
            }
            catch                   // when the client master data does not include at least a single entry for the function code 
            {
                return null;
            }
        }

        public Account PayablesAccountDefault()
        {
            var acc = GetAccountFunctionFirst(TypeAccountFunctionEnum.PayablesDefault);

            if (acc == null) throw new BOException("Default payables account for client not specified.",
                                     BOResult.AccountMissingFunction,
                                     TypeAccountFunctionEnum.PayablesDefault.ToString());
            else
                return acc;
        }

        public Account ReceivablesAccountDefault()
        {
            var acc = GetAccountFunctionFirst(TypeAccountFunctionEnum.ReceivablesDefault);

            if (acc == null) throw new BOException("Default receivables account for client not specified.",
                                     BOResult.AccountMissingFunction, 
                                     TypeAccountFunctionEnum.ReceivablesDefault.ToString());
            else
                return acc;
        }

        public Account CashAccountDefault()
        {
            var acc = GetAccountFunctionFirst(TypeAccountFunctionEnum.CashDefault);

            if (acc == null) throw new BOException("Default cash account for client not specified.",
                                     BOResult.AccountMissingFunction,
                                     TypeAccountFunctionEnum.CashDefault.ToString());
            else
                return acc;
        }

        public Account AdvanceReceivedDefault()
        {
            var acc = GetAccountFunctionFirst(TypeAccountFunctionEnum.AdvanceReceivedDefault);

            if (acc == null) throw new BOException("Default advance received account for client not specified.",
                                     BOResult.AccountMissingFunction,
                                     TypeAccountFunctionEnum.AdvanceReceivedDefault.ToString());
            else
                return acc;
        }

        public Account AdvancePaidDefault()
        {
            var acc = GetAccountFunctionFirst(TypeAccountFunctionEnum.AdvancePaidDefault);

            if (acc == null) throw new BOException("Default advance paid account for client not specified.",
                                     BOResult.AccountMissingFunction,
                                     TypeAccountFunctionEnum.AdvancePaidDefault.ToString());
            else
                return acc;
        }

        public Account SalaryDefault()
        {
            return GetAccountFunctionFirst(TypeAccountFunctionEnum.SalaryDefault);

            /*if (acc == null) throw new BOException("Default salary account for client not specified.",
                                     BOResult.AccountMissingFunction,
                                     TypeAccountFunctionEnum.SalaryDefault.ToString());
            else
                return acc;*/
        }

        public bool SelectViaKey(int code)
        {
            var obj = VerumInstance.Context.tPlanAccountFunction.Where(b => b.TypeAccountFunction == code && b.idClient == VerumInstance.IdClient);

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

    }
}
