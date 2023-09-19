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
    /// Specifies section titles for grouping account for reporting purposes
    /// </summary>    
    public partial class AccountMainGroup : BusinessObject<tAccountMainGroup>, IAccountMainGroup
    {
        public bool SelectViaKey(string title)
        {
            var attr = (StringLengthAttribute)typeof(tAccountMainGroup).GetProperty("TitleLocalMainGroup").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (title.Length > len)
                    title = title.Substring(0, attr.MaximumLength);
            }

            var obj = VerumInstance.Context.tAccountMainGroup.Where(b => b.TitleLocalMainGroup == title && b.idClient == VerumInstance.IdClient);

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

        public static BOCollection<AccountMainGroup, tAccountMainGroup> GetBOCollection()
        {
            // select all cost centers for the current client
            var query = VerumInstance.Context.tAccountMainGroup.Where<tAccountMainGroup>(b => b.idClient == VerumInstance.IdClient).OrderBy(b => b.idClient);
            return new BOCollection<AccountMainGroup, tAccountMainGroup>(query);
        }

        public override void _CustomInit()
        {
            if (!Bound)
                idClient = VerumInstance.IdClient;
        }

        public bool isUsed()
        {
            var obj = VerumInstance.Context.tAccountGroup.Where(b => b.idAccountMainGroup == Id && b.idClient == VerumInstance.IdClient);

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
                    VerumInstance.Context.tAccountMainGroup.Remove(data);               // ACTION: Delete dependant items if possible!!
                    VerumInstance.TransactionEnd();
                    return BOResult.Success;
                }
                else
                {
                    return BOResult.AccountMainGroupCannotDelete;
                }
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                return BOResult.GeneralError;
            }
        }

    }
}
