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
    using System.Threading.Tasks;
    using System.Data.Entity.Infrastructure.Interception;
    using System.Windows.Threading;
    using DocumentFormat.OpenXml.Office2010.ExcelAc;
    using System.Collections.Generic;

    public partial class JobReport : BusinessObject<tJobReport>
    {
        public static BOCollection<JobReport, tJobReport> GetBOCollection()
        {
            // select all plans for the current client
            var query = VerumInstance.Context.tJobReport.Where<tJobReport>(b => b.idClient == VerumInstance.IdClient);
            return new BOCollection<JobReport, tJobReport>(query);
        }

        public static List<tJobReport> GetJob(Guid guidJobid)
        {
            // select all plans for the current client
            var query = VerumInstance.Context.tJobReport.Where<tJobReport>(b => b.Id == guidJobid);
            return query.ToList();
        }

        public List<JobReportItem> JobReportItemList = new List<JobReportItem>();

        public BOResult Delete()
        {
            try
            {
                VerumInstance.TransactionStart();
                VerumInstance.Context.tJobReport.Remove(data);               // ACTION: Delete dependant items if possible!!
                VerumInstance.TransactionEnd();
                return BOResult.Success;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                return BOResult.GeneralError;
            }
        }

        public bool EndJob()
        {
            try
            {
                if (_FlagActive)
                {
                    DateJobEnd = DateTime.UtcNow;
                    CommitChanges(true);
                    _FlagActive = false;

                    return true;
                }
                else
                    return false;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex);
                return false;
            }
        }

        public bool Report(TypeJobSuccessEnum jobSuccess, BOResult result = BOResult.GeneralError, string objectTitle = "", string contextInfo = "", string message = "", bool forBulkCommit=false)
        {
            try
            {
                if (_FlagActive)
                {
                    var item = new JobReportItem();
                    item.New();
                    item.idJobReport = Id;
                    item.Timestamp = DateTime.UtcNow;
                    item.TypeJobSuccess = (short)jobSuccess;
                    item.ResultCode = (int)result;
                    item.ObjectTitle = objectTitle;
                    item.ContextInfo = contextInfo;
                    item.Message = message;

                    if(forBulkCommit)
                        JobReportItemList.Add(item);
                    else
                        item.CommitChanges();

                    return true;
                }
                else
                    return false;

            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex);
                return false; ;
            }

        }

        public bool StartJob(TypeJobEnum typeJob)
        {
            try
            {
                New();
                idClient = VerumInstance.Client.Id;
                idUser = VerumInstance.User.Id;
                TypeJob = (short)typeJob;
                DateJobStart = DateTime.UtcNow;
                TypeJobSuccess = (short)TypeJobSuccessEnum.Success;
                CommitChanges(true);                // persist job
                _FlagActive = true;

                return true;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex);
                return false;
            }
        }
        public bool FlagActive { get => _FlagActive;  }
        bool _FlagActive = false;

        public static string CommitChangesBulkJobReportItem(List<tJobReportItem> tJobReportItems)
        {
            using (var transaction = VerumInstance.Context.Database.BeginTransaction())
            {
                try
                {
                    VerumInstance.Context.tJobReportItem.AddRange(tJobReportItems);

                    VerumInstance.Context.SaveChanges();

                    // Commit the transaction if everything is successful
                    transaction.Commit();

                    // return blank if there is no error
                    return string.Empty;
                }
                catch (Exception ex)
                {
                    // Rollback the transaction in case of an error
                    transaction.Rollback();
                    Console.WriteLine($"An error occurred: {ex.Message}");

                    return ex.Message;
                }
            }
        }
    }

    public class JobProgress : EventArgs
    {
        public int ItemsComplete { get; }
        public int ItemsCount { get; }
        public double Progress 
        { 
            get
            {
                return ItemsComplete / ItemsCount;
            }
        }

        public JobProgress(int itemsComplete, int itemsCount)
        {
            ItemsComplete = itemsComplete;
            ItemsCount = itemsCount;
        }
    }

}
