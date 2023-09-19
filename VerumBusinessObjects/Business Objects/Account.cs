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
    using DocumentFormat.OpenXml.Office2010.ExcelAc;
    using System.Collections.Generic;
    using DocumentFormat.OpenXml.Office2013.Drawing.ChartStyle;
    using VerumBusinessObjects.Views;

    public partial class Account : BusinessObject<tAccount>, IAccount
    {

        public bool SelectViaKey(int code)
        {
            var obj = VerumInstance.Context.tAccount.Where(b => b.AccountCode == code && b.idClient == VerumInstance.IdClient);

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

        partial void _TypeAccountValid(short value, ref bool valid)
        {
            if (Enum.IsDefined(typeof(TypeAccountEnum), value)) valid = true;
            else throw new BOException("Invalid account type code assigned", BOResult.AccountTypeInvalid, value.ToString());
        }

        public override void _CustomInit()
        {
            if (!Bound)
                idClient = VerumInstance.IdClient;
        }

        public static BOCollection<Account, tAccount> GetBOCollection()
        {
            // select all cost centers for the current client
            var query = VerumInstance.Context.tAccount.Where<tAccount>(b => b.idClient == VerumInstance.IdClient).OrderBy(b => b.idClient);
            return new BOCollection<Account, tAccount>(query);
        }

        public bool isUsed()
        {
            var obj = VerumInstance.Context.tBookTransaction.Where(b => b.idAccountBooking == Id && b.idClient == VerumInstance.IdClient);

            if (obj.Count() == 0) return false;
            else return true;
        }

        public BOResult Delete()
        {
            try
            {
                if (!this.isUsed())
                {
                    VerumInstance.TransactionStart();
                    VerumInstance.Context.tAccount.Remove(data);               // ACTION: Delete dependant items if possible!!
                    VerumInstance.TransactionEnd();
                    return BOResult.Success;
                }
                else
                {
                    return BOResult.AccountCannotDelete;
                }
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                return BOResult.GeneralError;
            }
        }

        public static List<Int32> GetAccountCode()
        {
            // select all cost centers for the current client
            var query = VerumInstance.Context.tAccount.Where<tAccount>(b => b.idClient == VerumInstance.IdClient).Select(x => x.AccountCode).Distinct();
            return query.ToList<Int32>();
        }

        public static List<AccountCodeModel> GetAccountCodeModels()
        {
            // select all cost centers for the current client
            var query = VerumInstance.Context.tAccount.Where<tAccount>(b => b.idClient == VerumInstance.IdClient).Select(x => new AccountCodeModel
            {
                Guid = x.Id,
                AccountCode = x.AccountCode
            });

            return query.ToList<AccountCodeModel>();
        }

        public static List<tAccount> GetAccountAllList()
        {
            var query = VerumInstance.Context.tAccount;
            return query.ToList<tAccount>();
        }

    }
}
