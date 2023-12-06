using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using VerumBusinessObjects.CommonModel;
using VerumBusinessObjects.Framework;
using VerumBusinessObjects;
using DocumentFormat.OpenXml.Spreadsheet;
using Microsoft.AspNetCore.Cors;

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
        private BOCollection<User, tUser> tuser;
        private BOCollection<User, tUser> users;
        private readonly IConfiguration _configuration;
        private readonly string _connectionString = "";
        public TablesController(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("DBConnectionDevelop");
        }

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
        public string Updatetcostcentertable(CostCenterModel model)
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

        [HttpDelete(Name = "DeleteTCostCenter")]
        [EnableCors("AllowAll")]
        public string Deletetcostcenter(CostCenterModel model)
        {
            CostCenter costCenter = new CostCenter();
            tCostCenter costCenterDb = new tCostCenter();
            costCenterDb = CostCenter.GetCollectionById(model.Id);
            return costCenter.DeleteCostCenter(costCenterDb);
            
        }
    }
}
