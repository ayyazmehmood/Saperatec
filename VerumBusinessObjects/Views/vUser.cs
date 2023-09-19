namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vUser")]
    public partial class vUser
    {
        [Key]
        [Column("User Name", Order = 0)]
        [StringLength(255)]
        public string User_Name { get; set; }

        [Key]
        [Column("User Login", Order = 1)]
        [StringLength(30)]
        public string User_Login { get; set; }

        [Key]
        [Column("User Password Hash", Order = 2)]
        [StringLength(48)]
        public string User_Password_Hash { get; set; }

        [Key]
        [Column("Client Title", Order = 3)]
        [StringLength(30)]
        public string Client_Title { get; set; }

        [Key]
        [Column("User Type", Order = 4)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short User_Type { get; set; }

        [StringLength(255)]
        public string DATEVImportFolder { get; set; }

        [StringLength(255)]
        public string DataImportFolder { get; set; }

        [Key]
        [Column(Order = 5)]
        public Guid idClientDefault { get; set; }

        [Key]
        [Column(Order = 6)]
        public Guid Id { get; set; }
    }
}
