namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vPlanParameterDate")]
    public partial class vPlanParameterDate
    {
        [Key]
        [Column(Order = 0)]
        public Guid idPlan { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(30)]
        public string Title { get; set; }

        [Column(TypeName = "datetime2")]
        public DateTime? Date { get; set; }

        public string Description { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid Id { get; set; }
    }
}
