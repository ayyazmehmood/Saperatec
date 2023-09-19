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
    using System.ComponentModel;

    public partial interface ICurrency
    {

    }

    /// <summary>
    /// Specifies currencies and enables the conversion of foreign currency into the client base currency
    /// </summary>    
    public partial class Currency : BusinessObject<tCurrency>, ICurrency
    {
        public static double ApplyCurrency( double amount, DateTime date, Guid idPlan, Guid? idCurrency)
        {
            Currency currency;

            if (idCurrency.HasValue)
            {
                currency = new Currency();
                currency.Id = idCurrency.Value;
            }
            else
                return 1;

            // if currency id exists (else no currency selected => base currency)
            if (currency.Bound)
            {
                return (amount * currency.ExchangeRate(idPlan, date));
            }
            else
                return amount;

        }

        public double ExchangeRate( Guid idPlan, DateTime TransactionDate)
        {
            // try to select via plan
            var query = _db.tCurrencyExchangeRate.
                Where(b => (b.idCurrencyExchangeRate == Id && b.idPlan == idPlan && b.DateExchangeRate <= TransactionDate)).
                OrderByDescending(b => b.DateExchangeRate).Take(1);

            if (query.Count() > 0)  return query.FirstOrDefault().RatePerClientCurrency;
            else
            {
                // try to select via client instead
                query = _db.tCurrencyExchangeRate.
                    Where(b => (b.idCurrencyExchangeRate == Id && b.idClient == VerumInstance.IdClient && b.DateExchangeRate <= TransactionDate)).
                    OrderByDescending(b => b.DateExchangeRate).Take(1);

                if (query.Count() >0) return query.FirstOrDefault().RatePerClientCurrency;
                else throw new Exception(Properties.Errors.CurrencyExchangeRateNotAvailable);
            }
        }

        public bool SelectViaKey(string code)
        {
            var attr = (StringLengthAttribute)typeof(tCurrency).GetProperty("CurrencyCode").GetCustomAttributes(typeof(StringLengthAttribute), true).FirstOrDefault();

            if (attr != null)
            {
                var len = attr.MaximumLength;

                if (code.Length > len)
                    code = code.Substring(0, attr.MaximumLength);
            }

            var obj = VerumInstance.Context.tCurrency.Where(b => b.CurrencyCode == code);

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
    }
}
