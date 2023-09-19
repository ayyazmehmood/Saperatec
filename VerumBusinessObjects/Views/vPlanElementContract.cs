namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vPlanElementContract")]
    public partial class vPlanElementContract
    {
        public Guid? idPlan { get; set; }

        [Column("Plan Group")]
        [StringLength(30)]
        public string Plan_Group { get; set; }

        [StringLength(50)]
        public string Title { get; set; }

        public short? Type { get; set; }

        [Column("Cost Center")]
        [StringLength(12)]
        public string Cost_Center { get; set; }

        [StringLength(15)]
        public string Reference { get; set; }

        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Account { get; set; }

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

        [StringLength(30)]
        public string Schedule { get; set; }

        [Column("VAT Rule")]
        [StringLength(5)]
        public string VAT_Rule { get; set; }

        [Key]
        [Column("Payment Term", Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Payment_Term { get; set; }

        [Key]
        [Column("Advance Delay", Order = 4)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Advance_Delay { get; set; }

        [Column("Advance Account")]
        public int? Advance_Account { get; set; }

        [Column("Advance Trigger")]
        [StringLength(30)]
        public string Advance_Trigger { get; set; }

        [Column("Depreciation Rule")]
        [StringLength(50)]
        public string Depreciation_Rule { get; set; }

        [Column("Depreciation Start Day")]
        public int? Depreciation_Start_Day { get; set; }

        [Column("Depreciation Start Month")]
        public int? Depreciation_Start_Month { get; set; }

        [Column("Depreciation Start Year")]
        public int? Depreciation_Start_Year { get; set; }

        [Key]
        [Column("Depreciation Delay", Order = 5)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Depreciation_Delay { get; set; }

        [Column("Depreciation Trigger")]
        [StringLength(30)]
        public string Depreciation_Trigger { get; set; }

        [Key]
        [Column(Order = 6)]
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
        [Column("Inflation Rule", Order = 7)]
        [StringLength(30)]
        public string Inflation_Rule { get; set; }

        [Column("Price Date", TypeName = "datetime2")]
        public DateTime? Price_Date { get; set; }

        public string Assumptions { get; set; }

        public string Revisions { get; set; }

        [Key]
        [Column(Order = 8)]
        public Guid Id { get; set; }
    }
}
