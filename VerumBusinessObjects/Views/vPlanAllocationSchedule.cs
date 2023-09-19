namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vPlanAllocationSchedule")]
    public partial class vPlanAllocationSchedule
    {
        [Key]
        [Column(Order = 0)]
        public Guid idPlan { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(30)]
        public string Title { get; set; }

        [Key]
        [Column("Perpetual Rate", Order = 2)]
        public double Perpetual_Rate { get; set; }

        [Key]
        [Column("Flag Shared", Order = 3)]
        public bool Flag_Shared { get; set; }

        [Key]
        [Column("Flag Absolute Rates", Order = 4)]
        public bool Flag_Absolute_Rates { get; set; }

        [Key]
        [Column("Advance Delay", Order = 5)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Advance_Delay { get; set; }

        [Key]
        [Column("Months per Period", Order = 6)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Months_per_Period { get; set; }

        [Key]
        [Column("Auto Generate", Order = 7)]
        public bool Auto_Generate { get; set; }

        [Column("Period 1")]
        public short? Period_1 { get; set; }

        [Column("Rate 1")]
        public double? Rate_1 { get; set; }

        [Column("Period 2")]
        public short? Period_2 { get; set; }

        [Column("Rate 2")]
        public double? Rate_2 { get; set; }

        [Column("Period 3")]
        public short? Period_3 { get; set; }

        [Column("Rate 3")]
        public double? Rate_3 { get; set; }

        [Key]
        [Column(Order = 8)]
        public Guid Id { get; set; }
    }
}
