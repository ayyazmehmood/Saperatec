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


    /// <summary>
    /// Specifies titles for grouping account for reporting purposes
    /// </summary>    
    public partial class AccountGroup : BusinessObject<tAccountGroup>, IAccountGroup
    {
        public bool SelectViaAccountCode( int code)
        {
            var obj = VerumInstance.Context.tAccountGroup.Where(b => b.AccountCodeFrom <= code && b.AccountCodeTo >= code && b.idClient == VerumInstance.IdClient)
                                    .OrderBy( b => b.AccountCodeFrom);

            if (obj.Count() == 0)
                return false;
            else
            {
                Id = obj.FirstOrDefault().Id;
                return true;
            }
        }
        /// <summary>
        /// this function are using if AccountCode is greater then 70000 and less then 100000
        /// also this function are using if AccountCode is greater then 10000 and less then not equal 70000
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public bool SelectViaAccountCodeVender(int code)
        {
            IOrderedQueryable<tAccountGroup> obj = null;

            if (code >= 70000 && code <100000)
                 obj = VerumInstance.Context.tAccountGroup.Where(b => b.AccountCodeFrom >= 70000 && b.AccountCodeFrom >= code && b.AccountCodeTo < 100000 && b.idClient == VerumInstance.IdClient)
                                    .OrderBy(b => b.AccountCodeFrom);
            else if(code >= 10000 && code < 70000)
                obj = VerumInstance.Context.tAccountGroup.Where(b => b.AccountCodeFrom >= 10000 && b.AccountCodeFrom >= code && b.AccountCodeTo < 70000 && b.idClient == VerumInstance.IdClient)
                                   .OrderBy(b => b.AccountCodeFrom);
            else 
                return false;

            if (obj.Count() == 0)
                return false;
            else
            {
                Id = obj.FirstOrDefault().Id;
                return true;
            }
        }

        public bool SelectViaKey(string title)
		{
            var attr = (StringLengthAttribute)typeof(tAccountGroup).GetProperty("TitleLocalAccountGroup").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (title.Length > len)
                    title = title.Substring(0, attr.MaximumLength);
            }

            var obj = VerumInstance.Context.tAccountGroup.Where(b => b.TitleLocalAccountGroup == title && b.idClient == VerumInstance.IdClient);

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

        public static BOCollection<AccountGroup, tAccountGroup> GetBOCollection()
        {
            // select all cost centers for the current client
            var query = VerumInstance.Context.tAccountGroup.Where<tAccountGroup>(b => b.idClient == VerumInstance.IdClient).OrderBy(b => b.idClient);
            return new BOCollection<AccountGroup, tAccountGroup>(query);
        }

        public override void _CustomInit()
        {
            if (!Bound)
                idClient = VerumInstance.IdClient;
        }

        public bool isUsed()
        {
            var obj = VerumInstance.Context.tAccount.Where(b => b.idAccountGroup == Id && b.idClient == VerumInstance.IdClient);

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
                    VerumInstance.Context.tAccountGroup.Remove(data);               // ACTION: Delete dependant items if possible!!
                    VerumInstance.TransactionEnd();
                    return BOResult.Success;
                }
                else
                {
                    return BOResult.AccountGroupCannotDelete;
                }
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                return BOResult.GeneralError;
            }
        }

        public static List<tAccountGroup> GetAccountGroupAllList()
        {
            var query = VerumInstance.Context.tAccountGroup;
            return query.ToList<tAccountGroup>();
        }
    }
}
