using System;
using System.ComponentModel.DataAnnotations.Schema;


namespace VerumBusinessObjects.Views
{
    public partial class vPlanElementContract
    {
        [NotMapped]
        public string Type_Select { get; set; }
    }

    public partial class vDepreciationRule
    {
        [NotMapped]
        public string TypeName { get; set; }
    }

    public partial class vPlanHRExpense
    {
        [NotMapped]
        public string Bonus_Mode_Title { get; set; }
    }

}
