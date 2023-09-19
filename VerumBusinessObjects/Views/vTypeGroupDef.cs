namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vTypeGroupDef")]
    public partial class vTypeGroupDef
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(25)]
        public string TypeGroupID { get; set; }

        [Key]
        [Column(Order = 1)]
        public Guid Id { get; set; }
    }
}
