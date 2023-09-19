-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Func_DistinctElementScenario
	-- Add the parameters for the stored procedure here
	@p0 varchar(36) = '1d99f173-ff69-4022-ab56-0a3500bbf97c',
	@p1 varchar(36) = 'a791b9a4-5a73-4217-9daa-56359b2ca54b'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT ID
FROM (
	SELECT [idElement.Definition], ID,
		ROW_NUMBER() over (partition by [idElement.Definition] order by Prio asc) as RowNum
	FROM
	(
		SELECT [idElement.Definition], ID, 0 As Prio
		FROM dbo.[Element.Scenario]
		WHERE idScenario = CAST(@p0 as uniqueidentifier)
		UNION
		SELECT [idElement.Definition], ID, 1 as Prio
		FROM dbo.[Element.Scenario]
		WHERE idScenario = CAST(@p1 as uniqueidentifier)
	)
	AS Temp1
)
As Temp2
WHERE RowNum=1;

END
GO
