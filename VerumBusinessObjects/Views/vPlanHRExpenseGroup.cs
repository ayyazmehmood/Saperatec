namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vPlanHRExpenseGroup")]
    public partial class vPlanHRExpenseGroup
    {
        [Key]
        [Column(Order = 0)]
        public Guid idPlan { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string Title { get; set; }

        public string Description { get; set; }

        [Column("Inflation Date", TypeName = "datetime2")]
        public DateTime? Inflation_Date { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid Id { get; set; }
    }
}
