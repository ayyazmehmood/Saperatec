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

    public partial class BookingRun : BusinessObject<tBookingRun>, IBookingRun
    {
        public void ClearAllBookRecords()
        {
            _db.tBookRecord.RemoveRange(_db.tBookRecord.Where(b => b.idBookingRun == Id));
            VerumInstance.SaveChanges();
        }

        public bool SelectViaKey(string code)
        {
            var attr = (StringLengthAttribute)typeof(tBookingRun).GetProperty("BookingRunCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (code.Length > len)
                    code = code.Substring(0, attr.MaximumLength);
            }

            var obj = VerumInstance.Context.tBookingRun.Where(b => b.BookingRunCode == code && b.idClient == VerumInstance.IdClient);

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

        public static BOCollection<BookingRun, tBookingRun> GetBOCollection()
        {
            // select all reference codes for the current client
            var query = VerumInstance.Context.tBookingRun.Where<tBookingRun>(b => b.idClient == VerumInstance.IdClient).OrderBy(b => b.SerialNum);
            return new BOCollection<BookingRun, tBookingRun>(query);
        }

    }
}
