namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vAccountSection")]
    public partial class vAccountSection
    {
        [Key]
        [Column(Order = 0)]
        public Guid idClient { get; set; }

        [Key]
        [Column("Title Local", Order = 1)]
        [StringLength(255)]
        public string Title_Local { get; set; }

        [Column("Title English")]
        [StringLength(255)]
        public string Title_English { get; set; }

        [Key]
        [Column("Type Account", Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Type_Account { get; set; }

        [Key]
        [Column("Section Order", Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Section_Order { get; set; }

        [Key]
        [Column(Order = 4)]
        public Guid Id { get; set; }
    }
}
