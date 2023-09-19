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

    public partial class JobReportItem : BusinessObject<tJobReportItem>
    {

        public static BOCollection<JobReportItem, tJobReportItem> GetBOCollection(JobReport job)
        {
            var query = VerumInstance.Context.tJobReportItem.Where<tJobReportItem>(b => b.idJobReport == job.Id);
            return new BOCollection<JobReportItem, tJobReportItem>(query);
        }

        public static List<tJobReportItem> GetTableList(JobReport job)
        {
            var query = VerumInstance.Context.tJobReportItem.Where<tJobReportItem>(b => b.idJobReport == job.Id);
            return query.ToList();
        }
    }
}
