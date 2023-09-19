namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vPlanGroup")]
    public partial class vPlanGroup
    {
        [Key]
        [Column(Order = 0)]
        public Guid idClient { get; set; }

        [Key]
        [Column("Title Local", Order = 1)]
        [StringLength(30)]
        public string Title_Local { get; set; }

        [Column("Title English")]
        [StringLength(30)]
        public string Title_English { get; set; }

        public string Description { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid Id { get; set; }
    }
}
