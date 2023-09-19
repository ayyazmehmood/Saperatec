namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vJobReport")]
    public partial class vJobReport
    {
        [Key]
        [Column("User Name", Order = 0)]
        [StringLength(255)]
        public string User_Name { get; set; }

        [Key]
        [Column("Client Name", Order = 1)]
        [StringLength(30)]
        public string Client_Name { get; set; }

        [Key]
        [Column("Job Start Time", Order = 2, TypeName = "datetime2")]
        public DateTime Job_Start_Time { get; set; }

        [Column("Job End Time", TypeName = "datetime2")]
        public DateTime? Job_End_Time { get; set; }

        [Key]
        [Column("Type of Job", Order = 3)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Type_of_Job { get; set; }

        [Key]
        [Column("Job Success", Order = 4)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Job_Success { get; set; }

        [Key]
        [Column("Item Timestamp", Order = 5, TypeName = "datetime2")]
        public DateTime Item_Timestamp { get; set; }

        [Key]
        [Column("Item Success", Order = 6)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public short Item_Success { get; set; }

        [Key]
        [Column("Item Result", Order = 7)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Item_Result { get; set; }

        [StringLength(255)]
        public string Object { get; set; }

        [StringLength(255)]
        public string Context { get; set; }

        [StringLength(255)]
        public string Message { get; set; }

        [Key]
        [Column(Order = 8)]
        public Guid idClient { get; set; }

        public Guid? idUser { get; set; }

        [Key]
        [Column(Order = 9)]
        public Guid idJobReport { get; set; }
    }
}
