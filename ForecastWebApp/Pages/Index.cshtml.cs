using Microsoft.AspNetCore.Mvc.RazorPages;
using VerumBusinessObjects;
using VerumDesk.Controller;



namespace ForecastWebApp.Pages
{
    public class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;

        public IndexModel(ILogger<IndexModel> logger)
        {
            _logger = logger;
        }

        public void OnGet()
        {
            
        }

        public void OnPost()
        {
            Forecast();
        }

        protected void Forecast()
        {
            VerumSession verumSession = new VerumSession();
            verumSession.Logon("ffriedrich@saperatec.de", "17Draconis$b", "Server=tcp:saperatec01.database.windows.net,1433;Initial Catalog=verum;Persist Security Info=False;User ID=azureadmin;Password=U327Shns; MultipleActiveResultSets = False; Encrypt = True; TrustServerCertificate = False; Connection Timeout = 30; ");
            Plan plan = new Plan();
            plan.SelectViaKey("Budget 2021");
            plan.ToForecast(null, null, true);

        }
    }
}