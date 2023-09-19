namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vReferenceGroup")]
    public partial class vReferenceGroup
    {
        [Key]
        [Column(Order = 0)]
        public Guid idClient { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string Title { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(1)]
        public string Type { get; set; }

        [Column("Base Code")]
        [StringLength(2)]
        public string Base_Code { get; set; }

        [Key]
        [Column("Next Num", Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Next_Num { get; set; }

        [Key]
        [Column("Flag Auto", Order = 4)]
        public bool Flag_Auto { get; set; }

        [Key]
        [Column("Auto Digits", Order = 5)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Auto_Digits { get; set; }

        [Key]
        [Column(Order = 6)]
        public Guid Id { get; set; }
    }
}
