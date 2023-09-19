namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vDepreciationRule")]
    public partial class vDepreciationRule
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
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Type { get; set; }

        [Key]
        [Column("Account Activation", Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Account_Activation { get; set; }

        [Key]
        [Column("Account Depreciation", Order = 4)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Account_Depreciation { get; set; }

        [Key]
        [Column(Order = 5)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Periods { get; set; }

        [Key]
        [Column("Months per Period", Order = 6)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Months_per_Period { get; set; }

        [Key]
        [Column(Order = 7)]
        public Guid Id { get; set; }
    }
}
