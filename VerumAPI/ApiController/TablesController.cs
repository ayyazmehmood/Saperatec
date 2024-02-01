using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using VerumBusinessObjects.CommonModel;
using VerumBusinessObjects.Framework;
using VerumBusinessObjects;
using DocumentFormat.OpenXml.Spreadsheet;
using Microsoft.AspNetCore.Cors;
using Microsoft.Office.Core;

namespace VerumAPI.ApiController
{
    [Route("[controller]/[action]")]
    [EnableCors("AllowAll")]
    [ApiController]
    public class TablesController : ControllerBase
    {
        public static Task myTask = null;
        private BOCollection<CostCenter, tCostCenter> BOColl;
        private List<CostCenterModel> costCenterList;
        private List<tAuthority> authoritylist;
        private List<tApproval> ApprovalList;
        private BOCollection<User, tUser> tuser;
        private BOCollection<User, tUser> users;
        private readonly IConfiguration _configuration;
        private readonly string _connectionString = "";
        public TablesController(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("DBConnectionDevelop");
        }

        // For Tcost Center Table

        [HttpGet(Name = "GetTCostCenterTable")]

        public List<CostCenterModel> GetTcostcenterTable()
        {
            BOColl = CostCenter.GetBOCollection();
            costCenterList = new List<CostCenterModel>();

            CostCenterModel obj;
            foreach (var item in BOColl)
            {
                obj = new CostCenterModel();
                obj.Id = item.Id;
                obj.DateCreated = item.DateCreated;
                obj.DateUpdated = item.DateUpdated;
                obj.idClient = item.idClient;
                obj.CostCenterCode = item.CostCenterCode;
                obj.TitleCostCenter = item.TitleCostCenter;
                obj.TitleEnglishCostCenter = item.TitleEnglishCostCenter;
                obj.FlagProfitCenter = item.FlagProfitCenter;
                obj.DescriptionCostCenter = item.DescriptionCostCenter;

                costCenterList.Add(obj);
            }

            return costCenterList;


        }

        [HttpPost(Name = "AddtCostCenter")]
        [EnableCors("AllowAll")]
        public string AddCostCenter(CostCenterModel model)
        {
            CostCenter costCenter = new CostCenter();
            tCostCenter costCenterDb = new tCostCenter();
            costCenter.New();
            costCenterDb.Id=costCenter.Id;
            costCenterDb.DateCreated = DateTime.UtcNow;
            costCenterDb.CostCenterCode = model.CostCenterCode;
            costCenterDb.TitleCostCenter = model.TitleCostCenter;
            costCenterDb.TitleEnglishCostCenter = model.TitleEnglishCostCenter;
            costCenterDb.FlagProfitCenter = model.FlagProfitCenter;
            costCenterDb.DescriptionCostCenter = model.DescriptionCostCenter;
            costCenterDb.DateUpdated = DateTime.UtcNow;
            costCenterDb.idClient = VerumInstance.IdClient;
            return costCenter.AddCostCenter(costCenterDb);

        }

        [HttpPut(Name = "UpdatetCostCenter")]
        [EnableCors("AllowAll")]
        public string UpdatetCostCenter(CostCenterModel model)
        {
            CostCenter costCenter = new CostCenter();
            tCostCenter costCenterDb = new tCostCenter();
            costCenterDb = CostCenter.GetCollectionById(model.Id);
            costCenterDb.CostCenterCode = model.CostCenterCode;
            costCenterDb.TitleCostCenter = model.TitleCostCenter;
            costCenterDb.TitleEnglishCostCenter = model.TitleEnglishCostCenter;
            costCenterDb.FlagProfitCenter = model.FlagProfitCenter;
            costCenterDb.DescriptionCostCenter = model.DescriptionCostCenter;
            costCenterDb.DateUpdated = DateTime.UtcNow;
            return costCenter.UpdateCostCenter(costCenterDb);
            
        }

        [HttpPost(Name = "DeleteTCostCenter")]
        [EnableCors("AllowAll")]
        public string Deletetcostcenter(CostCenterModel model)
        {
            CostCenter costCenter = new CostCenter();
            tCostCenter costCenterDb = new tCostCenter();
            costCenterDb = CostCenter.GetCollectionById(model.Id);
            return costCenter.DeleteCostCenter(costCenterDb);
            
        }

        // For Authority Table

        [HttpGet(Name = "GetTAuthority")]

        public List<tAuthority> GetTAuthority()
        {
            var BOColl = Authority.GetBOCollection();
            authoritylist =  new List<tAuthority>();

            tAuthority obj;
            foreach (var item in BOColl)
            {
                obj = new tAuthority();
                obj.Id = item.Id;
                obj.DateCreated = item.DateCreated;
                obj.DateUpdated = item.DateUpdated;
                obj.idClient = item.idClient;
                obj.CostCenter = item.CostCenter;
                obj.ApprovalLimit= item.ApprovalLimit;
                obj.idUser = item.idUser;
                obj.IdMigrate = item.IdMigrate;
                obj.UserRole = item.UserRole;
                obj.RefCode = item.RefCode;

                authoritylist.Add(obj);
            }

            return authoritylist;


        }

        [HttpPost(Name = "AddtAuthority")]
        [EnableCors("AllowAll")]
        public string AddtAuthority(AuthorityModel model)
        {
            Authority Authority_ = new Authority();
            tAuthority authorityDb = new tAuthority();
            Authority_.New();
            authorityDb.Id = Authority_.Id;
            authorityDb.DateCreated = DateTime.UtcNow;
            authorityDb.CostCenter = model.CostCenter;
            authorityDb.DateUpdated = DateTime.UtcNow;
            authorityDb.idClient = VerumInstance.IdClient;
            authorityDb.idUser = VerumInstance.User.Id;
            authorityDb.IdMigrate = VerumInstance.User.IdMigrate;
            authorityDb.RefCode = model.RefCode;
            authorityDb.ApprovalLimit = model.ApprovalLimit;
            authorityDb.UserRole = model.UserRole;
            return Authority_.AddAuthority(authorityDb);

        }

        [HttpPut(Name = "UpdatetAuthority")]
        [EnableCors("AllowAll")]
        public string UpdatetAuthority(tAuthority model)
        {
            Authority authority = new Authority();
            tAuthority authorityDb = new tAuthority();
            authorityDb = Authority.GetCollectionById(model.Id);
            authorityDb.CostCenter = model.CostCenter;
            authorityDb.UserRole= model.UserRole;
            authorityDb.ApprovalLimit= model.ApprovalLimit;
            authorityDb.IdMigrate = model.IdMigrate;
            authorityDb.RefCode= model.RefCode;
            authorityDb.DateUpdated = DateTime.UtcNow;
            return authority.UpdatetAuthority(authorityDb);

        }

        [HttpPost(Name = "DeletetAuthority")]
        [EnableCors("AllowAll")]
        public string DeletetAuthority(tAuthority model)
        {
            Authority authority = new Authority();
            tAuthority authorityDb = new tAuthority();
            authorityDb = Authority.GetCollectionById(model.Id);
            return authority.DeleteAuthority(authorityDb);

        }

        // For Apporval Table
        [HttpGet(Name = "GetTApproval")]

        public List<tApproval> GetTApproval()
        {
            var BOColl = Approval.GetBOCollection();
            ApprovalList = new List<tApproval>();

            tApproval obj;
            foreach (var item in BOColl)
            {
                obj = new tApproval();
                obj.Id = item.Id;
                obj.DateCreated = item.DateCreated;
                obj.DateUpdated = item.DateUpdated;
                obj.CostCenterCode = item.CostCenterCode;
                obj.ApproverOneEmail = item.ApproverOneEmail;
                obj.ApproverTwoEmail = item.ApproverTwoEmail;
                obj.ApproverThreeEmail = item.ApproverThreeEmail;
                obj.RefCode = item.RefCode;
                obj.DocumentNumber = item.DocumentNumber;
                obj.ApprovalAmount = item.ApprovalAmount;
                obj.ApprovalFinal = item.ApprovalFinal;
                obj.ApprovalObject = item.ApprovalObject;

                ApprovalList.Add(obj);
            }

            return ApprovalList;


        }


    }
}
