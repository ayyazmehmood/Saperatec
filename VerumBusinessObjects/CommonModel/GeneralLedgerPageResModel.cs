using System;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace VerumBusinessObjects
{
    public class GeneralLedgerPageResModel
    {
        public GeneralLedgerPageResModel()
        {
            value = new List<GeneralLedgerValue>();
        }
        public List<GeneralLedgerValue> value { get; set; }

        [JsonProperty("@odata.context")]
        public string DataContext { get; set; }

        [JsonProperty("@odata.nextLink")]
        public string NextLink { get; set; }
        public class GeneralLedgerValue
        {
            [JsonProperty("Entry_No")]
            public int EntryNo { get; set; }

            [JsonProperty("Posting_Date")]
            public DateTime PostingDate { get; set; }

            [JsonProperty("Document_Type")]
            public string DocumentType { get; set; }

            [JsonProperty("Document_No")]
            public string DocumentNo { get; set; }

            [JsonProperty("G_L_Account_No")]
            public int GLAccountNo { get; set; }

            [JsonProperty("GLAccount_Name")]
            public string GLAccount_Name { get; set; }

            [JsonProperty("Description")]
            public string Description { get; set; }

            [JsonProperty("Job_No")]
            public string JobNo { get; set; }

            [JsonProperty("Global_Dimension_1_Code")]
            public string GlobalDimension1Code { get; set; }

            [JsonProperty("Global_Dimension_2_Code")]
            public string GlobalDimension2Code { get; set; }

            [JsonProperty("IC_Partner_Code")]
            public string ICPartnerCode { get; set; }

            [JsonProperty("Gen_Posting_Type")]
            public string GenPostingType { get; set; }

            [JsonProperty("Gen_Bus_Posting_Group")]
            public string GenBusPostingGroup { get; set; }

            [JsonProperty("Gen_Prod_Posting_Group")]
            public string GenProdPostingGroup { get; set; }

            [JsonProperty("Quantity")]
            public Int64 Quantity { get; set; }

            [JsonProperty("Amount")]
            public double Amount { get; set; }

            [JsonProperty("Debit_Amount")]
            public double DebitAmount { get; set; }

            [JsonProperty("Credit_Amount")]
            public double CreditAmount { get; set; }

            [JsonProperty("Additional_Currency_Amount")]
            public Int64 AdditionalCurrencyAmount { get; set; }

            [JsonProperty("VAT_Amount")]
            public double VATAmount { get; set; }

            [JsonProperty("Bal_Account_Type")]
            public string BalAccountType { get; set; }

            [JsonProperty("Bal_Account_No")]
            public string BalAccountNo { get; set; }

            [JsonProperty("VAT_Reporting_Date")]
            public string VATReportingDate { get; set; }

            [JsonProperty("User_ID")]
            public string UserID { get; set; }

            [JsonProperty("Source_Code")]
            public string SourceCode { get; set; }

            [JsonProperty("Source_Type")]
            public string SourceType { get; set; }

            [JsonProperty("Source_No")]
            public string SourceNo { get; set; }

            [JsonProperty("Reason_Code")]
            public string ReasonCode { get; set; }

            [JsonProperty("Reversed")]
            public bool Reversed { get; set; }

            [JsonProperty("Reversed_by_Entry_No")]
            public string ReversedbyEntryNo { get; set; }

            [JsonProperty("Reversed_Entry_No")]
            public string ReversedEntryNo { get; set; }

            [JsonProperty("FA_Entry_Type")]
            public string FAEntryType { get; set; }

            [JsonProperty("FA_Entry_No")]
            public string FAEntryNo { get; set; }

            [JsonProperty("Dimension_Set_ID")]
            public Int64 DimensionSetID { get; set; }

            [JsonProperty("External_Document_No")]
            public string ExternalDocumentNo { get; set; }

            [JsonProperty("Shortcut_Dimension_3_Code")]
            public string ShortcutDimension3Code { get; set; }

            [JsonProperty("Shortcut_Dimension_4_Code")]
            public string ShortcutDimension4Code { get; set; }

            [JsonProperty("Shortcut_Dimension_5_Code")]
            public string ShortcutDimension5Code { get; set; }

            [JsonProperty("Shortcut_Dimension_6_Code")]
            public string ShortcutDimension6Code { get; set; }

            [JsonProperty("Shortcut_Dimension_7_Code")]
            public string ShortcutDimension7Code { get; set; }

            [JsonProperty("Shortcut_Dimension_8_Code")]
            public string ShortcutDimension8Code { get; set; }

            [JsonProperty("Transaktionsnummer")]
            public int Transaktionsnummer { get; set; }

            [JsonProperty("Zeitpunkt_der_letzten_Änderung")]
            public DateTime Zeitpunkt_der_letzten_Änderung { get; set; }

            [JsonProperty("Zuletzt_geändert")]
            public DateTime LastModifiedDate { get; set; }

            [JsonProperty("Zuletzt_geändert_von")]
            public string LastModifiedBy { get; set; }

            [JsonProperty("Erstellt")]
            public DateTime CreatedDate { get; set; }

            [JsonProperty("Erstellt_von")]
            public string CreatedBy { get; set; }

            [JsonProperty("Journal_Batch_Name")]
            public string JournalBatchName { get; set; }

            [JsonProperty("Journal_Templ_Name")]
            public string JournalTempl_Name { get; set; }
        }

    }
}
