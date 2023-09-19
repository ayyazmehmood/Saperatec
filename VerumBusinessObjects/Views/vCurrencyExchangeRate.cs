namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("vCurrencyExchangeRate")]
    public partial class vCurrencyExchangeRate
    {
        [Key]
        [Column(Order = 0)]
        public Guid idClient { get; set; }

        [Key]
        [Column("Currency Code", Order = 1)]
        [StringLength(3)]
        public string Currency_Code { get; set; }

        [Key]
        [Column(Order = 2, TypeName = "datetime2")]
        public DateTime Date { get; set; }

        [Key]
        [Column(Order = 3)]
        public double Rate { get; set; }

        [Column("Plan Title", Order = 4)]
        [StringLength(30)]
        public string Plan_Title { get; set; }

        [Column("Currency Title", Order = 5)]
        [StringLength(30)]
        public string Currency_Title { get; set; }

        [Key]
        [Column(Order = 6)]
        public Guid Id { get; set; }

        [Key]
        [Column(Order = 7)]
        public Guid idPlan { get; set; }
    }
}
