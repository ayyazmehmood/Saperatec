namespace VerumBusinessObjects
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;
    using VerumBusinessObjects.Views;

    public partial class VerumDBContext : DbContext
    {
        public VerumDBContext(string nameOrConnectionString) : base(nameOrConnectionString)
        {
            this.Database.Log = Console.Write;
        }

        public virtual DbSet<vAccountAll> vAccountAll { get; set; }
        public virtual DbSet<vAccountGroup> vAccountGroup { get; set; }
        public virtual DbSet<vAccountPlanning> vAccountPlanning { get; set; }
        public virtual DbSet<vClient> vClient { get; set; }
        public virtual DbSet<vCostCenter> vCostCenter { get; set; }
        public virtual DbSet<vCurrency> vCurrency { get; set; }
        public virtual DbSet<vCurrencyExchangeRate> vCurrencyExchangeRate { get; set; }
        public virtual DbSet<vDepreciationRule> vDepreciationRule { get; set; }
        public virtual DbSet<vJobReport> vJobReport { get; set; }
        public virtual DbSet<vPlan> vPlan { get; set; }
        public virtual DbSet<vPlanAccountFunction> vPlanAccountFunction { get; set; }
        public virtual DbSet<vPlanAllocationSchedule> vPlanAllocationSchedule { get; set; }
        public virtual DbSet<vPlanAllocationScheduleItems> vPlanAllocationScheduleItems { get; set; }
        public virtual DbSet<vPlanElementBooking> vPlanElementBooking { get; set; }
        public virtual DbSet<vPlanElementContract> vPlanElementContract { get; set; }
        public virtual DbSet<vPlanElementHR> vPlanElementHR { get; set; }
        public virtual DbSet<vPlanElementInstances> vPlanElementInstances { get; set; }
        public virtual DbSet<vPlanGroup> vPlanGroup { get; set; }
        public virtual DbSet<vPlanHRExpense> vPlanHRExpense { get; set; }
        public virtual DbSet<vPlanHRExpenseGroup> vPlanHRExpenseGroup { get; set; }
        public virtual DbSet<vPlanHRTariff> vPlanHRTariff { get; set; }
        public virtual DbSet<vPlanHRTariffDetail> vPlanHRTariffDetail { get; set; }
        public virtual DbSet<vPlanInflationRule> vPlanInflationRule { get; set; }
        public virtual DbSet<vPlanParameterContingency> vPlanParameterContingency { get; set; }
        public virtual DbSet<vPlanParameterDate> vPlanParameterDate { get; set; }
        public virtual DbSet<vPlanParameterPriceFactor> vPlanParameterPriceFactor { get; set; }
        public virtual DbSet<vReferenceCode> vReferenceCode { get; set; }
        public virtual DbSet<vReferenceGroup> vReferenceGroup { get; set; }
        public virtual DbSet<vTypeCodeDef> vTypeCodeDef { get; set; }
        public virtual DbSet<vTypeGroupDef> vTypeGroupDef { get; set; }
        public virtual DbSet<vUser> vUser { get; set; }
        public virtual DbSet<vVATRule> vVATRule { get; set; }

    }
}
