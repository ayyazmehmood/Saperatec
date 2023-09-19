ALTER TABLE [dbo].[tPlanGroup] ADD CONSTRAINT [FK_tPlanGroup_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

