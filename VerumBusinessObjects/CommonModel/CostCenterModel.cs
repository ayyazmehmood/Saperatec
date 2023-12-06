using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace VerumBusinessObjects.CommonModel
{
    public class CostCenterModel
    {
        public Guid Id { get; set; }
        public Guid IdMigrate { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateUpdated { get; set; }
        public Guid idClient { get; set; }
        public Client ClientParent { get; set; }
        public string CostCenterCode { get; set; }
        public string TitleCostCenter { get; set; }
        [ComVisible(false)]
        public string TitleEnglishCostCenter { get; set; }
        public bool FlagProfitCenter { get; set; }
        [ComVisible(false)]
        public string DescriptionCostCenter { get; set; }

    }
}
