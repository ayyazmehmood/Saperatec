using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VerumBusinessObjects.Framework
{
    [Serializable]
    public class BOException : Exception
    {
        public BOResult BOResult { get; }
        public string ResultInfo { get; }

        public BOException() { }

        public BOException(string message)
            : base(message) { }

        public BOException(string message, Exception inner)
            : base(message, inner) { }

        public BOException(string message, BOResult BOResult, string ResultInfo = "")
            : this(message)
        {
            this.BOResult = BOResult;
            this.ResultInfo = ResultInfo;
        }
    }

    public enum BOResult
    {
        Success = 0,

        AccountTypeInvalid = 100,
        AccountMissingFunction = 101,

        AllocationScheduleIntervalInvalid = 400,
        AllocationScheduleTitleNotFound = 401,
        AllocationSchedulePeriodInvalid = 402,
        AllocationScheduleAutoGenInvalidDef = 403,

        BookRecordUnbalancedTransactions = 601,

        CostCenterCannotDelete = 9108,

        DATEVJournalInvalidFile = 9100,
        DATEVJournalEmptyTable = 9101,
        DATEVJournalInvalidHeader = 9102,
        DATEVJournalInvalidTable = 9103,
        DATEVUnbalancedTransactions = 9104,
        DATEVInvalidAccountNumber = 9105,
        DATEVInvalidCostCenter = 9106,
        DATEVClientNumberNotDefined = 9107,

        DepreciationRuleTypeInvalid = 200,

        ExcelImportUnknownDatatype = 9001,
        ExcelInvalidFolderName = 9002,
        ExcelInvalidFileName = 9003,
        ExcelEmptyFolder = 9004,

        GeneralError = 1,
        GeneralWarning = 2,

        InflationIntervalInvalid = 300,

        JobReportingError = 1000,

        PlanElementInvalidItemType = 500,
        PlanElementInstanceWithoutItemRecord = 501,
        PlanElementImplementWithUnboundRecord = 502,
        PlanAppliedCannotDelete = 701,
        PlanApprovedAlready = 702,
        PlanObsolete = 703,
        PlanImportDepreciationError = 8100,
        PlanImportInvalidDepreciationType = 8101,
        PlanImportInvalidActivationAccount = 8102,

        UserLogonSuccess = 10,
        UserLoginInvalid = 11,
        UserLoginPasswordInvalid = 12,
        UserLoginAccessFailed = 13,
        UserNotAuthorized = 14,
        UserCreateFailed = 15,
        PlanElementInstanceExists = 9109,
        PlanElementInstanceExistsNot = 9110,
        PlanAllocationScheduleNotDeleted = 9111,
        PlanHRTariffNotDeleted = 9112,
        PlanElementInstanceNotDeleted = 9113,
        PlanItemCopyError = 9114,
        PlanAllocationScheduleCopyError = 9115,
        PlanHRTariffNotValid = 9116,
        ReferenceCodeCannotDelete = 9117,
        ReferenceGroupCannotDelete = 9118,
        AccountGroupCannotDelete = 9119,
        AccountMainGroupCannotDelete = 9120,
        AccountSectionCannotDelete = 9121,
        AccountCannotDelete = 9122,
        DeleteBookRecordsFailed = 9123,
        BCBookImportRecordNotFound = 9124, // raju
        BCBookImportCompanyNameNotNull = 9125, // raju
        BCLastRunningDateNotFound = 9127, // raju
        BCURLNotFound = 9128, // raju
        BCInvalidAccountNumber = 9129 // raju

    }

}
