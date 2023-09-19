namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vPlanElementHR")]
    public partial class vPlanElementHR
    {
        public Guid? idPlan { get; set; }

        [Column("Plan Group")]
        [StringLength(30)]
        public string Plan_Group { get; set; }

        [StringLength(50)]
        public string Title { get; set; }

        [Column("Staff Name")]
        [StringLength(50)]
        public string Staff_Name { get; set; }

        [StringLength(50)]
        public string Department { get; set; }

        [Column("Cost Center")]
        [StringLength(12)]
        public string Cost_Center { get; set; }

        [StringLength(15)]
        public string Reference { get; set; }

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

        [Column("Until Day")]
        public int? Until_Day { get; set; }

        [Column("Until Month")]
        public int? Until_Month { get; set; }

        [Column("Until Year")]
        public int? Until_Year { get; set; }

        [Key]
        [Column(Order = 0)]
        [StringLength(50)]
        public string Tariff { get; set; }

        [Key]
        [Column("Expense Group", Order = 1)]
        [StringLength(50)]
        public string Expense_Group { get; set; }

        [Column("Inflation Rule")]
        [StringLength(30)]
        public string Inflation_Rule { get; set; }

        [StringLength(3)]
        public string Currency { get; set; }

        public string Assumptions { get; set; }

        public string Revisions { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid Id { get; set; }
    }
}
