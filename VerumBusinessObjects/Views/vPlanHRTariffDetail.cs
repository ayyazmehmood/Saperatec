namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vPlanHRTariffDetail")]
    public partial class vPlanHRTariffDetail
    {
        [Key]
        [Column(Order = 0)]
        public Guid idPlan { get; set; }

        [Key]
        [Column("Tariff Title", Order = 1)]
        [StringLength(50)]
        public string Tariff_Title { get; set; }

        [Column("Valid To", TypeName = "datetime2")]
        public DateTime? Valid_To { get; set; }

        [Key]
        [Column("Work Hours per Week", Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Work_Hours_per_Week { get; set; }

        [Key]
        [Column("FTE Factor", Order = 3)]
        public double FTE_Factor { get; set; }

        [Key]
        [Column("Ratio Night Shift", Order = 4)]
        public double Ratio_Night_Shift { get; set; }

        [Key]
        [Column("Ratio Special Shift", Order = 5)]
        public double Ratio_Special_Shift { get; set; }

        [Key]
        [Column("Ratio Overtime", Order = 6)]
        public double Ratio_Overtime { get; set; }

        [Key]
        [Column("Annual Days Leave", Order = 7)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Annual_Days_Leave { get; set; }

        [Key]
        [Column("Annual Holidays", Order = 8)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Annual_Holidays { get; set; }

        [Key]
        [Column("Base Salary per Month", Order = 9)]
        public double Base_Salary_per_Month { get; set; }

        [Key]
        [Column("Rate Add Night Shift", Order = 10)]
        public double Rate_Add_Night_Shift { get; set; }

        [Key]
        [Column("Rate Add Special Shift", Order = 11)]
        public double Rate_Add_Special_Shift { get; set; }

        [Key]
        [Column("Rate Overtime", Order = 12)]
        public double Rate_Overtime { get; set; }

        [Column("Rate Annual Bonus")]
        public double? Rate_Annual_Bonus { get; set; }

        [Key]
        [Column("Bonus Month", Order = 13)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Bonus_Month { get; set; }

        [Key]
        [Column(Order = 14)]
        public Guid Id { get; set; }
    }
}
