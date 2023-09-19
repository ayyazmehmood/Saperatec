namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vAccountMainGroup")]
    public partial class vAccountMainGroup
    {
        [Key]
        [Column(Order = 0)]
        public Guid idClient { get; set; }

        [Key]
        [Column("Title Section", Order = 1)]
        [StringLength(255)]
        public string Title_Section { get; set; }

        [Key]
        [Column("Title Local", Order = 2)]
        [StringLength(255)]
        public string Title_Local { get; set; }

        [Column("Title English")]
        [StringLength(255)]
        public string Title_English { get; set; }

        [Key]
        [Column("Main Group Order", Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Main_Group_Order { get; set; }

        [Key]
        [Column(Order = 4)]
        public Guid Id { get; set; }
    }
}
