using Newtonsoft.Json;
using System;

namespace VerumBusinessObjects
{
    public class GLEntriesResModel
    {

        [JsonProperty("Entry_No")]
        public Int64 Entry_No { get; set; }

        [JsonProperty("Transaction_No")]
        public Int64 Transaction_No { get; set; }

        [JsonProperty("G_L_Account_No")]
        public Int64 G_L_Account_No { get; set; }

        [JsonProperty("Posting_Date")]
        public string Posting_Date { get; set; }

        [JsonProperty("Document_Date")]
        public string Document_Date { get; set; }

        [JsonProperty("Document_Type")]
        public string Document_Type { get; set; }

        [JsonProperty("Document_No")]
        public string Document_No { get; set; }

        [JsonProperty("Source_Code")]
        public string Source_Code { get; set; }

        [JsonProperty("Job_No")]
        public string Job_No { get; set; }

        [JsonProperty("Business_Unit_Code")]
        public string Business_Unit_Code { get; set; }

        [JsonProperty("Reason_Code")]
        public string Reason_Code { get; set; }

        [JsonProperty("Gen_Posting_Type")]
        public string Gen_Posting_Type { get; set; }

        [JsonProperty("Gen_Bus_Posting_Group")]
        public string Gen_Bus_Posting_Group { get; set; }

        [JsonProperty("Gen_Prod_Posting_Group")]
        public string Gen_Prod_Posting_Group { get; set; }

        [JsonProperty("Tax_Area_Code")]
        public string Tax_Area_Code { get; set; }

        [JsonProperty("Tax_Liable")]
        public bool? Tax_Liable { get; set; }

        [JsonProperty("Tax_Group_Code")]
        public string Tax_Group_Code { get; set; }

        [JsonProperty("Use_Tax")]
        public bool? Use_Tax { get; set; }

        [JsonProperty("VAT_Bus_Posting_Group")]
        public string VAT_Bus_Posting_Group { get; set; }

        [JsonProperty("VAT_Prod_Posting_Group")]
        public string VAT_Prod_Posting_Group { get; set; }

        [JsonProperty("IC_Partner_Code")]
        public string IC_Partner_Code { get; set; }

        [JsonProperty("Amount")]
        public Int64 Amount { get; set; }

        [JsonProperty("Debit_Amount")]
        public Int64 Debit_Amount { get; set; }

        [JsonProperty("Credit_Amount")]
        public Int64 Credit_Amount { get; set; }

        [JsonProperty("VAT_Amount")]
        public Int64 VAT_Amount { get; set; }

        [JsonProperty("Additional_Currency_Amount")]
        public Int64 Additional_Currency_Amount { get; set; }

        [JsonProperty("Add_Currency_Debit_Amount")]
        public Int64 Add_Currency_Debit_Amount { get; set; }

        [JsonProperty("Add_Currency_Credit_Amount")]
        public Int64 Add_Currency_Credit_Amount { get; set; }

        [JsonProperty("Dimension_Set_ID")]
        public string Dimension_Set_ID { get; set; }

        [JsonProperty("G_L_Account_Name")]
        public string G_L_Account_Name { get; set; }
    }
}
