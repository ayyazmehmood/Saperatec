using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using VerumBusinessObjects.Framework;
using VerumBusinessObjects;
using VerumDesk.GUI;
using Microsoft.AspNetCore.Cors;
using VerumBusinessObjects.CommonModel;

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



        [HttpPost(Name = "PassEdit")]
        [EnableCors("AllowAll")]
        public BOResult PassEdit(string pass)
        {

            User user1 = new User();
            var res = user1.SetPassword(pass);
            return res;
        }
        

    }
}
