namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class vPlanElementInstances
    {
        [Key]
        [Column(Order = 0)]
        public Guid Id { get; set; }

        [Column(TypeName = "datetime2")]
        public DateTime? DateUpdated { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid idClient { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid idPlan { get; set; }

        [Key]
        [Column(Order = 3)]
        public Guid idPlanElement { get; set; }

        public Guid? idCostCenterPlanElement { get; set; }

        public Guid? idCurrency { get; set; }

        [Key]
        [Column(Order = 4)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short TypePlanElement { get; set; }

        public Guid? idPlanGroup { get; set; }

        [Key]
        [Column(Order = 5)]
        [StringLength(50)]
        public string TitlePlanElement { get; set; }

        [StringLength(15)]
        public string ReferenceIDPlanElement { get; set; }

        [Key]
        [Column(Order = 6)]
        public bool ElementFlagBaseline { get; set; }

        public string PlanElementDescription { get; set; }

        [Key]
        [Column(Order = 7)]
        public bool FlagUpdate { get; set; }

        [Key]
        [Column(Order = 8)]
        public bool FlagBaseline { get; set; }

        [Key]
        [Column(Order = 9)]
        public bool FlagDateOffset { get; set; }

        [Key]
        [Column(Order = 10)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int DueDateYear { get; set; }

        [Key]
        [Column(Order = 11)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int DueDateMonth { get; set; }

        [Key]
        [Column(Order = 12)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int DueDateDay { get; set; }

        public int? UntilDateYear { get; set; }

        public int? UntilDateMonth { get; set; }

        public int? UntilDateDay { get; set; }

        public Guid? idParTriggerDueDate { get; set; }

        public string Assumptions { get; set; }

        public string Revisions { get; set; }

        [StringLength(12)]
        public string CostCenterCode { get; set; }

        [StringLength(30)]
        public string TitlePlanGroup { get; set; }


    }
}
