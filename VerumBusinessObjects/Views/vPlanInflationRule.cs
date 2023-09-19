namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vPlanInflationRule")]
    public partial class vPlanInflationRule
    {
        [Key]
        [Column(Order = 0)]
        public Guid idPlan { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(30)]
        public string Title { get; set; }

        [Key]
        [Column("Interval in Months", Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Interval_in_Months { get; set; }

        [Key]
        [Column("Rate Annual", Order = 3)]
        public double Rate_Annual { get; set; }

        public string Description { get; set; }

        [Key]
        [Column(Order = 4)]
        public Guid Id { get; set; }
    }
}
