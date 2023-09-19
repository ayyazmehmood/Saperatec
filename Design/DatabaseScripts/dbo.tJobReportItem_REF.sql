ALTER TABLE [dbo].[tJobReportItem] ADD CONSTRAINT [FK_tJobReportItem_idJobReport]
FOREIGN Key([idJobReport])
REFERENCES [dbo].[tJobReport] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

