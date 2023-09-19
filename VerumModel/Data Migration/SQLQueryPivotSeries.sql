DECLARE 
    @columns NVARCHAR(MAX) = '',
	@sql     NVARCHAR(MAX) = '';

SELECT 
    @columns += QUOTENAME(OrderNum) + ','
FROM 
    ElementSeries
GROUP BY OrderNum
ORDER BY OrderNum;

SET @columns = LEFT(@columns, LEN(@columns) - 1);
PRINT @columns;

SET @sql ='

SELECT * FROM 
(
	SELECT s.[idElement]
		  ,s.[OrderNum] 
		  ,s.[Value] 
	  FROM [dbo].[ElementSeries] s
) t
PIVOT (
	SUM([Value])
	FOR [OrderNum] IN (' + @columns + ')
	) as pivot_table;';

PRINT @sql;

-- execute the dynamic SQL
EXECUTE sp_executesql @sql;

