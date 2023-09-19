namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vClient")]
    public partial class vClient
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(30)]
        public string Title { get; set; }

        [Key]
        [Column("Currency Code", Order = 1)]
        [StringLength(3)]
        public string Currency_Code { get; set; }

        [Key]
        [Column("Flag Template", Order = 2)]
        public bool Flag_Template { get; set; }

        [Key]
        [Column("Start of Business Year", Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Start_of_Business_Year { get; set; }

        public int? DATEVClientNumber { get; set; }

        [Key]
        [Column(Order = 4)]
        public Guid Id { get; set; }
    }
}
