namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vCostCenter")]
    public partial class vCostCenter
    {
        [Key]
        [Column(Order = 0)]
        public Guid idClient { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(12)]
        public string Code { get; set; }

        [Key]
        [Column("Title Local", Order = 2)]
        [StringLength(50)]
        public string Title_Local { get; set; }

        [Column("Title English")]
        [StringLength(50)]
        public string Title_English { get; set; }

        [Key]
        [Column("Flag Profit Center", Order = 3)]
        public bool Flag_Profit_Center { get; set; }

        public string Description { get; set; }

        [Key]
        [Column(Order = 4)]
        public Guid Id { get; set; }
    }
}
