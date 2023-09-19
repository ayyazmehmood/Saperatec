USE [VerumDBDev]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanHRExpense_tPlanHRExpenseGroup]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanHRExpense_tPlanHRExpenseGroup] ON [dbo].[tPlanHRExpense] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanHRExpenseGroup] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanHRExpenseGroup] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[idExpenseGroup] = p.[Id]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanHRExpenseGroup_tPlanElementHR]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanHRExpenseGroup_tPlanElementHR] ON [dbo].[tPlanHRExpenseGroup] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementHR] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementHR] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idExpenseGroup]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanHRTariff_tPlanElementHR]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanHRTariff_tPlanElementHR] ON [dbo].[tPlanHRTariff] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementHR] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementHR] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idTariff]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanHRTariffDetail_tPlanHRTariff]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanHRTariffDetail_tPlanHRTariff] ON [dbo].[tPlanHRTariffDetail] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanHRTariff] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanHRTariff] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[idTariff] = p.[Id]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanInflationRule_tPlanElementHR]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanInflationRule_tPlanElementHR] ON [dbo].[tPlanInflationRule] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementHR] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementHR] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idInflationRule]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementHR_tPlanElementInstance]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementHR_tPlanElementInstance] ON [dbo].[tPlanElementHR] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementInstance] 
SET [FlagUpdate] = 1 FROM [dbo].[tPlanElementInstance] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[idPlanInstance] = p.[Id]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementContract_tPlanElementInstance]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementContract_tPlanElementInstance] ON [dbo].[tPlanElementContract] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementInstance] 
SET [FlagUpdate] = 1 FROM [dbo].[tPlanElementInstance] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[idPlanInstance] = p.[Id]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementBooking_tPlanElementInstance]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementBooking_tPlanElementInstance] ON [dbo].[tPlanElementBooking] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementInstance] 
SET [FlagUpdate] = 1 FROM [dbo].[tPlanElementInstance] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[idPlanInstance] = p.[Id]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanParameter_tPlanElementInstance]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanParameter_tPlanElementInstance] ON [dbo].[tPlanParameter] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementInstance] 
SET [FlagUpdate] = 1 FROM [dbo].[tPlanElementInstance] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idParTriggerDueDate]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElement_tPlanElementInstance]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElement_tPlanElementInstance] ON [dbo].[tPlanElement] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementInstance] 
SET [FlagUpdate] = 1 FROM [dbo].[tPlanElementInstance] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idPlanElement]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElement_tCurrency]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElement_tCurrency] ON [dbo].[tCurrency] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElement] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElement] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idCurrency]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElement_tCostCenter]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElement_tCostCenter] ON [dbo].[tCostCenter] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElement] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElement] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idCostCenterPlanElement]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElement_tPlanGroup]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElement_tPlanGroup] ON [dbo].[tPlanGroup] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElement] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElement] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idPlanGroup]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlan_tPlanElementInstance]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlan_tPlanElementInstance] ON [dbo].[tPlan] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementInstance] 
SET [FlagUpdate] = 1 FROM [dbo].[tPlanElementInstance] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idPlan]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementBooking_tAccountDebit]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementBooking_tAccountDebit] ON [dbo].[tAccount] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementBooking] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementBooking] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idAccountDebit]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementBooking_tAccountCredit]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementBooking_tAccountCredit] ON [dbo].[tAccount] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementBooking] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementBooking] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idAccountCredit]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementBooking_tPlanAllocationSchedule]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementBooking_tPlanAllocationSchedule] ON [dbo].[tPlanAllocationSchedule] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementBooking] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementBooking] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idAllocationSchedule]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementBooking_tPlanInflationRule]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementBooking_tPlanInflationRule] ON [dbo].[tPlanInflationRule] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementBooking] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementBooking] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idAllocationSchedule]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementBooking_tPlanParameterPrice1]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementBooking_tPlanParameterPrice1] ON [dbo].[tPlanParameter] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementBooking] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementBooking] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idParPrice1]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementBooking_tPlanParameterPrice2]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementBooking_tPlanParameterPrice2] ON [dbo].[tPlanParameter] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementBooking] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementBooking] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idParPrice2]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementBooking_tPlanParameterContingency]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementBooking_tPlanParameterContingency] ON [dbo].[tPlanParameter] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementBooking] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementBooking] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idParContingencyRate]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementContract_tAccountMain]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementContract_tAccountMain] ON [dbo].[tAccount] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementContract] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementContract] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idAccountMain]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementContract_tAccountAdvance]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementContract_tAccountAdvance] ON [dbo].[tAccount] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementContract] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementContract] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idAccountAdvance]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementContract_tPlanAllocationSchedule]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementContract_tPlanAllocationSchedule] ON [dbo].[tPlanAllocationSchedule] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementContract] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementContract] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idAllocationSchedule]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementContract_tPlanParameterContingency]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementContract_tPlanParameterContingency] ON [dbo].[tPlanParameter] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementContract] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementContract] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idParContingencyRate]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementContract_tPlanParameterPrice1]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementContract_tPlanParameterPrice1] ON [dbo].[tPlanParameter] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementContract] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementContract] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idParPrice1]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementContract_tPlanParameterPrice2]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementContract_tPlanParameterPrice2] ON [dbo].[tPlanParameter] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementContract] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementContract] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idParPrice2]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementContract_tPlanParameterTriggerAdvance]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementContract_tPlanParameterTriggerAdvance] ON [dbo].[tPlanParameter] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementContract] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementContract] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idParTriggerAdvance]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementContract_tPlanParameterTriggerDepreciation]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementContract_tPlanParameterTriggerDepreciation] ON [dbo].[tPlanParameter] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementContract] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementContract] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idDepreciationTrigger]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementContract_tDepreciationRule]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementContract_tDepreciationRule] ON [dbo].[tDepreciationRule] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementContract] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementContract] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idDepreciationRule]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementContract_tVATRule]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementContract_tVATRule] ON [dbo].[tVATRule] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementContract] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementContract] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idVATRule]) END
GO

DROP TRIGGER [dbo].[TR_UPD_tPlanElementContract_tInflationRule]
GO

CREATE TRIGGER [dbo].[TR_UPD_tPlanElementContract_tInflationRule] ON [dbo].[tPlanInflationRule] AFTER UPDATE 
AS BEGIN UPDATE [dbo].[tPlanElementContract] 
SET [DateUpdated] = SYSUTCDATETIME() FROM [dbo].[tPlanElementContract] p WHERE EXISTS(SELECT * FROM deleted d WHERE d.[Id] = p.[idInflationRule]) END
GO