namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vVATRule")]
    public partial class vVATRule
    {
        [Key]
        [Column(Order = 0)]
        public Guid idClient { get; set; }

        [StringLength(5)]
        public string Code { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string Title { get; set; }

        [Column("Account VAT In")]
        public int? Account_VAT_In { get; set; }

        [Column("Account VAT Out")]
        public int? Account_VAT_Out { get; set; }

        [Column("Account VAT Settlement")]
        public int? Account_VAT_Settlement { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid Id { get; set; }

        [Key]
        [Column("Rate Current", Order = 3)]
        public double Rate_Current { get; set; }

        [Key]
        [Column("Settlement Term", Order = 4)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Settlement_Term { get; set; }

        [Column("Date Rate Change", TypeName = "datetime2")]
        public DateTime? Date_Rate_Change { get; set; }

        [Column("Rate Future")]
        public double? Rate_Future { get; set; }

        [Key]
        [Column("Flag Reverse Charge", Order = 5)]
        public bool Flag_Reverse_Charge { get; set; }
    }
}
