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

            return new BOCollection<CostCenter, tCostCenter>(query);
        }
        public static List<CostCenterModel> GetcostcenterDetails()
        {

            List<CostCenterModel> costcenterModel = new List<CostCenterModel>();
            var query = from costcenter in VerumInstance.Context.tCostCenter
                        join userBudget in VerumInstance.Context.tUser
                        on costcenter.idBudgetResponsible equals userBudget.Id into budgetGroup
                        from userBudget in budgetGroup.DefaultIfEmpty()
                        join userExecutive in VerumInstance.Context.tUser
                        on costcenter.idExecutiveApprover equals userExecutive.Id into executiveGroup
                        from userExecutive in executiveGroup.DefaultIfEmpty()
                        select new
                        {
                            Costcenter = costcenter,
                            UsernameBudget = userBudget != null ? userBudget.UserName : null,
                            UsernameExecutive = userExecutive != null ? userExecutive.UserName : null
                        };




            CostCenterModel costcenterObj = new CostCenterModel();
            foreach (var item in query)
            {
                costcenterObj = new CostCenterModel();
                costcenterObj.idBudgetResponsibleUserName = item.UsernameBudget;
                costcenterObj.idExecutiveApproverUserName = item.UsernameExecutive;
                costcenterObj.Id = item.Costcenter.Id;
                costcenterObj.DateCreated = item.Costcenter.DateCreated;
                costcenterObj.DateUpdated = item.Costcenter.DateUpdated;
                costcenterObj.idClient = item.Costcenter.idClient;
                costcenterObj.CostCenterCode = item.Costcenter.CostCenterCode;
                costcenterObj.TitleCostCenter = item.Costcenter.TitleCostCenter;
                costcenterObj.TitleEnglishCostCenter = item.Costcenter.TitleEnglishCostCenter;
                costcenterObj.FlagProfitCenter = item.Costcenter.FlagProfitCenter;
                costcenterObj.DescriptionCostCenter = item.Costcenter.DescriptionCostCenter;
                costcenterObj.idBudgetResponsible = item.Costcenter.idBudgetResponsible;
                costcenterObj.idExecutiveApprover = item.Costcenter.idExecutiveApprover;


                costcenterModel.Add(costcenterObj);
            }

            return costcenterModel;
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
