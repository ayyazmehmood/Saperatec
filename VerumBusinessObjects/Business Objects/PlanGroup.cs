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

    public partial class PlanGroup : BusinessObject<tPlanGroup>, IPlanGroup
    {

        public static BOCollection<PlanGroup, tPlanGroup> GetBOCollection()
        {
            // select all plan groups for the current client
            var query = VerumInstance.Context.tPlanGroup.Where<tPlanGroup>(b => b.idClient == VerumInstance.IdClient).OrderBy(b => b.TitlePlanGroup);
            return new BOCollection<PlanGroup, tPlanGroup>(query);
        }

        public bool SelectViaKey(string title)
        {
            var attr = (StringLengthAttribute)typeof(tPlanGroup).GetProperty("TitlePlanGroup").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (title.Length > len)
                    title = title.Substring(0, len);
            }

            var obj = VerumInstance.Context.tPlanGroup.Where(b => b.TitlePlanGroup == title && b.idClient == VerumInstance.IdClient);

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

    }
}
