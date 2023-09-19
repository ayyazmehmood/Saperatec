namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vReferenceCode")]
    public partial class vReferenceCode
    {
        [Key]
        [Column(Order = 0)]
        public Guid idClient { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string Group { get; set; }

        [Key]
        [Column(Order = 2)]
        [StringLength(12)]
        public string Code { get; set; }

        [StringLength(50)]
        public string Title { get; set; }

        public string Description { get; set; }

        public bool FlagActive { get; set; }

        [Key]
        [Column(Order = 3)]
        public Guid Id { get; set; }
    }
}
