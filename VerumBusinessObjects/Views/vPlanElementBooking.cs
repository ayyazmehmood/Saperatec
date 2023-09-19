namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vPlanElementBooking")]
    public partial class vPlanElementBooking
    {
        public Guid? idPlan { get; set; }

        [Column("Plan Group")]
        [StringLength(30)]
        public string Plan_Group { get; set; }

        [StringLength(50)]
        public string Title { get; set; }

        [Column("Cost Center")]
        [StringLength(12)]
        public string Cost_Center { get; set; }

        [StringLength(15)]
        public string Reference { get; set; }

        [Key]
        [Column("Debit Account", Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Debit_Account { get; set; }

        [Column("Credit Account")]
        public int? Credit_Account { get; set; }

        [Key]
        [Column(Order = 1)]
        public double Price { get; set; }

        [StringLength(3)]
        public string Currency { get; set; }

        [Column("Due Day")]
        public int? Due_Day { get; set; }

        [Column("Due Month")]
        public int? Due_Month { get; set; }

        [Column("Due Year")]
        public int? Due_Year { get; set; }

        public string Description { get; set; }

        [Column("Due Offset")]
        public bool? Due_Offset { get; set; }

        [Column("Due Trigger")]
        [StringLength(30)]
        public string Due_Trigger { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Repeat { get; set; }

        [Column("Until Day")]
        public int? Until_Day { get; set; }

        [Column("Until Month")]
        public int? Until_Month { get; set; }

        [Column("Until Year")]
        public int? Until_Year { get; set; }

        [StringLength(255)]
        public string Schedule { get; set; }

        [Key]
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Units { get; set; }

        [Column("Price Par 1")]
        [StringLength(30)]
        public string Price_Par_1 { get; set; }

        [Column("Price Par 2")]
        [StringLength(30)]
        public string Price_Par_2 { get; set; }

        [Column("Contingency Rule")]
        [StringLength(30)]
        public string Contingency_Rule { get; set; }

        [Key]
        [Column("Inflation Rule", Order = 4)]
        [StringLength(30)]
        public string Inflation_Rule { get; set; }

        [Column("Price Date", TypeName = "datetime2")]
        public DateTime? Price_Date { get; set; }

        [Key]
        [Column("Flag Account Opening", Order = 5)]
        public bool Flag_Account_Opening { get; set; }

        public string Assumptions { get; set; }

        public string Revisions { get; set; }

        [Key]
        [Column(Order = 6)]
        public Guid Id { get; set; }
    }
}
