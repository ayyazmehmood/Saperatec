using DocumentFormat.OpenXml.Office2010.Excel;
using DocumentFormat.OpenXml.Office2013.Excel;
using DocumentFormat.OpenXml.Spreadsheet;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Collections.ObjectModel;
using VerumBusinessObjects;
using VerumBusinessObjects.CommonModel;
using VerumBusinessObjects.Framework;

namespace VerumAPI.ApiController
{
    [ApiController]
    [Route("[controller]/[action]")]
    public class BackgroundRunController : ControllerBase
    {
        public static Task myTask = null;
        private BOCollection<CostCenter, tCostCenter> BOColl;
        private List<CostCenterModel> costCenterList;
        public static List<RunningClientModel> runningClientModels = new List<RunningClientModel>();
        private readonly IConfiguration _configuration;
        private readonly string _connectionString = "";
        public BackgroundRunController(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString =  _configuration.GetConnectionString("DBConnectionDevelop");
        }

        [HttpPost(Name = "UpdateBookRecord")]
        public async Task<ApiResponse<object>> UpdateBookRecord(Guid? clietId, Guid? userId)
        {
            bool run = true;

            // Create a sample object or data
            var res = new ApiResponse<object>()
            {
                message = "Request processed successfully."
            };

            if (myTask != null)
            {
                if (myTask.Status == TaskStatus.Running || myTask.Status == TaskStatus.WaitingForActivation)
                {
                    if(clietId != Guid.Empty && clietId !=null)
                    {
                        var status = runningClientModels.Where(x => x.GuidId == clietId).Select(x => x).FirstOrDefault();
                        if (status != null)
                        {
                            if (status.IsRunning)
                                res.message = "Already running";
                            else
                                res.message = "Already into queue for running.";
                        }
                        else
                        {
                            runningClientModels.AddRange(Client.GetClientIds(clietId??Guid.Empty, userId??Guid.Empty));
                            res.message = "Added into queue for running.";
                        }
                    }
                    else
                        res.message = "Already running";

                    run = false;
                }
                else
                {
                    myTask.Dispose();
                    run = true;
                }
            }

            if (run)
            {
                
                myTask = Task.Run(async () => {
                    VerumSession.SetConnection(_connectionString);
                    runningClientModels = Client.GetClientIds(clietId ?? Guid.Empty, userId ?? Guid.Empty);
                    while (runningClientModels.Count > 0)
                    {
                        if(userId == null || userId==Guid.Empty)
                            VerumSession.CompanySession(Guid.Parse(_configuration.GetValue<string>("CronJobUserGuidId")), runningClientModels[0].GuidId, _connectionString);
                        else
                            VerumSession.CompanySession(runningClientModels[0].UserId, runningClientModels[0].GuidId, _connectionString);

                        runningClientModels[0].IsRunning = true;
                        runningClientModels[0].RunDateTime = DateTime.UtcNow;

                        await new BookingImport().UpdateBookTransactionAndRecord(runningClientModels[0]);
                        Client.UpdateLastCallDateBC(runningClientModels[0].GuidId, Convert.ToDateTime(runningClientModels[0].RunDateTime));
                        runningClientModels.RemoveAt(0);
                    }
                });
                res.message = "Start update book record";
                //await myTask; // if you want to wait this process then uncommment..
            }
            
            return res;
        }

        [HttpPost(Name = "UpdateInsertTransaction")]
        public async Task<ApiResponse<object>> UpdateInsertTransaction([FromBody] UpdateInsertTranReqModel reqModel)
        {
            // Create a sample object or data
            var res = new ApiResponse<object>()
            {
                message = "Inserted/Updated successfully."
            };

            VerumSession.CompanySession(reqModel.userId, reqModel.clientId, _connectionString);
            
            var clentModel = Client.GetClientIds(reqModel.clientId, reqModel.userId).FirstOrDefault();

            if(clentModel != null)
            {
                if(string.IsNullOrEmpty(clentModel.BCUrl))
                {
                    res.message = "Please update Dynamic Business Center API url.";
                }
                else
                {
                    clentModel.RunDateTime = DateTime.UtcNow;
                    var status = await new BookingImport().UpdateInsertSingleTransaction(reqModel.tranId, clentModel);
                    if (!((int)BOResult.Success == status))
                    {
                        res.message = "Something went wrong.";
                    }
                }
            }
            else
            {
                res.message = "Unable to find client.";
            }   
            
            return res;
        }

        //[HttpGet(Name="GetAzureCredentials")]
        //public async Task<Object> GetAzure()
        //{
        //    var obj = new
        //    {
        //        Secret = DynamicBusinessCenter.Secret,
        //        TenantId = DynamicBusinessCenter.TenantId,
        //        ClientID = DynamicBusinessCenter.ClientID,
        //    };

        //    return obj;
        //}

        //[HttpPost(Name ="LoginAdmin")]

        //public BOResult LoginAdmin(string user, string password )
        //{
        //    VerumSession.SetConnection(_connectionString);
        //    VerumSession verumSession = new VerumSession();
        //    return verumSession.Logon(user, password, _connectionString);
        //}
        
        //[HttpGet(Name ="GetTCostCenter")]

        //public List<CostCenterModel> CostCenters()
        //{
        //    BOColl = CostCenter.GetBOCollection();
        //    costCenterList =  new List<CostCenterModel>();

        //    CostCenterModel obj;
        //    foreach (var item in BOColl)
        //    {
        //        obj = new CostCenterModel();
        //        obj.Id = item.Id;
        //        obj.DateCreated = item.DateCreated;
        //        obj.DateUpdated = item.DateUpdated;
        //        obj.idClient = item.idClient;
        //        obj.CostCenterCode = item.CostCenterCode;
        //        obj.TitleCostCenter = item.TitleCostCenter;
        //        obj.TitleEnglishCostCenter = item.TitleEnglishCostCenter;
        //        obj.FlagProfitCenter = item.FlagProfitCenter;
        //        obj.DescriptionCostCenter = item.DescriptionCostCenter;
                
        //        costCenterList.Add(obj);
        //    }

        //    return costCenterList;


        //}
    }
}
