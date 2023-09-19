/****** Object:  Trigger [dbo].[TR_UPD_tBookTransaction_tBookRecord]    Script Date: 25.02.2021 18:06:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- ==============================================
-- Create dml trigger template Azure SQL Database 
-- ==============================================
-- Drop the dml trigger if it already exists
CREATE TRIGGER [dbo].[TR_UPD_tBookTransaction_tBookRecord] ON [dbo].[tBookTransaction] AFTER UPDATE 
AS BEGIN 
SET NOCOUNT ON;

IF UPDATE(TypeBookRecord)
    UPDATE [dbo].[tBookRecord]
    SET    TypeBookRecord = inserted.TypeBookRecord
    FROM   inserted
    WHERE [dbo].[tBookRecord].Id = inserted.idBookingRecord

 END

GO

ALTER TABLE [dbo].[tBookTransaction] ENABLE TRIGGER [TR_UPD_tBookTransaction_tBookRecord]
GO

