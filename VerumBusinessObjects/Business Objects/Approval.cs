
namespace VerumBusinessObjects
{
    using System;
    using System.Linq;
    using VerumBusinessObjects.Framework;

    public partial class Approval : BusinessObject<tApproval>, IApproval
    {
        public static BOCollection<Approval, tApproval> GetBOCollection()
        {
            // select all cost centers for the current client
            var query = VerumInstance.Context.tApproval.Where<tApproval>(b => b.idClient == VerumInstance.IdClient).OrderByDescending(b => b.DateCreated);
            return new BOCollection<Approval, tApproval>(query);
        }

    }
}