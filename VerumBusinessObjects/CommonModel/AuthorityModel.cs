using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace VerumBusinessObjects.CommonModel
{
    public class AuthorityModel
    {

        [StringLength(7)]
        public string CostCenter { get; set; }

        [StringLength(12)]
        public string RefCode { get; set; }

        public int? ApprovalLimit { get; set; }
        public short? UserRole { get; set; }

    }
}
