ALTER TABLE [dbo].[tCostCenter] ADD CONSTRAINT [FK_tCostCenter_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

