using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VerumBusinessObjects.Framework;

namespace VerumBusinessObjects
{
    public interface IPlanItem
    {
        void ImplementPlanItem();
        TypePlanElementEnum ItemType { get;  }
        double Budget { get ; }

        BOResult Delete();

        BOResult Copy(Plan targetPlan, PlanElementInstance targetInstance);

    }

    public class TxScheduleItem
    {
        DateTime _Date;
        public DateTime Date { get => _Date; set => _Date = value; }

        double _Amount;
        public double Amount { get => _Amount; set => _Amount = value; }

        public TxScheduleItem( DateTime date, double amount)
        {
            Date = date;
            Amount = amount;
        }
    }

}
