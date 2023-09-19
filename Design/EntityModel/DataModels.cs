namespace VerumBusinessObjects
{
	using System;
	using System.Collections.Generic;
	using System.ComponentModel.DataAnnotations;
	using System.ComponentModel.DataAnnotations.Schema;
	using System.Data.Entity.Spatial;

		[Table("vPlan")]
		public partial class vPlan
		{
			[key]
			[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
			public int Id { get; set; }

			public int? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			public int idClient{ get; set; }

			public int? idPlanBase{ get; set; }

			[StringLength(30)]
			public string TitlePlan{ get; set; }

			public DateTime DateValidFrom{ get; set; }

			public DateTime DateValidTo{ get; set; }

			bool PlanFlagBaseline{ get; set; }

			public short TypeStatus{ get; set; }

			[StringLength(30)]
			public string TitleClient{ get; set; }

			public int idCurrencyClient{ get; set; }

			bool FlagTemplate{ get; set; }

			public int StartOfBusinessYear{ get; set; }

		}

		[Table("vPlanElement")]
		public partial class vPlanElement
		{
			[key]
			[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
			public int Id { get; set; }

			public int? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			public int idClientPlanElement{ get; set; }

			public int idCostCenterPlanElement{ get; set; }

			public short TypePlanElement{ get; set; }

			public int idPlanGroup{ get; set; }

			[StringLength(50)]
			public string TitlePlanElement{ get; set; }

			[StringLength(15)]
			public string ReferenceIDPlanElement{ get; set; }

			bool ElementFlagBaseline{ get; set; }

			public string? PlanElementDescription{ get; set; }

			[StringLength(30)]
			public string TitleClient{ get; set; }

			public int idCurrencyClient{ get; set; }

			bool FlagTemplate{ get; set; }

			public int StartOfBusinessYear{ get; set; }

			[StringLength(12)]
			public string CostCenterCode{ get; set; }

			[StringLength(255)]
			public string TitleCostCenter{ get; set; }

			bool FlagProfitCenter{ get; set; }

			[StringLength(30)]
			public string TitlePlanGroup{ get; set; }

		}

		[Table("vPlanElementInstance")]
		public partial class vPlanElementInstance
		{
			[key]
			[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
			public int Id { get; set; }

			public int? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			public int idPlanElement{ get; set; }

			public int idPlan{ get; set; }

			public int idPlanItem{ get; set; }

			public int idClientPlanElement{ get; set; }

			public int idCostCenterPlanElement{ get; set; }

			public short TypePlanElement{ get; set; }

			public int idPlanGroup{ get; set; }

			[StringLength(50)]
			public string TitlePlanElement{ get; set; }

			[StringLength(15)]
			public string ReferenceIDPlanElement{ get; set; }

			bool ElementFlagBaseline{ get; set; }

			public string? PlanElementDescription{ get; set; }

			public int? idPlanBase{ get; set; }

			[StringLength(30)]
			public string TitlePlan{ get; set; }

			public DateTime DateValidFrom{ get; set; }

			public DateTime DateValidTo{ get; set; }

			bool PlanFlagBaseline{ get; set; }

			public short TypeStatus{ get; set; }

		}

		[Table("vPlanTransaction")]
		public partial class vPlanTransaction
		{
			[key]
			[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
			public int Id { get; set; }

			public int? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			public int idPlan{ get; set; }

			public int idBookTransaction{ get; set; }

			public int idClient{ get; set; }

			public int? idPlanBase{ get; set; }

			[StringLength(30)]
			public string TitlePlan{ get; set; }

			public DateTime DateValidFrom{ get; set; }

			public DateTime DateValidTo{ get; set; }

			bool PlanFlagBaseline{ get; set; }

			public short TypeStatus{ get; set; }

			public int idBookingRecord{ get; set; }

			public int idAccountTransaction{ get; set; }

			public int idAccountCounter{ get; set; }

			double AmountDebit{ get; set; }

			double AmountCredit{ get; set; }

			double AmountTotal{ get; set; }

		}

		[Table("vPlanContract")]
		public partial class vPlanContract
		{
			[key]
			[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
			public int Id { get; set; }

			public int? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			public int idPlanInstance{ get; set; }

			public int idAccountMain{ get; set; }

			public int? idAllocationSchedule{ get; set; }

			public short TypeRepeat{ get; set; }

			public int? idAccountAdvanceAccrual{ get; set; }

			public int AdvanceDelay{ get; set; }

			public int? idAccrualSchedule{ get; set; }

			public int? idDepreciationRule{ get; set; }

			public int? idDepreciationTrigger{ get; set; }

			public int DepreciationDelay{ get; set; }

			public int? idVATRule{ get; set; }

			public int? idParInflation{ get; set; }

			public int? idParPrice1{ get; set; }

			public int? idParPrice2{ get; set; }

			public int idCurrencyContract{ get; set; }

			public int? idParTriggerDate{ get; set; }

			bool ContractFlagBaseline{ get; set; }

			bool FlagDateOffset{ get; set; }

			public int DueDateYear{ get; set; }

			public int DueDateMonth{ get; set; }

			public int DueDateDay{ get; set; }

			public int UntilDateYearContract{ get; set; }

			public int UntilDateMonthContract{ get; set; }

			public int? UntilDateDayContract{ get; set; }

			public int PaymentTerm{ get; set; }

			public int NumberOfUnits{ get; set; }

			double Price{ get; set; }

			public DateTime? PriceDate{ get; set; }

			double BudgetBase{ get; set; }

			double ContingencyRate{ get; set; }

			double BudgetContingency{ get; set; }

			public string? Assumptions{ get; set; }

			public string? Revisions{ get; set; }

			public int idPlanElement{ get; set; }

			public int idPlan{ get; set; }

			public int idPlanItem{ get; set; }

			public int idClientMain{ get; set; }

			public int? idAccountGroupMain{ get; set; }

			public int? idAccountReportingMain{ get; set; }

			public int AccountCodeMain{ get; set; }

			public short TypeAccountMain{ get; set; }

			[StringLength(50)]
			public string TitleLocalAccountMain{ get; set; }

			[StringLength(50)]
			public string TitleEnglishAccountMain{ get; set; }

			bool FlagPlanMain{ get; set; }

			[StringLength(30)]
			public string TitleAllocationSchedule{ get; set; }

			public int MonthsBetweenItems{ get; set; }

			double PerpetualRate{ get; set; }

			public int idClientAdvance{ get; set; }

			public int? idAccountGroupAdvance{ get; set; }

			public int? idAccountReportingAdvance{ get; set; }

			public int AccountCodeAdvance{ get; set; }

			public short TypeAccountAdvance{ get; set; }

			[StringLength(50)]
			public string TitleLocalAccountAdvance{ get; set; }

			[StringLength(50)]
			public string TitleEnglishAccountAdvance{ get; set; }

			bool FlagPlanAdvance{ get; set; }

			public int idPlanAccrual{ get; set; }

			[StringLength(30)]
			public string TitleAllocationScheduleAccrual{ get; set; }

			public int MonthsBetweenItemsAccrual{ get; set; }

			double PerpetualRateAccrual{ get; set; }

			public int idAccountDepreciation{ get; set; }

			[StringLength(50)]
			public string TitleDepreciationRule{ get; set; }

			public int NumberOfPeriods{ get; set; }

			public int PeriodInMonths{ get; set; }

			public short TypeDepreciationRule{ get; set; }

			public int idPlanDepreciationTrigger{ get; set; }

			public short TypePlanParameterDepreciationTrigger{ get; set; }

			[StringLength(30)]
			public string TitlePlanParameterDepreciationTrigger{ get; set; }

			double ValueNumDepreciationTrigger{ get; set; }

			public DateTime? ValueDateDepreciationTrigger{ get; set; }

			[StringLength(30)]
			public string? ValueTextDepreciationTrigger{ get; set; }

			[StringLength(15)]
			public string? UnitParameterDepreciationTrigger{ get; set; }

			public string? PlanParameterCommentDepreciationTrigger{ get; set; }

			public int idAccountVATInput{ get; set; }

			public int idAccountVATOutput{ get; set; }

			[StringLength(5)]
			public string VATRuleCode{ get; set; }

			[StringLength(50)]
			public string TitleVATRule{ get; set; }

			double RateCurrent{ get; set; }

			public DateTime DateRateChange{ get; set; }

			double RateFuture{ get; set; }

			bool FlagReverseCharge{ get; set; }

			public int idPlanInflation{ get; set; }

			public short TypePlanParameterInflation{ get; set; }

			[StringLength(30)]
			public string TitlePlanParameterInflation{ get; set; }

			double ValueNumInflation{ get; set; }

			public DateTime? ValueDateInflation{ get; set; }

			[StringLength(30)]
			public string? ValueTextInflation{ get; set; }

			[StringLength(15)]
			public string? UnitParameterInflation{ get; set; }

			public string? PlanParameterCommentInflation{ get; set; }

			public int idPlanPrice1{ get; set; }

			public short TypePlanParameterPrice1{ get; set; }

			[StringLength(30)]
			public string TitlePlanParameterPrice1{ get; set; }

			double ValueNumPrice1{ get; set; }

			public DateTime? ValueDatePrice1{ get; set; }

			[StringLength(30)]
			public string? ValueTextPrice1{ get; set; }

			[StringLength(15)]
			public string? UnitParameterPrice1{ get; set; }

			public string? PlanParameterCommentPrice1{ get; set; }

			public int idPlanPrice2{ get; set; }

			public short TypePlanParameterPrice2{ get; set; }

			[StringLength(30)]
			public string TitlePlanParameterPrice2{ get; set; }

			double ValueNumPrice2{ get; set; }

			public DateTime? ValueDatePrice2{ get; set; }

			[StringLength(30)]
			public string? ValueTextPrice2{ get; set; }

			[StringLength(15)]
			public string? UnitParameterPrice2{ get; set; }

			public string? PlanParameterCommentPrice2{ get; set; }

			[StringLength(3)]
			public string CurrencyCode{ get; set; }

			[StringLength(30)]
			public string TitleCurrency{ get; set; }

			public int idPlanBookingTrigger{ get; set; }

			public short TypePlanParameterBookingTrigger{ get; set; }

			[StringLength(30)]
			public string TitlePlanParameterBookingTrigger{ get; set; }

			double ValueNumBookingTrigger{ get; set; }

			public DateTime? ValueDateBookingTrigger{ get; set; }

			[StringLength(30)]
			public string? ValueTextBookingTrigger{ get; set; }

			[StringLength(15)]
			public string? UnitParameterBookingTrigger{ get; set; }

			public string? PlanParameterCommentBookingTrigger{ get; set; }

		}

		[Table("vBookRecord")]
		public partial class vBookRecord
		{
			[key]
			[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
			public int Id { get; set; }

			public int? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			public int idClient{ get; set; }

			bool FlagOutdated{ get; set; }

			public DateTime DateOutdated{ get; set; }

			public short TypeBookRecord{ get; set; }

			public int idAccountDebit{ get; set; }

			public int idAccountCredit{ get; set; }

			public int idCostCenterBookRecord{ get; set; }

			public int idBookingRun{ get; set; }

			public int BookingSequenceNum{ get; set; }

			public int idPlanElementInstance{ get; set; }

			[StringLength(255)]
			public string TitleBookRecord{ get; set; }

			public DateTime BookingDate{ get; set; }

			public int BusinessYear{ get; set; }

			public int BookingYear{ get; set; }

			public short BookingQuarter{ get; set; }

			public short BookingMonth{ get; set; }

			double Amount{ get; set; }

			[StringLength(50)]
			public string BookingDocument1{ get; set; }

			[StringLength(50)]
			public string BookingDocument2{ get; set; }

			[StringLength(15)]
			public string ReferenceIDBookRecord{ get; set; }

			public string BookRecordComment{ get; set; }

			[StringLength(30)]
			public string TitleClient{ get; set; }

			public int idCurrencyClient{ get; set; }

			bool FlagTemplate{ get; set; }

			public int StartOfBusinessYear{ get; set; }

			public int idClientAccountDebit{ get; set; }

			public int? idAccountGroupAccountDebit{ get; set; }

			public int? idAccountReportingAccountDebit{ get; set; }

			public int AccountCodeAccountDebit{ get; set; }

			public short TypeAccountAccountDebit{ get; set; }

			[StringLength(50)]
			public string TitleLocalAccountAccountDebit{ get; set; }

			[StringLength(50)]
			public string TitleEnglishAccountAccountDebit{ get; set; }

			bool FlagPlanAccountDebit{ get; set; }

			public int idClientAccountCredit{ get; set; }

			public int? idAccountGroupAccountCredit{ get; set; }

			public int? idAccountReportingAccountCredit{ get; set; }

			public int AccountCodeAccountCredit{ get; set; }

			public short TypeAccountAccountCredit{ get; set; }

			[StringLength(50)]
			public string TitleLocalAccountAccountCredit{ get; set; }

			[StringLength(50)]
			public string TitleEnglishAccountAccountCredit{ get; set; }

			bool FlagPlanAccountCredit{ get; set; }

			[StringLength(12)]
			public string CostCenterCode{ get; set; }

			[StringLength(255)]
			public string TitleCostCenter{ get; set; }

			bool FlagProfitCenter{ get; set; }

			[StringLength(20)]
			public string BookingRunCode{ get; set; }

			public int PeriodYear{ get; set; }

			public short PeriodMonth{ get; set; }

			public int SerialNum{ get; set; }

			[StringLength(50)]
			public string TitleBookingRun{ get; set; }

			public int idPlanElement{ get; set; }

			public int idPlan{ get; set; }

			public int idPlanItem{ get; set; }

		}

}
