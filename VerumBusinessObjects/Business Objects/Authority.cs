namespace VerumBusinessObjects
{
    using System;
    using System.Linq;
    using VerumBusinessObjects.Framework;

        public partial class Authority : BusinessObject<tAuthority>, IAuthority
    { 

        public static BOCollection<Authority, tAuthority> GetBOCollection()
        {
            // select all cost centers for the current client
            var query = VerumInstance.Context.tAuthority.Where<tAuthority>(b => b.idClient == VerumInstance.IdClient).OrderByDescending(b => b.CostCenter);
            return new BOCollection<Authority, tAuthority>(query);
        }

        public string AddAuthority(tAuthority model)
        {
            _db.tAuthority.Add(model);
            bool force = false;
            VerumInstance.SaveChanges(force);

            return "Add Record Successful";
        }

        public static tAuthority GetCollectionById(Guid authorityId)
        {
            // select cost centers for the current client
            var query = VerumInstance.Context.tAuthority.Where<tAuthority>(b => b.Id == authorityId);
            return query.FirstOrDefault<tAuthority>();
        }

        public string UpdatetAuthority(tAuthority model)
        {
            _db.Entry(model).State = System.Data.Entity.EntityState.Modified;
            bool force = false;
            VerumInstance.SaveChanges(force);

            return "Update Record Successful";
        }

        public string DeleteAuthority(tAuthority model)
        {
            _db.tAuthority.Remove(model);
            bool force = false;
            VerumInstance.SaveChanges(force);

            return "Delete Record Successful";
        }



     }
}
