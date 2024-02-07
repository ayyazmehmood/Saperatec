namespace VerumBusinessObjects
{
    using System;
    using System.Collections.Generic;
    using System.Data.Entity;
    using System.Linq;
    using VerumBusinessObjects.CommonModel;
    using VerumBusinessObjects.Framework;

        public partial class Authority : BusinessObject<tAuthority>, IAuthority
    { 

        public static BOCollection<Authority, tAuthority> GetBOCollection()
        {
            // select all cost centers for the current client
             var query = VerumInstance.Context.tAuthority.Where<tAuthority>(b => b.idClient == VerumInstance.IdClient).OrderByDescending(b => b.CostCenter);
            return new BOCollection<Authority, tAuthority>(query);
        }
        public static List<AuthorityModel> GetAuthorityDetails()
        {
            
           List<AuthorityModel> authorityModel = new List< AuthorityModel>();
            var query = from authority in VerumInstance.Context.tAuthority
                        join user in VerumInstance.Context.tUser
                        on authority.idUser equals user.Id
                        where authority.idClient == VerumInstance.IdClient
                        orderby authority.CostCenter descending
                        select new
                        {
                            Authority = authority,
                            User = user
                        };

            AuthorityModel authorityObj=new AuthorityModel();
            foreach ( var item in query)
            {
                authorityObj = new AuthorityModel();
                authorityObj.UserName=item.User.UserName;
                authorityObj.ApprovalLimit=item.Authority.ApprovalLimit;
                authorityObj.UserRole=item.Authority.UserRole;
                authorityObj.CostCenter = item.Authority.CostCenter;
                authorityObj.RefCode=item.Authority.RefCode;
                authorityObj.Id = item.Authority.Id;
                authorityObj.IdMigrate=item.Authority.IdMigrate;
                authorityObj.DateCreated=item.Authority.DateCreated;
                authorityObj.DateUpdated = item.Authority.DateUpdated;
                authorityObj.UserRole= item.Authority.UserRole;
                authorityObj.idClient = item.Authority.idClient;
                authorityObj.idUser=item.Authority.idUser;

                authorityModel.Add(authorityObj);
            }
          
            return authorityModel;
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
