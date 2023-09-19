namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vPlan")]
    public partial class vPlan
    {
        [Key]
        [Column(Order = 0)]
        public Guid idClient { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(30)]
        public string Title { get; set; }

        [Key]
        [Column("Valid From", Order = 2, TypeName = "datetime2")]
        public DateTime Valid_From { get; set; }

        [Key]
        [Column("Valid To", Order = 3, TypeName = "datetime2")]
        public DateTime Valid_To { get; set; }

        [Key]
        [Column("Flag Baseline", Order = 4)]
        public bool Flag_Baseline { get; set; }

        [Key]
        [Column(Order = 5)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Status { get; set; }

        [Column("Title Base Plan")]
        [StringLength(30)]
        public string Title_Base_Plan { get; set; }

        [Key]
        [Column(Order = 6)]
        public Guid Id { get; set; }
    }
}
