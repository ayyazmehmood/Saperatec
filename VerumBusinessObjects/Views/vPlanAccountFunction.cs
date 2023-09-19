namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vPlanAccountFunction")]
    public partial class vPlanAccountFunction
    {
        [Key]
        [Column(Order = 0)]
        public Guid idClient { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Type { get; set; }

        [Key]
        [Column("Account Code", Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Account_Code { get; set; }

        [Key]
        [Column(Order = 3)]
        public Guid Id { get; set; }
    }
}
