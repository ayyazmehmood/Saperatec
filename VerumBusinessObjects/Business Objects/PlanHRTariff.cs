namespace VerumBusinessObjects
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;
    using System.Dynamic;
    using System.Diagnostics;
    using System.Data.Entity.Validation;
    using System.Collections.Generic;
    using System.Collections;
    using VerumBusinessObjects.Framework;
    using System.ComponentModel.DataAnnotations;
    using System.Security.Cryptography.Xml;
    using System.Collections.ObjectModel;

    public partial interface IPlanHRTariff
    {

    }

    public partial class PlanHRTariff : BusinessObject<tPlanHRTariff>, IPlanHRTariff
    {
        public double AdjustedSalary(DateTime date)
        {
            PlanHRTariffDetail detail = new PlanHRTariffDetail();
            Guid id = Guid.Empty;
            IOrderedQueryable<tPlanHRTariffDetail> query;

            if (Bound)
            {
                // get all detail records for tariff if not loaded before (for efficiency)
                if (_Details == null)
                {
                    query = VerumInstance.Context.tPlanHRTariffDetail.Where(b => b.idTariff == Id).OrderBy(b => b.DateValidTo);
                    if (query.Count() == 0) throw new BOException("Implementation of HR plan for tariff without details. Inconsistent database");
                    else
                        _Details = query.ToList();
                }

                // iterate through detail records for detail which is valid at date
                foreach (var item in _Details)
                    if (item.DateValidTo >= date)
                    {
                        id = item.Id;
                        break;
                    }

                // if none of the details had valid to date > date: take detail with null date or highest valid to date
                if (id == Guid.Empty)
                    if (_Details.First().DateValidTo == null) detail.Id = _Details.First().Id;
                    else
                        detail.Id = _Details.LastOrDefault().Id;
                else
                    detail.Id = id;

                return (detail.BaseSalaryMonthly * detail.FTEFactor * (1 + (detail.RateShiftNight * detail.RatioShiftNight + detail.RateShiftSpecial * detail.RatioShiftSpecial 
                                + (1 + detail.RateOvertime) * detail.RatioOvertime)));
            }
            else
                return 0;
        }

        public double Bonus(DateTime date)
        {
            PlanHRTariffDetail detail = new PlanHRTariffDetail();
            Guid id = Guid.Empty;
            IOrderedQueryable<tPlanHRTariffDetail> query;

            if (Bound)
            {
                // get all detail records for tariff if not loaded before (for efficiency)
                if (_Details == null)
                {
                    query = VerumInstance.Context.tPlanHRTariffDetail.Where(b => b.idTariff == Id).OrderBy(b => b.DateValidTo);
                    if (query.Count() == 0) throw new BOException("Implementation of HR plan for tariff without details. Inconsistent database");
                    else
                        _Details = query.ToList();
                }

                // iterate through detail records for detail which is valid at date
                foreach (var item in _Details)
                    if (item.DateValidTo >= date)
                    {
                        id = item.Id;
                        break;
                    }

                // if none of the details had valid to date > date: take detail with null date or highest valid to date
                if (id == Guid.Empty)
                    if (_Details.First().DateValidTo == null) detail.Id = _Details.First().Id;
                    else detail.Id = _Details.Last().Id;
                else
                    detail.Id = id;

                if (detail.AnnualBonusMonth == date.Month)
                    return detail.BaseSalaryMonthly * detail.RateAnnualBonus.GetValueOrDefault() * detail.FTEFactor;
                else
                    return 0;
            }
            else
                return 0;

        }

        public bool SelectViaKey(string title, Guid idPlan)
        {
            var attr = (StringLengthAttribute)typeof(tPlanHRTariff).GetProperty("TitleTariff").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();
            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (title.Length > len)
                    title = title.Substring(0, attr.MaximumLength);
            }

            var obj = VerumInstance.Context.tPlanHRTariff.Where(b => b.TitleTariff == title && b.idPlan == idPlan);

            if (obj.Count() == 0)
            {
                return false;
            }
            else
            {
                Id = obj.FirstOrDefault().Id;
                return true;
            }
        }

        public BOCollection<PlanHRTariffDetail, tPlanHRTariffDetail> PlanHRTariffDetailChildren()
        {
            // select all detail instances for the tariff
            var query = _db.tPlanHRTariffDetail.Where<tPlanHRTariffDetail>(b => b.idTariff == Id).OrderBy(b => b.DateValidTo);
            return new BOCollection<PlanHRTariffDetail, tPlanHRTariffDetail>(query);
        }

        public static BOCollection<PlanHRTariff, tPlanHRTariff> GetBOCollection(Guid idPlan)
        {
            // select all allocation schedules for a plan
            var query = VerumInstance.Context.tPlanHRTariff.Where<tPlanHRTariff>(b => b.idPlan == idPlan).OrderBy(b => b.TitleTariff);
            return new BOCollection<PlanHRTariff, tPlanHRTariff>(query);
        }

        /// <summary>
        /// Returns observable collection of all HR Tariff Details
        /// Collection can be used for dynamic display of items in WPF GUI
        /// </summary>
        /// <returns></returns>
        public ObservableCollection<tPlanHRTariffDetail> GetTariffDetails()
        {
            if (Bound)
            {
                var query = VerumInstance.Context.tPlanHRTariffDetail.Where<tPlanHRTariffDetail>(b => b.idTariff == Id).OrderBy(b => b.DateValidTo);
                return new ObservableCollection<tPlanHRTariffDetail>(query);
            }
            else
                return null;
        }

        public BOResult Validate()
        {

            if (AccountSalaryParent == null ||
                PlanParent == null)
                //||                 VerumInstance.Context.tPlanHRTariff.Where<tPlanHRTariff>(b => b.idPlan == idPlan && b.Id != Id).Count() > 0)
                return BOResult.PlanHRTariffNotValid;
            else
                return BOResult.Success;
        }

        public BOResult Delete()
        {
            try
            {
                // check whether tariff is still referenced in plan element
                var cnt = _db.tPlanElementHR.Count(b => b.idTariff == Id);

                if (cnt > 0)
                    return BOResult.PlanHRTariffNotDeleted;


                _db.Database.ExecuteSqlCommand($"DELETE FROM [dbo].[tPlanHRTariffDetail] WHERE idTariff=Cast('{Id}' as uniqueidentifier)");
                VerumInstance.SaveChanges(true);
                _db.Database.ExecuteSqlCommand($"DELETE FROM [dbo].[tPlanHRTariff] WHERE Id=Cast('{Id}' as uniqueidentifier)");
                VerumInstance.SaveChanges(true);

                return BOResult.Success;
            }
            catch (Exception ex)
            {
                BOUtilities.TraceErrors(ex);
                return BOResult.GeneralError;
            }
        }

        public PlanHRTariff GetCopy(Plan targetPlan)
        {
            PlanHRTariff target;

            if (Bound)
            {
                try
                {
                    //VerumInstance.TransactionStart();

                    // seek schedule if already migrated to targetPlan
                    var query = VerumInstance.Context.tPlanHRTariff.SingleOrDefault<tPlanHRTariff>(b => b.idPlan == targetPlan.Id && b.IdMigrate == this.Id);

                    if (query == null)
                    {
                        target = new PlanHRTariff();
                        target.Clone(this);
                        target.idPlan = targetPlan.Id;
                        target.CommitChanges();

                        foreach (PlanHRTariffDetail item in PlanHRTariffDetailChildren())
                            if (item.Copy(target) != BOResult.Success) throw new InvalidOperationException("Error during plan HR tariff detail copy");
                    }
                    else
                        target = new PlanHRTariff(query.Id);

                    VerumInstance.SaveChanges();

                    return target;
                }
                catch (Exception ex)
                {
                    BOUtilities.TraceErrors(ex);
                    //VerumInstance.TransactionRollback();
                }
            }

            return null;
        }


        // PRIVATE FIELDS
        List<tPlanHRTariffDetail> _Details;

        // PRIVATE METHODS
        public override void _CustomInit()
        {
            _Details = null; ;
        }
    }
}
