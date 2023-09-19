namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vCurrency")]
    public partial class vCurrency
    {
        [Key]
        [Column(Order = 0)]
        [StringLength(3)]
        public string Code { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(30)]
        public string Title { get; set; }

        [Key]
        [Column(Order = 2)]
        public Guid Id { get; set; }
    }
}
