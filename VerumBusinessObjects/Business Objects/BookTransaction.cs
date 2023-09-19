namespace VerumBusinessObjects
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;
    using System.Dynamic;
    using System.Diagnostics;
    using System.Data.Entity.Validation;
    using System.Collections.Generic;
    using System.Collections;
    using VerumBusinessObjects.Framework;

    public partial interface IBookTransaction
    {
    }

    /// <summary>
    /// Business Object <c>BookTransaction</c>: A booking record includes two transactions one for debit and one for credit. 
    /// This is separated from the record object for better reporting functionality
    /// </summary>    
    public partial class BookTransaction : BusinessObject<tBookTransaction>, IBookTransaction
    {

        public string AccountReportTitle { get => AccountReportParent.TitleLocalAccount;  }

        public override void _CustomInit()
        {
            if (!Bound)
                idClient = VerumInstance.IdClient;
        }
        public static BOCollection<BookTransaction, tBookTransaction> GetBOCollection(Guid planId)
        {
            var query = VerumInstance.Context.tBookTransaction.Where<tBookTransaction>(b => b.idClient == VerumInstance.IdClient && b.idPlan == planId);
            return new BOCollection<BookTransaction, tBookTransaction>(query);
        }

        public static BOCollection<BookTransaction, tBookTransaction> GetBOCollection()
        {
            var query = VerumInstance.Context.tBookTransaction.Where<tBookTransaction>(b => b.idClient == VerumInstance.IdClient);
            return new BOCollection<BookTransaction, tBookTransaction>(query);
        }

        public static BOCollection<BookTransaction, tBookTransaction> GetBOCollectionFromRecord(Guid recordId)
        {
            var query = VerumInstance.Context.tBookTransaction.Where<tBookTransaction>(b => b.idClient == VerumInstance.IdClient && b.idBookingRecord == recordId);
            return new BOCollection<BookTransaction, tBookTransaction>(query);
        }

        public static IQueryable<tBookTransaction> GetBookRecordTran(List<int> BCTransactionNos)
        {
            var query = VerumInstance.Context.tBookTransaction
                .Where(b => b.idClient == VerumInstance.IdClient && BCTransactionNos.Select(i => (int?)i).ToList().Contains(b.BCTransactionNo));

            return query;
        }
    }
}
