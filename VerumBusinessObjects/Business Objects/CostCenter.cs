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
    using VerumBusinessObjects.CommonModel;
    using DocumentFormat.OpenXml.Bibliography;
    using DocumentFormat.OpenXml.Office2013.Excel;
    using Newtonsoft.Json.Linq;
    using System;
    using System.Collections.Generic;
    using System.Collections.ObjectModel;
    using System.Data.Entity;
    using System.Drawing.Text;
    using System.Linq;
    using System.Net;
    using System.Security.Permissions;
    using System.Security.Policy;
    using System.Security.RightsManagement;
    using System.Text;
    using System.Threading;
    using System.Threading.Tasks;
    using System.Windows.Interop;
    using VerumBusinessObjects.Framework;
    using VerumBusinessObjects.Views;

    public partial class CostCenter : BusinessObject<tCostCenter>, ICostCenter
    {

        public static BOCollection<CostCenter, tCostCenter> GetBOCollection()
        {
            // select all cost centers for the current client
            var query = VerumInstance.Context.tCostCenter.Where<tCostCenter>(b => b.idClient == VerumInstance.IdClient).OrderBy(b => b.CostCenterCode);
            var query_ = VerumInstance.Context.tCostCenter
.Where(costCenter => costCenter.idClient == VerumInstance.IdClient)
.OrderBy(costCenter => costCenter.CostCenterCode)
.Join(
VerumInstance.Context.tUser,
costCenter => costCenter.idBudgetResponsible,
user => user.Id,
(costCenter, user) => new { CostCenter = costCenter, User = user }
)
.Select(joinResult => new
{
CostCenterCode = joinResult.CostCenter.CostCenterCode,
Username = joinResult.User.UserName
});
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

        #region API

        public static tCostCenter GetCollectionById(Guid costCenterId)
        {
            // select cost centers for the current client
            var query = VerumInstance.Context.tCostCenter.Where<tCostCenter>(b => b.Id == costCenterId);
            return query.FirstOrDefault<tCostCenter>();
        }

        public new BusinessObject<tCostCenter> New()
        {
            return New(Guid.NewGuid());
        }

        public  string UpdateCostCenter(tCostCenter model)
        {   
            _db.Entry(model).State = System.Data.Entity.EntityState.Modified;
            bool force=false;
            VerumInstance.SaveChanges(force);

            return "Update Record Successful";
        }
        public string DeleteCostCenter(tCostCenter model)
        {
            _db.tCostCenter.Remove(model);
            bool force = false;
            VerumInstance.SaveChanges(force);

            return "Delete Record Successful";
        }

        public string AddCostCenter(tCostCenter model)
        {
            _db.tCostCenter.Add(model);
            bool force = false;
            VerumInstance.SaveChanges(force);

            return "Add Record Successful";
        }

        #endregion
    }
}
