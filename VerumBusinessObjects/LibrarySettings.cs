using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VerumBusinessObjects
{
    public static class LibrarySettings
    {
        public static string ClientID { get; set; } 
        public static string Secret { get; set; }
        public static string TenantId { get; set; }
        public static string Dynamic365BCCompanyDataUrl { get; set; }
        public static string MicrosoftLoginUrlToken { get; set; }
        public static string ExportFilePath { get; set; }
    }
}
