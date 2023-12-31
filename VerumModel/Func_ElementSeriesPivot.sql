USE [Test]
GO
/****** Object:  StoredProcedure [dbo].[Func_ElementSeriesPivot]    Script Date: 04.02.2021 08:03:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Func_ElementSeriesPivot]
	-- Add the parameters for the stored procedure here
	@ParScenario varchar(36) = 'a791b9a4-5a73-4217-9daa-56359b2ca54b',
	@PeriodMax INT = 36
	-- <@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE
		@ScenarioMain uniqueidentifier,
		@ScenarioBase uniqueidentifier,
		@columns NVARCHAR(MAX) = '',
		@sql     NVARCHAR(MAX) = '',
		@cnt INT = 0;

	SET @ScenarioMain = Cast(@ParScenario as uniqueidentifier);
	SET @ScenarioBase = (SELECT idScenarioBase FROM Scenario WHERE ID = @ScenarioMain);

	SELECT ID INTO #ElementQuery
	FROM (
		SELECT [idElementDefinition], ID,
			ROW_NUMBER() over (partition by [idElementDefinition] order by Prio asc) as RowNum
		FROM
		(
			SELECT [idElementDefinition], ID, 0 As Prio
			FROM dbo.[ElementValue]
			WHERE idScenario = CAST(@ScenarioMain as uniqueidentifier)
			UNION
			SELECT [idElementDefinition], ID, 1 as Prio
			FROM dbo.[ElementValue]
			WHERE idScenario = CAST(@ScenarioBase as uniqueidentifier)
		)
		AS t1
	)
	As t2
	WHERE RowNum=1;

	SELECT * INTO #ElementView
	FROM ElementView t1 INNER JOIN #ElementQuery t2 ON t1.[idElementValue] = t2.ID;

	--SELECT 
	--	@columns += QUOTENAME(OrderNum) + ','
	--FROM 
	--	dbo.[ElementSeries] t
	--INNER JOIN #ElementQuery ON #ElementQuery.ID = t.[idElementValue]
	--GROUP BY OrderNum
	--ORDER BY OrderNum;

	SET @cnt = 1;

	WHILE @cnt <= @PeriodMax
	BEGIN
		SET @columns = @columns + '[' + Cast(@cnt as varchar(2)) + '],';
		SET @cnt = @cnt + 1;
	END;

	SET @columns = LEFT(@columns, LEN(@columns) - 1);

	SET @sql ='
		SELECT	
			t4.idElementValue,
			t4.[Ebene 1],
			t4.[Ebene 2],
			t4.[Ebene 3],
			t4.[Ebene 4],
			t4.[Ebene 5],
			t4.[Typ],
			t4.[Einheit],
			t4.[Wert],
			t4.[Anmerkung],
			t4.[Perioden],
			t4.[Perioden Max],
			t4.[Wiederholen],' +
			@columns +'	
	FROM 
	(
		SELECT	t1.[idElementValue], t1.OrderNum, t1.Value
		FROM    dbo.[ElementSeries] t1
		INNER JOIN
                #ElementQuery t2 ON t1.[idElementValue] = t2.ID
	) t0
	PIVOT (
		SUM([Value])
		FOR [OrderNum] IN (' + @columns + ')
		) as t3
		RIGHT OUTER JOIN #ElementView t4 ON t4.[idElementValue] = t3.[idElementValue];';

	--print @sql;

	-- execute the dynamic SQL
	EXECUTE sp_executesql @sql;
	DROP TABLE #ElementQuery;
	DROP TABLE #ElementView;

	END
