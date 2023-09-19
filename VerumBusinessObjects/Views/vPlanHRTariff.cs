namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vPlanHRTariff")]
    public partial class vPlanHRTariff
    {
        [Key]
        [Column(Order = 0)]
        public Guid idPlan { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string Title { get; set; }

        [Key]
        [Column("Account Code", Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Account_Code { get; set; }

        [Key]
        [Column("Pay Day", Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Pay_Day { get; set; }

        [Column("Inflation Date", TypeName = "datetime2")]
        public DateTime? Inflation_Date { get; set; }

        [Key]
        [Column("Flag Shared", Order = 4)]
        public bool Flag_Shared { get; set; }

        public string Description { get; set; }

        [Key]
        [Column(Order = 5)]
        public Guid Id { get; set; }
    }
}
