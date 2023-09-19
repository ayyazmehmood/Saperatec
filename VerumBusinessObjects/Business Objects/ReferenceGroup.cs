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

    public partial interface ICurrency
    {

    }

    /// <summary>
    /// Specifies groups of reference codes to link booking records to contracts, inventory items, personnel, etc.
    /// </summary>    
    public partial class ReferenceGroup : BusinessObject<tReferenceGroup>, IReferenceGroup
    {
        public bool SelectViaKey(string title)
        {
            var attr = (StringLengthAttribute)typeof(tReferenceGroup).GetProperty("TitleReferenceGroup").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (title.Length > len)
                    title = title.Substring(0, len);
            }

            var obj = VerumInstance.Context.tReferenceGroup.Where(b => b.TitleReferenceGroup == title && b.idClient == VerumInstance.IdClient);

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

        public static BOCollection<ReferenceGroup, tReferenceGroup> GetBOCollection()
        {
            // select all cost centers for the current client
            var query = VerumInstance.Context.tReferenceGroup.Where<tReferenceGroup>(b => b.idClient == VerumInstance.IdClient).OrderBy(b => b.idClient);
            return new BOCollection<ReferenceGroup, tReferenceGroup>(query);
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
                var obj = VerumInstance.Context.tReferenceCode.Where(b => b.idReferenceGroup == Id && b.idClient == VerumInstance.IdClient);

                if (obj.Count() == 0)
                {
                    VerumInstance.TransactionStart();
                    VerumInstance.Context.tReferenceGroup.Remove(data);               // ACTION: Delete dependant items if possible!!
                    VerumInstance.TransactionEnd();
                    return BOResult.Success;
                }
                else
                {
                    return BOResult.ReferenceGroupCannotDelete;
                }
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                return BOResult.GeneralError;
            }
        }

        public static bool CheckGroupExists(string code)
        {
            if (code == null)
                return false;

            var attr = (StringLengthAttribute)typeof(tReferenceGroup).GetProperty("TitleReferenceGroup").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (code.Length > len)
                    code = code.Substring(0, attr.MaximumLength);
            }

            var obj = VerumInstance.Context.tReferenceGroup.Where(b => b.TitleReferenceGroup == code && b.idClient == VerumInstance.IdClient);

            if (obj.Count() == 0)
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
