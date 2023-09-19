ALTER TABLE tCurrency
DROP COLUMN IdMigrate;
ALTER TABLE tCurrency
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tClient
DROP COLUMN IdMigrate;
ALTER TABLE tClient
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tTypeGroupDef
DROP COLUMN IdMigrate;
ALTER TABLE tTypeGroupDef
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tTypeCodeDef
DROP COLUMN IdMigrate;
ALTER TABLE tTypeCodeDef
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tUser
DROP COLUMN IdMigrate;
ALTER TABLE tUser
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tSession
DROP COLUMN IdMigrate;
ALTER TABLE tSession
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tJobReport
DROP COLUMN IdMigrate;
ALTER TABLE tJobReport
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tJobReportItem
DROP COLUMN IdMigrate;
ALTER TABLE tJobReportItem
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tAccountSection
DROP COLUMN IdMigrate;
ALTER TABLE tAccountSection
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tAccountMainGroup
DROP COLUMN IdMigrate;
ALTER TABLE tAccountMainGroup
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tAccountGroup
DROP COLUMN IdMigrate;
ALTER TABLE tAccountGroup
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tAccount
DROP COLUMN IdMigrate;
ALTER TABLE tAccount
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlanAccountFunction
DROP COLUMN IdMigrate;
ALTER TABLE tPlanAccountFunction
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tCostCenter
DROP COLUMN IdMigrate;
ALTER TABLE tCostCenter
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tDepreciationRule
DROP COLUMN IdMigrate;
ALTER TABLE tDepreciationRule
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tVATRule
DROP COLUMN IdMigrate;
ALTER TABLE tVATRule
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tReferenceGroup
DROP COLUMN IdMigrate;
ALTER TABLE tReferenceGroup
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tReferenceCode
DROP COLUMN IdMigrate;
ALTER TABLE tReferenceCode
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tBookingRun
DROP COLUMN IdMigrate;
ALTER TABLE tBookingRun
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlan
DROP COLUMN IdMigrate;
ALTER TABLE tPlan
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlanGroup
DROP COLUMN IdMigrate;
ALTER TABLE tPlanGroup
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlanElement
DROP COLUMN IdMigrate;
ALTER TABLE tPlanElement
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlanInflationRule
DROP COLUMN IdMigrate;
ALTER TABLE tPlanInflationRule
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tCurrencyExchangeRate
DROP COLUMN IdMigrate;
ALTER TABLE tCurrencyExchangeRate
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlanParameter
DROP COLUMN IdMigrate;
ALTER TABLE tPlanParameter
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlanAllocationSchedule
DROP COLUMN IdMigrate;
ALTER TABLE tPlanAllocationSchedule
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlanAllocationScheduleItems
DROP COLUMN IdMigrate;
ALTER TABLE tPlanAllocationScheduleItems
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlanHRTariff
DROP COLUMN IdMigrate;
ALTER TABLE tPlanHRTariff
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlanHRTariffDetail
DROP COLUMN IdMigrate;
ALTER TABLE tPlanHRTariffDetail
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlanHRExpenseGroup
DROP COLUMN IdMigrate;
ALTER TABLE tPlanHRExpenseGroup
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlanHRExpense
DROP COLUMN IdMigrate;
ALTER TABLE tPlanHRExpense
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlanElementInstance
DROP COLUMN IdMigrate;
ALTER TABLE tPlanElementInstance
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlanElementContract
DROP COLUMN IdMigrate;
ALTER TABLE tPlanElementContract
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlanElementBooking
DROP COLUMN IdMigrate;
ALTER TABLE tPlanElementBooking
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlanElementHR
DROP COLUMN IdMigrate;
ALTER TABLE tPlanElementHR
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tPlanTransaction
DROP COLUMN IdMigrate;
ALTER TABLE tPlanTransaction
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tBookRecord
DROP COLUMN IdMigrate;
ALTER TABLE tBookRecord
ADD IdMigrate uniqueidentifier NULL;

ALTER TABLE tBookTransaction
DROP COLUMN IdMigrate;
ALTER TABLE tBookTransaction
ADD IdMigrate uniqueidentifier NULL;

