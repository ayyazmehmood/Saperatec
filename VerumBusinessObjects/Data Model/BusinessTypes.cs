using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics.PerformanceData;
using System.Linq;
using System.Linq.Expressions;
using System.Runtime.InteropServices.ComTypes;
using System.Text;
using System.Threading.Tasks;

namespace VerumBusinessObjects
{
    public enum TypeAccountEnum : short
    {
        P_L = 0,
        Assets = 1,
        Liabilities = 2,
        Other = 3
    }

    public enum TypeDepreciationRuleEnum : short
    {
        Linear = 0
    }

    public enum TypePlanElementEnum : short
    {
        BookingRule = 0,
        Purchase = 1,
        Personnel = 2,
        Sale = 3,
        Loan = 4
    }

    public enum TypeRepeatEnum : short
    {
        Schedule = -1,
        NoRepeat = 0,
        Monthly = 1,
        Quarterly = 3,
        Annually = 12
    }

    public enum TypeBookRecordEnum : short
    {
        Actual = 0,
        Budget = 1,
        Plan = 2,
        New = 3,
        Historical = 9,
        Obsolete = -1
    }

    public enum TypePlanParameterEnum : short
    {
        PriceFactor = 0,
        TriggerDate = 10,
        ContingencyRate = 20
    }

    public enum TypeAccountFunctionEnum : short
    {
        Cash = 1,
        CashDefault = 2,
        Payables = 3,
        PayablesDefault = 4,
        AdvanceReceived = 5,
        AdvanceReceivedDefault = 6,
        Receivables = 7,
        ReceivablesDefault = 8,
        AdvancePaid = 9,
        AdvancePaidDefault = 10,
        SalaryDefault = 11
    }

    public enum TypeUserEnum : short
    {
        NoUser = -1,
        Standard = 0,
        Admin = 1
    }

    public enum TypeRegularPeriods : short
    {
        Monthly = 1,
        Quarterly = 3,
        Semiannually = 6,
        Annually = 12
    }

    public enum TypeBonusExpenseModeEnum : short
    {
        Distribute = 0,
        Add = 1,
        Exclude = 2
    }

    public enum TypeJobEnum : short
    {
        JournalImport = 1,
        PlanImport = 2,
        PlanImplement = 3,
        BusinessCenterImport = 4 // raju added

    }

    public enum TypeJobSuccessEnum : short
    {
        Success = 1,
        Error = 2,
        Warning = 3
    }

    public enum TypePlanStatusEnum : short 
    {
        Actual = 0,
        Baseline = 1,
        Plan = 2,
        New = 3,
        Forecast = 4,
        Historical = 9,
        Obsolete = -1
    }

}
