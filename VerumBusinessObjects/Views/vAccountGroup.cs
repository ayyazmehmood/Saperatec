namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vAccountGroup")]
    public partial class vAccountGroup
    {
        [Key]
        [Column(Order = 0)]
        public Guid idClient { get; set; }

        [Key]
        [Column("Title Main Group", Order = 1)]
        [StringLength(255)]
        public string Title_Main_Group { get; set; }

        [Key]
        [Column("Title Local", Order = 2)]
        [StringLength(255)]
        public string Title_Local { get; set; }

        [Column("Title English")]
        [StringLength(255)]
        public string Title_English { get; set; }

        [Key]
        [Column("Account Group Order", Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Account_Group_Order { get; set; }

        [Key]
        [Column("Code From", Order = 4)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Code_From { get; set; }

        [Key]
        [Column("Code To", Order = 5)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Code_To { get; set; }

        [Column("Default Reporting Account")]
        public int? Default_Reporting_Account { get; set; }

        [Key]
        [Column("Default Type", Order = 6)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Default_Type { get; set; }

        [Key]
        [Column(Order = 7)]
        public Guid Id { get; set; }
    }
}
