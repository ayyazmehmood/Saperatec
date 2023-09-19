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

    /// <summary>
    /// Business Object <c>CurrencyExchangeRate</c>: Exchange rates by date, currency and optionally by plan. All exchange rates in relation to client base currency
    /// </summary>    
    public partial class CurrencyExchangeRate : BusinessObject<tCurrencyExchangeRate>, ICurrencyExchangeRate
    {

        public bool SelectViaKey(Guid idCurrency, DateTime date, Guid? idPlan = null)
        {
            IQueryable<tCurrencyExchangeRate> obj;

            // only search via date and disregard time component
            date = date.Date;

            if (idPlan.HasValue)
                obj = VerumInstance.Context.tCurrencyExchangeRate.Where(b =>        b.idClient == VerumInstance.IdClient &&
                                                                                    b.idCurrencyExchangeRate == idCurrency &&
                                                                                    b.DateExchangeRate == date &&
                                                                                    b.idPlan == idPlan);
            else
                obj = VerumInstance.Context.tCurrencyExchangeRate.Where(b =>        b.idClient == VerumInstance.IdClient &&
                                                                                    b.idCurrencyExchangeRate == idCurrency &&
                                                                                    b.DateExchangeRate == date);


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

        public override void _CustomInit()
        {
            if (!Bound)
                idClient = VerumInstance.IdClient;
        }

    }
}
