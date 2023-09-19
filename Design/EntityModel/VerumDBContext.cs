namespace VerumBusinessObjects
{
	using System;
	using System.Data.Entity;
	using System.ComponentModel.DataAnnotations.Schema;
	using System.Linq;
	using System.Dynamic;

	partial class VerumDBContext : DbContext
	{
		public VerumDBContext()
			: base("Data Source = SUSTEEN12\\SQLEXPRESS; Initial Catalog = VerumDBDev; Integrated Security = True")
		{
		}

		public virtual DbSet<vPlan> vPlan { get; set; }

		public virtual DbSet<vPlanElement> vPlanElement { get; set; }

		public virtual DbSet<vPlanElementInstance> vPlanElementInstance { get; set; }

		public virtual DbSet<vPlanTransaction> vPlanTransaction { get; set; }

		public virtual DbSet<vPlanContract> vPlanContract { get; set; }

		public virtual DbSet<vBookRecord> vBookRecord { get; set; }


		protected override void OnModelCreating(DbModelBuilder modelBuilder)
		{
		}
	}
}
