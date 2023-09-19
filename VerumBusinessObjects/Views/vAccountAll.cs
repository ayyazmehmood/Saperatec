namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vAccountAll")]
    public partial class vAccountAll
    {
        [Key]
        [Column(Order = 0)]
        public Guid idClient { get; set; }

        [StringLength(50)]
        public string Group { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Code { get; set; }

        [Key]
        [Column("Title local", Order = 2)]
        [StringLength(50)]
        public string Title_local { get; set; }

        [Column("Title english")]
        [StringLength(50)]
        public string Title_english { get; set; }

        [Key]
        [Column(Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Type { get; set; }

        [Column("Report Account")]
        public int? Report_Account { get; set; }

        [Key]
        [Column(Order = 4)]
        public bool Planning { get; set; }

        [Key]
        [Column(Order = 5)]
        public Guid Id { get; set; }
    }
}
