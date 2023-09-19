namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class vPlanAllocationScheduleItems
    {
        [Key]
        [Column(Order = 0)]
        public Guid idPlan { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(30)]
        public string TitleAllocationSchedule { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int OrderNum { get; set; }

        [Key]
        [Column(Order = 3)]
        public double ItemRate { get; set; }

        [Key]
        [Column(Order = 4)]
        public Guid Id { get; set; }
    }
}
