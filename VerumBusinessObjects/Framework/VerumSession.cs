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
    using System.Security.Cryptography;

    public partial interface IVerumSession
    {
        /// <summary>
        /// User login with login name and password
        /// </summary>
        /// <param name="login">Valid login name</param>
        /// <param name="pwd">Valid password</param>
        /// <returns>Session id for user default client</returns>
        BOResult Logon(string login, string pwd, string connectionString);

        void ConnectSession(string IdSession);

        void TerminateSession();
    }

    public partial class VerumSession : IVerumSession
    {
        public string SessionKey { get => VerumInstance.IdSession.ToString(); }

        public bool SessionActive
        {
            get
            {
                if (VerumInstance.IdSession == null) return false;
                else if (VerumInstance.IdSession.ToString() == Guid.Empty.ToString()) return false;
                else return true;
            }
        }

        public void ConnectSession(string IdSession)
        {
            VerumInstance.ConnectSession(Guid.Parse(IdSession));
        }

        public void TerminateSession()
        {
            VerumInstance.CloseSession();
        }

        public BOResult Logon(string login, string pwd, string connectionString)
        {
            VerumDBContext db = new VerumDBContext(connectionString);
            tUser user;

            try
            {
                /* Fetch the stored value */
                var query = db.tUser.Where(b => b.UserLogin == login);
                if (query.Count() == 0) return BOResult.UserLoginInvalid;
                else user = query.FirstOrDefault();
                string savedPasswordHash = user.UserPasswordHash;

                /* Extract the bytes */
                byte[] hashBytes = Convert.FromBase64String(savedPasswordHash);

                /* Get the salt */
                byte[] salt = new byte[16];
                Array.Copy(hashBytes, 0, salt, 0, 16);

                /* Compute the hash on the password the user entered */
                var pbkdf2 = new Rfc2898DeriveBytes(pwd, salt, 10000);
                byte[] hash = pbkdf2.GetBytes(20);

                /* Compare the results */
                for (int i = 0; i < 20; i++)
                    if (hashBytes[i + 16] != hash[i])
                        return BOResult.UserLoginPasswordInvalid;

                VerumInstance.NewSession(user.Id, user.idClientDefault, connectionString);
                return BOResult.UserLogonSuccess;

            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex,"Technical error during user logon. Likely DB access failed.");
                return BOResult.UserLoginAccessFailed;
            }
        }

        public static void CompanySession(Guid userId, Guid IdClientDefault, string connectionString)
        {
            VerumInstance.NewSession(userId, IdClientDefault, connectionString);
        }
        public static void SetConnection(string connectionString)
        {
            VerumInstance.SetConnection(connectionString);
        }

    }
}
