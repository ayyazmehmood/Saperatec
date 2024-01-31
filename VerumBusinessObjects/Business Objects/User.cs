namespace VerumBusinessObjects
{
    using System;
    using System.Data.Entity;
    using System.Linq;
    using VerumBusinessObjects.Framework;
    using System.ComponentModel.DataAnnotations;
    using System.Security.Cryptography;
    using DocumentFormat.OpenXml.EMMA;
    using VerumBusinessObjects.CommonModel;

    /// <summary>
    /// Specifies currencies and enables the conversion of foreign currency into the client base currency
    /// </summary>    
    public partial class User : BusinessObject<tUser>, IUser
    {
        public bool SelectViaKey(string login)
        {
            var attr = (StringLengthAttribute)typeof(tUser).GetProperty("UserLogin").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (login.Length > len)
                    login = login.Substring(0, attr.MaximumLength);
            }

            var obj = VerumInstance.Context.tUser.Where(b => b.UserLogin == login);

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

        public static BOCollection<User, tUser> GetUsers()
        {
            // select all users
            var query = VerumInstance.Context.tUser;
            return new BOCollection<User, tUser>(query);
        }

        public new BusinessObject<tUser> New()
        {
            // Check that admin session is logged on
            if (VerumInstance.TypeCurrentUser != TypeUserEnum.Admin) return null;

            return New(Guid.NewGuid());
        }

        public BOResult SetPassword(string pwd)
        {
            try

            {
                // Check that admin session is logged on
                // if (VerumInstance.TypeCurrentUser != TypeUserEnum.Admin) return BOResult.UserNotAuthorized;

                // ensure that credentials are not empty
                if (UserName == "" || UserLogin.Length < 6 || pwd.Length < 8) return BOResult.UserCreateFailed;

                // ensure that client exists
                var query = VerumInstance.Context.tClient.Where(b => b.Id == idClientDefault);
                if (query.Count() == 0) throw new Exception(Properties.Errors.ClientInvalidClientID);

                // Check user type
                if (TypeUser != (short)TypeUserEnum.Admin && TypeUser != (short)TypeUserEnum.Standard)
                    throw new Exception(Properties.Errors.UserInvalidUserType);

                // Create the salt value with a cryptographic PRNG
                byte[] salt;
                new RNGCryptoServiceProvider().GetBytes(salt = new byte[16]);

                // Create the Rfc2898DeriveBytes and get the hash value
                var pbkdf2 = new Rfc2898DeriveBytes(pwd, salt, 10000);
                byte[] hash = pbkdf2.GetBytes(20);

                // Combine the salt and password bytes for later use
                byte[] hashBytes = new byte[36];
                Array.Copy(salt, 0, hashBytes, 0, 16);
                Array.Copy(hash, 0, hashBytes, 16, 20);

                // Turn the combined salt+hash into a string for storage
                string savedPasswordHash = Convert.ToBase64String(hashBytes);

                UserPasswordHash = savedPasswordHash;
                CommitChanges();
                return BOResult.Success;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                return BOResult.GeneralError;
            }
        }

        public BOResult Delete()
        {
            try
            {
                VerumInstance.TransactionStart();
                VerumInstance.Context.tUser.Remove(data);
                VerumInstance.TransactionEnd();
                return BOResult.Success;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                return BOResult.GeneralError;
            }
        }

        public string UpdateProfile(tUser user , UpdateProfileModel model)
        {

                try
                {
                
                // Check that admin session is logged on
                // if (VerumInstance.TypeCurrentUser != TypeUserEnum.Admin) return BOResult.UserNotAuthorized;

                // ensure that credentials are not empty
                if (user.UserName == "" || user.UserName.Length < 6 || model.NewPassword.Length < 8) return "UserCreateFailed";

                    // ensure that client exists
                    var query = VerumInstance.Context.tClient.Where(b => b.Id == user.idClientDefault);
                    if (query.Count() == 0) throw new Exception(Properties.Errors.ClientInvalidClientID);


                    // Create the salt value with a cryptographic PRNG
                    byte[] salt;
                    new RNGCryptoServiceProvider().GetBytes(salt = new byte[16]);

                    // Create the Rfc2898DeriveBytes and get the hash value
                    var pbkdf2 = new Rfc2898DeriveBytes(model.NewPassword, salt, 10000);
                    byte[] hash = pbkdf2.GetBytes(20);

                    // Combine the salt and password bytes for later use
                    byte[] hashBytes = new byte[36];
                    Array.Copy(salt, 0, hashBytes, 0, 16);
                    Array.Copy(hash, 0, hashBytes, 16, 20);

                    // Turn the combined salt+hash into a string for storage
                    string savedPasswordHash = Convert.ToBase64String(hashBytes);

                    user.UserPasswordHash = savedPasswordHash;
                    _db.Entry(user).State = System.Data.Entity.EntityState.Modified;
                    bool force = false;
                    VerumInstance.SaveChanges(force);
                    return "Profile update Successful";
                }

                catch (Exception ex)
                {
                    BOUtilities.TraceErrors(ex, System.Reflection.MethodBase.GetCurrentMethod().Name);
                    return "Profile update Failed";
                }
            


         
        }
    }
}
