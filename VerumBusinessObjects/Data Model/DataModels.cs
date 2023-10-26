// CAUTION - This file is auto-generated from the data dictionary. Do not change manually!

namespace VerumBusinessObjects
{
	using System;
	using System.Collections.Generic;
	using System.ComponentModel.DataAnnotations;
	using System.ComponentModel.DataAnnotations.Schema;
	using System.Threading.Tasks;
	using System.Data.Entity.Spatial;
	using VerumBusinessObjects.Framework;

		[Table("tCurrency")]
		public partial class tCurrency : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			[StringLength(3)]
			public string CurrencyCode{ get; set; }

			[Required]
			[StringLength(30)]
			public string TitleCurrency{ get; set; }

		}

		[Table("tClient")]
		public partial class tClient : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			[StringLength(30)]
			public string TitleClient{ get; set; }

			[Required]
			public Guid idCurrencyClient{ get; set; }

			[Required]
			public bool FlagTemplate{ get; set; }

			[Required]
			public int StartOfBusinessYear{ get; set; }

			public int? DATEVClientNumber{ get; set; }

			public Guid? idReferenceGroupDefault{ get; set; }

			public DateTime? BCLastUpdate{ get; set; }

			[StringLength(500)]
			public string BusinessCenterUrl{ get; set; }

			[Required]
			public int BCLastBookingCodeNo{ get; set; }

		}

		[Table("tTypeGroupDef")]
		public partial class tTypeGroupDef : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			[StringLength(25)]
			public string TypeGroupID{ get; set; }

		}

		[Table("tTypeCodeDef")]
		public partial class tTypeCodeDef : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idTypeGroupDef{ get; set; }

			[Required]
			[StringLength(25)]
			public string TypeID{ get; set; }

			[Required]
			public short TypeCode{ get; set; }

		}

		[Table("tUser")]
		public partial class tUser : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			[StringLength(255)]
			public string UserName{ get; set; }

			[Required]
			[StringLength(30)]
			public string UserLogin{ get; set; }

			[Required]
			[StringLength(48)]
			public string UserPasswordHash{ get; set; }

			[Required]
			public Guid idClientDefault{ get; set; }

			[Required]
			public short TypeUser{ get; set; }

			[StringLength(255)]
			public string DATEVImportFolder{ get; set; }

			[StringLength(255)]
			public string DataImportFolder{ get; set; }

		}

		[Table("tSession")]
		public partial class tSession : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idUser{ get; set; }

			[Required]
			public Guid idClient{ get; set; }

		}

		[Table("tJobReport")]
		public partial class tJobReport : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			public Guid? idUser{ get; set; }

			[Required]
			public short TypeJob{ get; set; }

			[Required]
			public DateTime DateJobStart{ get; set; }

			public DateTime? DateJobEnd{ get; set; }

			[Required]
			public short TypeJobSuccess{ get; set; }

		}

		[Table("tJobReportItem")]
		public partial class tJobReportItem : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idJobReport{ get; set; }

			[Required]
			public DateTime Timestamp{ get; set; }

			[Required]
			public short TypeJobSuccess{ get; set; }

			[Required]
			public int ResultCode{ get; set; }

			[StringLength(255)]
			public string ObjectTitle{ get; set; }

			[StringLength(255)]
			public string ContextInfo{ get; set; }

			[StringLength(255)]
			public string Message{ get; set; }

		}

		[Table("tAccountSection")]
		public partial class tAccountSection : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			[Required]
			[StringLength(255)]
			public string TitleLocalSection{ get; set; }

			[StringLength(255)]
			public string TitleEnglishSection{ get; set; }

			[Required]
			public short TypeAccount{ get; set; }

			[Required]
			public int SectionOrder{ get; set; }

		}

		[Table("tAccountMainGroup")]
		public partial class tAccountMainGroup : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			[Required]
			public Guid idAccountSection{ get; set; }

			[Required]
			[StringLength(255)]
			public string TitleLocalMainGroup{ get; set; }

			[StringLength(255)]
			public string TitleEnglishMainGroup{ get; set; }

			[Required]
			public int MainGroupOrder{ get; set; }

		}

		[Table("tAccountGroup")]
		public partial class tAccountGroup : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			public Guid? idAccountMainGroup{ get; set; }

			[Required]
			[StringLength(255)]
			public string TitleLocalAccountGroup{ get; set; }

			[StringLength(255)]
			public string TitleEnglishAccountGroup{ get; set; }

			[Required]
			public int AccountGroupOrder{ get; set; }

			[Required]
			public int AccountCodeFrom{ get; set; }

			[Required]
			public int AccountCodeTo{ get; set; }

			public Guid? idAccountReportingDefault{ get; set; }

			[Required]
			public short TypeAccountDefault{ get; set; }

		}

		[Table("tAccount")]
		public partial class tAccount : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			public Guid? idAccountGroup{ get; set; }

			public Guid? idAccountReporting{ get; set; }

			[Required]
			public int AccountCode{ get; set; }

			[Required]
			public short TypeAccount{ get; set; }

			[Required]
			[StringLength(255)]
			public string TitleLocalAccount{ get; set; }

			[StringLength(255)]
			public string TitleEnglishAccount{ get; set; }

			[Required]
			public bool FlagPlan{ get; set; }

			public Guid? idAccountSection{ get; set; }

			public Guid? idAccountMainGroup{ get; set; }

		}

		[Table("tPlanAccountFunction")]
		public partial class tPlanAccountFunction : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			[Required]
			public int TypeAccountFunction{ get; set; }

			[Required]
			public Guid idAccountPlanAccountFunction{ get; set; }

		}

		[Table("tCostCenter")]
		public partial class tCostCenter : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			[Required]
			[StringLength(12)]
			public string CostCenterCode{ get; set; }

			[Required]
			[StringLength(50)]
			public string TitleCostCenter{ get; set; }

			[StringLength(50)]
			public string TitleEnglishCostCenter{ get; set; }

			[Required]
			public bool FlagProfitCenter{ get; set; }

			public string DescriptionCostCenter{ get; set; }

		}

		[Table("tDepreciationRule")]
		public partial class tDepreciationRule : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			[Required]
			public Guid idAccountActivation{ get; set; }

			public Guid? idAccountDepreciation{ get; set; }

			[Required]
			[StringLength(50)]
			public string TitleDepreciationRule{ get; set; }

			[Required]
			public int NumberOfPeriods{ get; set; }

			[Required]
			public int PeriodInMonths{ get; set; }

			[Required]
			public short TypeDepreciationRule{ get; set; }

		}

		[Table("tVATRule")]
		public partial class tVATRule : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			[Required]
			public Guid idAccountVATInput{ get; set; }

			[Required]
			public Guid idAccountVATOutput{ get; set; }

			public Guid? idAccountVATBalance{ get; set; }

			[StringLength(5)]
			public string VATRuleCode{ get; set; }

			[Required]
			[StringLength(50)]
			public string TitleVATRule{ get; set; }

			[Required]
			public double RateCurrent{ get; set; }

			[Required]
			public int SettlementTerm{ get; set; }

			public DateTime? DateRateChange{ get; set; }

			public double? RateFuture{ get; set; }

			[Required]
			public bool FlagReverseCharge{ get; set; }

		}

		[Table("tReferenceGroup")]
		public partial class tReferenceGroup : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			[Required]
			[StringLength(1)]
			public string TypeReferenceGroup{ get; set; }

			[Required]
			[StringLength(50)]
			public string TitleReferenceGroup{ get; set; }

			[StringLength(2)]
			public string BaseCode{ get; set; }

			[Required]
			public int NextNum{ get; set; }

			[Required]
			public bool FlagAutoGen{ get; set; }

			[Required]
			public short AutoDigits{ get; set; }

		}

		[Table("tReferenceCode")]
		public partial class tReferenceCode : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			[Required]
			public Guid idReferenceGroup{ get; set; }

			[Required]
			[StringLength(12)]
			public string RefCode{ get; set; }

			[StringLength(50)]
			public string TitleRefCode{ get; set; }

			public string RefCodeComment{ get; set; }

			[Required]
			public bool FlagActive{ get; set; }

			[StringLength(50)]
			public string TitleRefCodeEnglish{ get; set; }

		}

		[Table("tBookingRun")]
		public partial class tBookingRun : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			[Required]
			[StringLength(30)]
			public string BookingRunCode{ get; set; }

			[Required]
			public int PeriodYear{ get; set; }

			[Required]
			public short PeriodMonth{ get; set; }

			[Required]
			[StringLength(10)]
			public string SerialNum{ get; set; }

			[Required]
			public short VersionCode{ get; set; }

			[Required]
			public bool StatusPreliminary{ get; set; }

			[StringLength(100)]
			public string BookingRunTitle{ get; set; }

			[Required]
			[StringLength(255)]
			public string ImportFileName{ get; set; }

			[Required]
			public DateTime ImportFileDate{ get; set; }

			[Required]
			public DateTime ImportedDate{ get; set; }

			[Required]
			public int RecordsImported{ get; set; }

			[Required]
			public int RecordsOmitted{ get; set; }

		}

		[Table("tPlan")]
		public partial class tPlan : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			public Guid? idPlanBase{ get; set; }

			[Required]
			[StringLength(30)]
			public string TitlePlan{ get; set; }

			[Required]
			public DateTime DateValidFrom{ get; set; }

			[Required]
			public DateTime DateValidTo{ get; set; }

			public DateTime? ApprovedTo{ get; set; }

			[Required]
			public bool PlanFlagBaseline{ get; set; }

			[Required]
			public short TypeStatus{ get; set; }

		}

		[Table("tPlanGroup")]
		public partial class tPlanGroup : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			[Required]
			[StringLength(30)]
			public string TitlePlanGroup{ get; set; }

			[StringLength(30)]
			public string TitleEnglishPlanGroup{ get; set; }

			public string DescriptionPlanGroup{ get; set; }

		}

		[Table("tPlanElement")]
		public partial class tPlanElement : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			public Guid? idCostCenterPlanElement{ get; set; }

			public Guid? idCurrency{ get; set; }

			[Required]
			public short TypePlanElement{ get; set; }

			public Guid? idPlanGroup{ get; set; }

			[Required]
			[StringLength(50)]
			public string TitlePlanElement{ get; set; }

			[StringLength(15)]
			public string ReferenceIDPlanElement{ get; set; }

			[Required]
			public bool ElementFlagBaseline{ get; set; }

			public string PlanElementDescription{ get; set; }

		}

		[Table("tPlanInflationRule")]
		public partial class tPlanInflationRule : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idPlan{ get; set; }

			[Required]
			[StringLength(30)]
			public string TitleInflationRule{ get; set; }

			[Required]
			public short InflationInterval{ get; set; }

			[Required]
			public double InflationRateAnnual{ get; set; }

			public string InflationRuleComment{ get; set; }

		}

		[Table("tCurrencyExchangeRate")]
		public partial class tCurrencyExchangeRate : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			public Guid? idPlan{ get; set; }

			[Required]
			public Guid idCurrencyExchangeRate{ get; set; }

			[Required]
			public DateTime DateExchangeRate{ get; set; }

			[Required]
			public double RatePerClientCurrency{ get; set; }

		}

		[Table("tPlanParameter")]
		public partial class tPlanParameter : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idPlan{ get; set; }

			[Required]
			public short TypePlanParameter{ get; set; }

			[Required]
			[StringLength(30)]
			public string TitlePlanParameter{ get; set; }

			[Required]
			public double ValueNum{ get; set; }

			public DateTime? ValueDate{ get; set; }

			[StringLength(30)]
			public string ValueText{ get; set; }

			[StringLength(15)]
			public string UnitParameter{ get; set; }

			public string PlanParameterComment{ get; set; }

		}

		[Table("tPlanAllocationSchedule")]
		public partial class tPlanAllocationSchedule : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idPlan{ get; set; }

			[Required]
			[StringLength(255)]
			public string TitleAllocationSchedule{ get; set; }

			[Required]
			public int MonthsBetweenItems{ get; set; }

			[Required]
			public double PerpetualRate{ get; set; }

			[Required]
			public bool FlagScheduleShared{ get; set; }

			[Required]
			public bool FlagAbsoluteRates{ get; set; }

			[Required]
			public int AdvanceDelayPeriods{ get; set; }

			[Required]
			public bool FlagAuto{ get; set; }

			public short? Period1{ get; set; }

			public double? Rate1{ get; set; }

			public short? Period2{ get; set; }

			public double? Rate2{ get; set; }

			public short? Period3{ get; set; }

			public double? Rate3{ get; set; }

		}

		[Table("tPlanAllocationScheduleItems")]
		public partial class tPlanAllocationScheduleItems : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idPlanAllocationSchedule{ get; set; }

			[Required]
			public int OrderNum{ get; set; }

			[Required]
			public double ItemRate{ get; set; }

		}

		[Table("tPlanHRTariff")]
		public partial class tPlanHRTariff : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idPlan{ get; set; }

			[Required]
			[StringLength(50)]
			public string TitleTariff{ get; set; }

			[Required]
			public Guid idAccountSalary{ get; set; }

			[Required]
			public short PayDay{ get; set; }

			public string TariffDescription{ get; set; }

			[Required]
			public bool FlagShared{ get; set; }

			public DateTime? DateInflationBase{ get; set; }

		}

		[Table("tPlanHRTariffDetail")]
		public partial class tPlanHRTariffDetail : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idTariff{ get; set; }

			public DateTime? DateValidTo{ get; set; }

			[Required]
			public short WorkTimeWeekly{ get; set; }

			[Required]
			public double FTEFactor{ get; set; }

			[Required]
			public double RatioShiftNight{ get; set; }

			[Required]
			public double RatioShiftSpecial{ get; set; }

			[Required]
			public double RatioOvertime{ get; set; }

			[Required]
			public short AnnualLeave{ get; set; }

			[Required]
			public short StandardHolidays{ get; set; }

			[Required]
			public double BaseSalaryMonthly{ get; set; }

			[Required]
			public double RateShiftNight{ get; set; }

			[Required]
			public double RateShiftSpecial{ get; set; }

			[Required]
			public double RateOvertime{ get; set; }

			public double? RateAnnualBonus{ get; set; }

			[Required]
			public short AnnualBonusMonth{ get; set; }

		}

		[Table("tPlanHRExpenseGroup")]
		public partial class tPlanHRExpenseGroup : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idPlan{ get; set; }

			[Required]
			[StringLength(50)]
			public string TitleExpenseGroup{ get; set; }

			public string ExpenseGroupDescription{ get; set; }

			public DateTime? DateInflationBase{ get; set; }

		}

		[Table("tPlanHRExpense")]
		public partial class tPlanHRExpense : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idExpenseGroup{ get; set; }

			public DateTime? DateValidTo{ get; set; }

			[Required]
			[StringLength(50)]
			public string TitleExpense{ get; set; }

			[Required]
			public Guid idAccountExpense{ get; set; }

			public Guid? idCostCenterFixed{ get; set; }

			[Required]
			public double RatioToSalary{ get; set; }

			[Required]
			public double ExpenseAmount{ get; set; }

			[Required]
			public double SalaryCap{ get; set; }

			[Required]
			public double DeductFromSalary{ get; set; }

			[Required]
			public short ApplyToBonusMode{ get; set; }

			public string Assumptions{ get; set; }

		}

		[Table("tPlanElementInstance")]
		public partial class tPlanElementInstance : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idPlanElement{ get; set; }

			[Required]
			public Guid idPlan{ get; set; }

			[Required]
			public bool FlagUpdate{ get; set; }

			[Required]
			public bool FlagBaseline{ get; set; }

			[Required]
			public bool FlagDateOffset{ get; set; }

			[Required]
			public int DueDateYear{ get; set; }

			[Required]
			public int DueDateMonth{ get; set; }

			[Required]
			public int DueDateDay{ get; set; }

			public int? UntilDateYear{ get; set; }

			public int? UntilDateMonth{ get; set; }

			public int? UntilDateDay{ get; set; }

			public Guid? idParTriggerDueDate{ get; set; }

			public string Assumptions{ get; set; }

			public string Revisions{ get; set; }

		}

		[Table("tPlanElementContract")]
		public partial class tPlanElementContract : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idPlanInstance{ get; set; }

			[Required]
			public Guid idAccountMain{ get; set; }

			public Guid? idAllocationSchedule{ get; set; }

			[Required]
			public short TypeRepeat{ get; set; }

			public Guid? idAccountAdvance{ get; set; }

			public Guid? idParTriggerAdvance{ get; set; }

			[Required]
			public int AdvanceDelay{ get; set; }

			public Guid? idDepreciationRule{ get; set; }

			public Guid? idDepreciationTrigger{ get; set; }

			public int? DepreciationStartDay{ get; set; }

			public int? DepreciationStartMonth{ get; set; }

			public int? DepreciationStartYear{ get; set; }

			[Required]
			public int DepreciationDelay{ get; set; }

			public Guid? idVATRule{ get; set; }

			public Guid? idInflationRule{ get; set; }

			public Guid? idParPrice1{ get; set; }

			public Guid? idParPrice2{ get; set; }

			[Required]
			public int PaymentTerm{ get; set; }

			[Required]
			public int NumberOfUnits{ get; set; }

			[Required]
			public double Price{ get; set; }

			public DateTime? PriceDate{ get; set; }

			[Required]
			public double BudgetFixed{ get; set; }

			public Guid? idParContingencyRate{ get; set; }

		}

		[Table("tPlanElementBooking")]
		public partial class tPlanElementBooking : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idPlanInstance{ get; set; }

			[Required]
			public Guid idAccountDebit{ get; set; }

			[Required]
			public Guid idAccountCredit{ get; set; }

			public Guid? idAllocationSchedule{ get; set; }

			[Required]
			public short TypeRepeat{ get; set; }

			public Guid? idInflationRule{ get; set; }

			public Guid? idParPrice1{ get; set; }

			public Guid? idParPrice2{ get; set; }

			[Required]
			public int NumberOfUnits{ get; set; }

			[Required]
			public double Price{ get; set; }

			public DateTime? PriceDate{ get; set; }

			[Required]
			public double BudgetFixed{ get; set; }

			public Guid? idParContingencyRate{ get; set; }

			[Required]
			public bool FlagAccountOpening{ get; set; }

		}

		[Table("tPlanElementHR")]
		public partial class tPlanElementHR : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idPlanInstance{ get; set; }

			public Guid? idInflationRule{ get; set; }

			[Required]
			public Guid idTariff{ get; set; }

			[Required]
			public Guid idExpenseGroup{ get; set; }

			[StringLength(50)]
			public string StaffName{ get; set; }

			[StringLength(50)]
			public string Department{ get; set; }

		}

		[Table("tPlanTransaction")]
		public partial class tPlanTransaction : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idPlan{ get; set; }

			[Required]
			public Guid idBookTransaction{ get; set; }

		}

		[Table("tBookRecord")]
		public partial class tBookRecord : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idClient{ get; set; }

			[Required]
			public bool FlagOutdated{ get; set; }

			public DateTime? DateOutdated{ get; set; }

			[Required]
			public short TypeBookRecord{ get; set; }

			[Required]
			public bool FlagAccountOpening{ get; set; }

			[Required]
			public Guid idAccountDebit{ get; set; }

			[Required]
			public Guid idAccountCredit{ get; set; }

			public Guid? idCostCenterBookRecord{ get; set; }

			public Guid? idBookingRun{ get; set; }

			[StringLength(30)]
			public string BookingRunCode{ get; set; }

			public int? BookingSequenceNum{ get; set; }

			[Required]
			public int AccountCodeDebit{ get; set; }

			[Required]
			public int AccountCodeCredit{ get; set; }

			[Required]
			public short DATEVBUCode{ get; set; }

			public Guid? idPlanElementInstance{ get; set; }

			[StringLength(255)]
			public string TitleBookRecord{ get; set; }

			[Required]
			public DateTime BookingDate{ get; set; }

			[Required]
			public double Amount{ get; set; }

			[StringLength(50)]
			public string BookingDocument{ get; set; }

			[StringLength(15)]
			public string ReferenceIDBookRecord{ get; set; }

			public string BookRecordComment{ get; set; }

			public int? BCTransactionNo{ get; set; }

			public DateTime? BCDateUpdated{ get; set; }

			public DateTime? BCDateCreated{ get; set; }

			public int? TransactionMainAccountCode{ get; set; }

			[StringLength(30)]
			public string BCDocumentNo{ get; set; }

			[StringLength(30)]
			public string BCDocumentType{ get; set; }

		}

		[Table("tBookTransaction")]
		public partial class tBookTransaction : IDataObject
		{
			[Key]
			public Guid Id { get; set; }

			public Guid? IdMigrate { get; set; }

			public DateTime DateCreated { get; set; }

			public DateTime? DateUpdated { get; set; }

			[Required]
			public Guid idBookingRecord{ get; set; }

			[Required]
			public Guid idClient{ get; set; }

			public Guid? idPlan{ get; set; }

			public Guid? idPlanElement{ get; set; }

			[Required]
			public Guid idAccountReport{ get; set; }

			[Required]
			public Guid idAccountBooking{ get; set; }

			public Guid? idCostCenter{ get; set; }

			public int? AccountCodeReport{ get; set; }

			[StringLength(12)]
			public string CostCenterCode{ get; set; }

			public short? TypeBookRecord{ get; set; }

			[Required]
			public bool FlagAccountOpening{ get; set; }

			public DateTime? BookingDate{ get; set; }

			[Required]
			public int MonthIndex{ get; set; }

			[Required]
			public double AmountDebit{ get; set; }

			[Required]
			public double AmountCredit{ get; set; }

			public string ReviewComment{ get; set; }

			[Required]
			public short FlagForecast{ get; set; }

			[StringLength(15)]
			public string ReferenceIDBookTransaction{ get; set; }

			[Required]
			public short FlagBaseline{ get; set; }

			public int? BCTransactionNo{ get; set; }

			public int? BCGeneralLedgerPageAPIEntryNo{ get; set; }

			[StringLength(250)]
			public string ExternalDocumentNo{ get; set; }

			[StringLength(250)]
			public string Description{ get; set; }

		}

}
