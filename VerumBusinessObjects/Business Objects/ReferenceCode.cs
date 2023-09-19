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
    /// Specifies reference codes to link booking records to contracts, inventory items, personnel, etc.
    /// </summary>    
    public partial class ReferenceCode : BusinessObject<tReferenceCode>, IReferenceCode
    {

        public bool SelectViaKey(string code)
        {
            var attr = (StringLengthAttribute)typeof(tReferenceCode).GetProperty("RefCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (code.Length > len)
                    code = code.Substring(0, len);
            }

            var obj = VerumInstance.Context.tReferenceCode.Where(b => b.RefCode == code && b.idClient == VerumInstance.IdClient);

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
        
        public BOResult Delete()
        {            
            try
            {               
                if (!this.isUsed())
                {
                    VerumInstance.TransactionStart();
                    VerumInstance.Context.tReferenceCode.Remove(data);               // ACTION: Delete dependant items if possible!!
                    VerumInstance.TransactionEnd();
                    return BOResult.Success;
                }
                else
                {
                    return BOResult.ReferenceCodeCannotDelete;
                }
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                return BOResult.GeneralError;
            }
        }


        
        public static BOCollection<ReferenceCode, tReferenceCode> GetBOCollection()
        {
            // select all reference codes for the current client
            var query = VerumInstance.Context.tReferenceCode.Where<tReferenceCode>(b => b.idClient == VerumInstance.IdClient).OrderBy(b => b.RefCode);
            return new BOCollection<ReferenceCode, tReferenceCode>(query);
        }

        public static BOCollection<ReferenceCode, tReferenceCode> GetBOCollection(bool isActive)
        {
            // select all reference codes for the current client
            var query = VerumInstance.Context.tReferenceCode.Where<tReferenceCode>(b => b.idClient == VerumInstance.IdClient && b.FlagActive == isActive).OrderBy(b => b.RefCode);
            return new BOCollection<ReferenceCode, tReferenceCode>(query);
        }

        public static BOCollection<ReferenceCode, tReferenceCode> GetBOCollection(ReferenceGroup group)
        {
            // select all reference codes for the current client
            var query = VerumInstance.Context.tReferenceCode.Where<tReferenceCode>(b => b.idClient == VerumInstance.IdClient && b.idReferenceGroup == group.Id).OrderBy(b => b.RefCode);
            return new BOCollection<ReferenceCode, tReferenceCode>(query);
        }

        public static bool CheckCodeExists(string code)
        {
            if (code == null)
                return false;

            var attr = (StringLengthAttribute)typeof(tReferenceCode).GetProperty("RefCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (code.Length > len)
                    code = code.Substring(0, attr.MaximumLength);
            }

            var obj = VerumInstance.Context.tReferenceCode.Where(b => b.RefCode == code && b.idClient == VerumInstance.IdClient);
            
            if (obj.Count() == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        public bool isUsed()
        {
            var obj1 = VerumInstance.Context.tBookTransaction.Where(b => b.ReferenceIDBookTransaction == RefCode && b.idClient == VerumInstance.IdClient);
            var obj2 = VerumInstance.Context.tPlanElement.Where(b => b.ReferenceIDPlanElement == RefCode && b.idClient == VerumInstance.IdClient);

            if (obj1.Count() == 0 && obj2.Count() == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
    }
}
