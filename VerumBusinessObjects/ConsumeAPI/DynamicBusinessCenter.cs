using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices.WindowsRuntime;

namespace VerumBusinessObjects
{
    public class DynamicBusinessCenter
    {

        #region Testing Url
        // End point of Dynamic 365 Business Center
        //public static string GeneralLedgerPageEndPoint = @"https://api.businesscentral.dynamics.com/v2.0/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/ODataV4/Company('saperatec%20GmbH')/GeneralLedgerPage?$filter=Transaktionsnummer eq 11469";//11354"; //11125";
        //public static string GeneralLedgerPageEndPoint = @"https://api.businesscentral.dynamics.com/v2.0/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/ODataV4/Company('saperatec%20GmbH')/GeneralLedgerPage?$filter=Zuletzt_geändert gt 2023-02-21T13:34:35.3405340Z and Transaktionsnummer eq 4042";
        //public static string GeneralLedgerPageEndPoint = "https://api.businesscentral.dynamics.com/v2.0/7b529929-46de-4b14-8cec-8d0d154e2f0a/Saperatec_Stammdaten_Productiv/ODataV4/Company('saperatec%20GmbH')/GeneralLedgerPage";
        // variable
        // companyName should be in url Encode. ex : "saperatec%20GmbH" 
        //public static string CompanyName
        //public static string Environment = "Saperatec_Stammdaten_Productiv";
        #endregion

        /// <summary>
        /// get Bearer Access Token
        /// </summary>
        /// <returns></returns>
        public static async Task<string> getBearerAccessToken()
        {
            using (HttpClient httpClient = new HttpClient())
            {
                var content = new StringContent("grant_type=client_credentials&scope=https://api.businesscentral.dynamics.com/.default&client_id="
                + WebUtility.UrlEncode(ClientID) + "&client_secret=" + WebUtility.UrlEncode(Secret));
                content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/x-www-form-urlencoded");
                var response = await httpClient.PostAsync(MicrosoftLoginUrlToken, content);
                if (response.IsSuccessStatusCode)
                {
                    JObject result = JObject.Parse(await response.Content.ReadAsStringAsync());
                    return result["access_token"].ToString();
                }
                else
                {
                    Console.WriteLine("Error from getting access token: " + response.StatusCode.ToString());
                    return "";
                }
            }
        }

        /// <summary>
        /// get the data form Dynamic 365 Business Center basis on End point
        /// </summary>
        /// <param name="requestApiUrl">Url of Dynamic 365 Business Center</param>
        /// <returns></returns>
        public static async Task<T> sendRequest<T>(string requestApiUrl)
        {
            try
            {
                string bearerToken = await getBearerAccessToken();
                if (bearerToken == "")
                {
                    // Create an instance of T using reflection
                    return (T)Activator.CreateInstance(typeof(T));
                }

                using (HttpClient requestHttpClient = new HttpClient())
                {
                    requestHttpClient.DefaultRequestHeaders.Add("Authorization", "Bearer " + bearerToken);
                    var requestResponse = await requestHttpClient.GetAsync(requestApiUrl);
                    if (requestResponse.IsSuccessStatusCode)
                    {
                        return JsonConvert.DeserializeObject<T>(await requestResponse.Content.ReadAsStringAsync());
                    }
                    else
                    {
                        // Create an instance of T using reflection
                        return (T)Activator.CreateInstance(typeof(T));
                    }
                }
            }
            catch (Exception ex)
            {
                return (T)Activator.CreateInstance(typeof(T));
            }
        }

        public static string ClientID
        {
            get
            {
                return VerumBusinessObjects.LibrarySettings.ClientID;
                //return VerumBusinessObjects.Properties.Settings.Default.AzureClientId;
            }
        }
        public static string Secret
        {
            get
            {
                return VerumBusinessObjects.LibrarySettings.Secret;
                //return VerumBusinessObjects.Properties.Settings.Default.AzureSecret;
            }
        }
        public static string TenantId
        {
            get
            {
                return VerumBusinessObjects.LibrarySettings.TenantId;
                //return VerumBusinessObjects.Properties.Settings.Default.AzureTenantId;
            }
        }
        public static string MicrosoftLoginUrlToken
        {
            get
            {
                return VerumBusinessObjects.LibrarySettings.MicrosoftLoginUrlToken.Replace("{TenantId}", TenantId);
                //return VerumBusinessObjects.Properties.Settings.Default.MicrosoftLoginUrlToken.Replace("{TenantId}", TenantId);
            }
        }

        #region old Code
        //public static string GeneralLedgerPageEndPoint
        //{
        //    get
        //    {
        //        return VerumBusinessObjects.LibrarySettings.Dynamic365BCCompanyDataUrl
        //            .Replace("{TenantId}", TenantId)
        //            .Replace("{Environment}", Environment)
        //            .Replace("{CompanyName}", CompanyName)
        //            .Replace("{EndPoint}", "GeneralLedgerPage");
        //    }
        //}

        //public static string Dynamic365BCBaseUrl
        //{
        //    get
        //    {
        //        return VerumBusinessObjects.LibrarySettings.Dynamic365BCCompanyDataUrl;
        //        //return VerumBusinessObjects.Properties.Settings.Default.Dynamic365BCCompanyDataUrl;
        //    }
        //}
        #endregion

    }
}
