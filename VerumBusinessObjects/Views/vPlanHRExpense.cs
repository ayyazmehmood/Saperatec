namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vPlanHRExpense")]
    public partial class vPlanHRExpense
    {
        [Key]
        [Column(Order = 0)]
        public Guid idPlan { get; set; }

        [Key]
        [Column("Group Title", Order = 1)]
        [StringLength(50)]
        public string Group_Title { get; set; }

        [Key]
        [Column("Expense Title", Order = 2)]
        [StringLength(50)]
        public string Expense_Title { get; set; }

        [Column("Valid To", TypeName = "datetime2")]
        public DateTime? Valid_To { get; set; }

        [Key]
        [Column("Account Code", Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Account_Code { get; set; }

        [Column("Fixed Cost Center Code")]
        [StringLength(12)]
        public string Fixed_Cost_Center_Code { get; set; }

        [Key]
        [Column("Ratio to Salary", Order = 4)]
        public double Ratio_to_Salary { get; set; }

        [Key]
        [Column("Expense Amount", Order = 5)]
        public double Expense_Amount { get; set; }

        [Key]
        [Column("Salary Cap", Order = 6)]
        public double Salary_Cap { get; set; }

        [Key]
        [Column("Deduct from Salary", Order = 7)]
        public double Deduct_from_Salary { get; set; }

        [Key]
        [Column("Bonus Mode", Order = 8)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Bonus_Mode { get; set; }

        public string Assumptions { get; set; }

        [Key]
        [Column(Order = 9)]
        public Guid Id { get; set; }
    }
}
