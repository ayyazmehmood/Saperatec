// CAUTION - This file is auto-generated from the data dictionary. Do not change manually!

namespace VerumBusinessObjects
{
	using System;
	using System.Data.Entity;
	using System.ComponentModel.DataAnnotations.Schema;
	using System.Linq;
	using System.Dynamic;

	partial class VerumDBContext : DbContext
	{
		public virtual DbSet<tCurrency> tCurrency { get; set; }

		public virtual DbSet<tClient> tClient { get; set; }

		public virtual DbSet<tTypeGroupDef> tTypeGroupDef { get; set; }

		public virtual DbSet<tTypeCodeDef> tTypeCodeDef { get; set; }

		public virtual DbSet<tUser> tUser { get; set; }

		public virtual DbSet<tSession> tSession { get; set; }

		public virtual DbSet<tJobReport> tJobReport { get; set; }

		public virtual DbSet<tJobReportItem> tJobReportItem { get; set; }

		public virtual DbSet<tAccountSection> tAccountSection { get; set; }

		public virtual DbSet<tAccountMainGroup> tAccountMainGroup { get; set; }

		public virtual DbSet<tAccountGroup> tAccountGroup { get; set; }

		public virtual DbSet<tAccount> tAccount { get; set; }

		public virtual DbSet<tPlanAccountFunction> tPlanAccountFunction { get; set; }

		public virtual DbSet<tCostCenter> tCostCenter { get; set; }

		public virtual DbSet<tDepreciationRule> tDepreciationRule { get; set; }

		public virtual DbSet<tVATRule> tVATRule { get; set; }

		public virtual DbSet<tReferenceGroup> tReferenceGroup { get; set; }

		public virtual DbSet<tReferenceCode> tReferenceCode { get; set; }

		public virtual DbSet<tBookingRun> tBookingRun { get; set; }

		public virtual DbSet<tPlan> tPlan { get; set; }

		public virtual DbSet<tPlanGroup> tPlanGroup { get; set; }

		public virtual DbSet<tPlanElement> tPlanElement { get; set; }

		public virtual DbSet<tPlanInflationRule> tPlanInflationRule { get; set; }

		public virtual DbSet<tCurrencyExchangeRate> tCurrencyExchangeRate { get; set; }

		public virtual DbSet<tPlanParameter> tPlanParameter { get; set; }

		public virtual DbSet<tPlanAllocationSchedule> tPlanAllocationSchedule { get; set; }

		public virtual DbSet<tPlanAllocationScheduleItems> tPlanAllocationScheduleItems { get; set; }

		public virtual DbSet<tPlanHRTariff> tPlanHRTariff { get; set; }

		public virtual DbSet<tPlanHRTariffDetail> tPlanHRTariffDetail { get; set; }

		public virtual DbSet<tPlanHRExpenseGroup> tPlanHRExpenseGroup { get; set; }

		public virtual DbSet<tPlanHRExpense> tPlanHRExpense { get; set; }

		public virtual DbSet<tPlanElementInstance> tPlanElementInstance { get; set; }

		public virtual DbSet<tPlanElementContract> tPlanElementContract { get; set; }

		public virtual DbSet<tPlanElementBooking> tPlanElementBooking { get; set; }

		public virtual DbSet<tPlanElementHR> tPlanElementHR { get; set; }

		public virtual DbSet<tPlanTransaction> tPlanTransaction { get; set; }

		public virtual DbSet<tBookRecord> tBookRecord { get; set; }

		public virtual DbSet<tBookTransaction> tBookTransaction { get; set; }


		protected override void OnModelCreating(DbModelBuilder modelBuilder)
		{
		}
	}
}
