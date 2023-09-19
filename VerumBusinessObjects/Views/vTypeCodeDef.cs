namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vTypeCodeDef")]
    public partial class vTypeCodeDef
    {
        [Key]
        [Column("Group ID", Order = 0)]
        [StringLength(25)]
        public string Group_ID { get; set; }

        [Key]
        [Column("Type ID", Order = 1)]
        [StringLength(25)]
        public string Type_ID { get; set; }

        [Key]
        [Column("Type Code", Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Type_Code { get; set; }

        [Key]
        [Column(Order = 3)]
        public Guid Id { get; set; }
    }
}
