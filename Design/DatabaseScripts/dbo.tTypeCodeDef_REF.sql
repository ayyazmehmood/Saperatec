ALTER TABLE [dbo].[tTypeCodeDef] ADD CONSTRAINT [FK_tTypeCodeDef_idTypeGroupDef]
FOREIGN Key([idTypeGroupDef])
REFERENCES [dbo].[tTypeGroupDef] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

