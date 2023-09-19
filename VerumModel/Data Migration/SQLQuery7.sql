USE [Test]
GO

DECLARE	
	@p0 varchar(36) = '1d99f173-ff69-4022-ab56-0a3500bbf97c',
	@p1 varchar(36) = 'a791b9a4-5a73-4217-9daa-56359b2ca54b'

SELECT * FROM ElementScenarioView
INNER JOIN 
(
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
	AS MyQuery
) AS MyQuery2 ON ElementScenarioView
;

GO

