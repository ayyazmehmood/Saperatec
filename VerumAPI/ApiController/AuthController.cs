using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using VerumBusinessObjects.Framework;
using VerumBusinessObjects;
using VerumDesk.GUI;
using Microsoft.AspNetCore.Cors;
using VerumBusinessObjects.CommonModel;
using System.Security.Cryptography;
using System.Text;

namespace VerumAPI.ApiController
{
    [Route("[controller]/[action]")]
    [EnableCors("AllowAll")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly string _connectionString = ""; 
        public AuthController(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("DBConnectionDevelop");
        }

        [HttpPost(Name = "LoginAdmin")]
        [EnableCors("AllowAll")]
        public BOResult LoginAdmin(LoginModel model)
        {
            VerumSession.SetConnection(_connectionString);
            VerumSession verumSession = new VerumSession();

            var res = verumSession.Logon(model.email, model.password, _connectionString);

            return res;
        }

        [HttpPost(Name ="GetUser")]
        [EnableCors("AllowAll")]
        public tUser GetUser(LoginModel model)
        {
            VerumDBContext db = new VerumDBContext(_connectionString);
            tUser user;
            var query = db.tUser.Where(b => b.UserLogin == model.email);
            user = query.FirstOrDefault();
            return user;


        }



        [HttpPut(Name = "UpdateProfile")]
        [EnableCors("AllowAll")]
        public string PassEdit(UpdateProfileModel model)
        {
            VerumDBContext db = new VerumDBContext(_connectionString);
            tUser user;
            User user1 = new User();
      
            /* Fetch the stored value */
            var query = db.tUser.Where(b => b.UserLogin == model.UserLogin);
            if (query.Count() == 0) return "Invalid User";
            else user = query.FirstOrDefault();
            string savedPasswordHash = user.UserPasswordHash;

            /* Extract the bytes */
            byte[] hashBytes = Convert.FromBase64String(savedPasswordHash);

            /* Get the salt */
            byte[] salt = new byte[16];
            Array.Copy(hashBytes, 0, salt, 0, 16);

            /* Compute the hash on the password the user entered */
            var pbkdf2 = new Rfc2898DeriveBytes(model.CurrentPassword, salt, 10000);
            byte[] hash = pbkdf2.GetBytes(20);

            /* Compare the results */
            for (int i = 0; i < 20; i++)
                if (hashBytes[i + 16] != hash[i])
                    return "Invalid Current Password";

            user.UserName=model.UserName;
            return user1.UpdateProfile(user, model);

        }
    }
}
