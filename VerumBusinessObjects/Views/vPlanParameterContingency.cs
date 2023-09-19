namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vPlanParameterContingency")]
    public partial class vPlanParameterContingency
    {
        [Key]
        [Column(Order = 0)]
        public Guid idPlan { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short TypePlanParameter { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(30)]
        public string Title { get; set; }

        [Key]
        [Column(Order = 3)]
        public double Rate { get; set; }

        public string Description { get; set; }

        [Key]
        [Column(Order = 4)]
        public Guid Id { get; set; }
    }
}
