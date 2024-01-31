using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VerumBusinessObjects.CommonModel
{
    public class UpdateProfileModel
    {
        public string UserName { get; set; }
        public string UserLogin { get; set; }
        public string CurrentPassword { get; set; }
        public string NewPassword { get; set; }
    }
}
