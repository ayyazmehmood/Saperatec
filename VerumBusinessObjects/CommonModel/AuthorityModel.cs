using DocumentFormat.OpenXml.Office2010.ExcelAc;
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
        public string UserName { get; set; }
        public Guid Id { get; set; }
        public Guid idUser { get; set; }

        public Guid? IdMigrate { get; set; }

        public DateTime DateCreated { get; set; }

        public DateTime? DateUpdated { get; set; }

        public Guid idClient { get; set; }




    }

}
