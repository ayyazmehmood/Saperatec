namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vPlanParameterPriceFactor")]
    public partial class vPlanParameterPriceFactor
    {
        [Key]
        [Column(Order = 0)]
        public Guid idPlan { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(30)]
        public string Title { get; set; }

        [Key]
        [Column(Order = 2)]
        public double Value { get; set; }

        public string Description { get; set; }

        [Key]
        [Column(Order = 3)]
        public Guid Id { get; set; }
    }
}
