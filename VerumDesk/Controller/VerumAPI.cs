using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Security;
using System.Text;
using System.Threading.Tasks;

namespace VerumDesk.Controller
{
    public class VerumAPI
    {
        private static readonly HttpClient _httpClient = new HttpClient();

        public static async Task<string> CallApiAsync(string url)
        {
            try
            {
                var client = new HttpClient();
                var request = new HttpRequestMessage(HttpMethod.Post, url);
                var response = await client.SendAsync(request);
                response.EnsureSuccessStatusCode();

                string responseBody = await response.Content.ReadAsStringAsync();
                return responseBody;
            }
            catch (HttpRequestException ex)
            {
                // Handle any exceptions or error conditions here
                Console.WriteLine($"Error: {ex.Message}");
                return null;
            }
        }
    }
}
