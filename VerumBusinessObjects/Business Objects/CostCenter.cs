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
    using System.ComponentModel.DataAnnotations;
    using DocumentFormat.OpenXml.Office2010.ExcelAc;
    using System.Collections.Generic;

    public partial class CostCenter : BusinessObject<tCostCenter>, ICostCenter
    {

        public static BOCollection<CostCenter, tCostCenter> GetBOCollection()
        {
            // select all cost centers for the current client
            var query = VerumInstance.Context.tCostCenter.Where<tCostCenter>(b => b.idClient == VerumInstance.IdClient).OrderBy(b => b.CostCenterCode);
            return new BOCollection<CostCenter, tCostCenter>(query);
        }

        public static bool CheckKeyExists(string code)
        {
            if (code == null)
                return false;

            var attr = (StringLengthAttribute)typeof(tCostCenter).GetProperty("CostCenterCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (code.Length > len)
                    code = code.Substring(0, attr.MaximumLength);
            }

            var obj = VerumInstance.Context.tCostCenter.Where(b => b.CostCenterCode == code && b.idClient == VerumInstance.IdClient);

            if (obj.Count() == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        public BOResult Delete()
        {
            try
            {
                var obj = VerumInstance.Context.tBookTransaction.Where(b => b.CostCenterCode == CostCenterCode && b.idClient == VerumInstance.IdClient);

                if (obj.Count() == 0)
                {
                    VerumInstance.TransactionStart();
                    VerumInstance.Context.tCostCenter.Remove(data);               // ACTION: Delete dependant items if possible!!
                    VerumInstance.TransactionEnd();
                    return BOResult.Success;
                }
                else
                {
                    return BOResult.CostCenterCannotDelete;
                }
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                return BOResult.GeneralError;
            }
        }

        public bool SelectViaKey(string code)
        {
            if (code == null)
                return false;

            var attr = (StringLengthAttribute)typeof(tCostCenter).GetProperty("CostCenterCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (code.Length > len)
                    code = code.Substring(0, attr.MaximumLength);
            }

            var obj = VerumInstance.Context.tCostCenter.Where(b => b.CostCenterCode == code && b.idClient == VerumInstance.IdClient);

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

        // Private members

        public override void _CustomInit()
        {
            if (!Bound)
                idClient = VerumInstance.IdClient;
        }

        public static List<tCostCenter> GetCollection()
        {
            // select all cost centers for the current client
            var query = VerumInstance.Context.tCostCenter.Where<tCostCenter>(b => b.idClient == VerumInstance.IdClient).OrderBy(b => b.CostCenterCode);
            return query.ToList<tCostCenter>();
        }
    }
}
