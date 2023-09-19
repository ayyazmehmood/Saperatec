namespace VerumBusinessObjects.Views
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public class oDATEVJournal
    {
        public int Nr { get; set; }

        [StringLength(3)]
        public string WKZ { get; set; }

        public double Umsatz { get; set; }

        public char S_H { get; set; }

        public char GU { get; set; }

        public short BU { get; set; }

        public int Gegenkonto { get; set; }

        public string Belegfeld_1 { get; set; }

        public string Belegfeld_2 { get; set; }

        public string KOST1 { get; set; }

        public string KOST2 { get; set; }

        public DateTime Datum { get; set; }

        public DateTime Leistungsdatum { get; set; }

        public int Konto { get; set; }

        public double Skonto { get; set; }

        public string Buchungstext { get; set; }

        public string EU_Informationen { get; set; }

        public double Umsatz_BW { get; set; }

        public double Kurs { get; set; }

        public string ZI { get; set; }

        public string HK { get; set; }

        public double Kontobuchung_USt { get; set; }

        public char KB_SH { get; set; }

        public int Kontobuchung_USt_Konto { get; set; }

        public double Kontobuchung_UStPercent { get; set; }

        public double Steuerbuchung_USt { get; set; }

        public char SB_SH { get; set; }

        public int Steuerbuchung_USt_Konto { get; set; }

        public double Steuerbuchung_UStPercent { get; set; }

        public string WKZ_BW { get; set; }

    }
}
