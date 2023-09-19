ALTER TABLE [dbo].[tBookingRun] ADD CONSTRAINT [FK_tBookingRun_idClient]
FOREIGN Key([idClient])
REFERENCES [dbo].[tClient] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

