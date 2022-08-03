CREATE TEMPORARY TABLE ds2 as
	SELECT DISTINCT DATE as Date, 
    ROUND(ABS(Close - Open), 2) as Diff_Range from sample_dataset3
    ORDER BY Diff_Range DESC limit 3;

DROP TEMPORARY TABLE ds2 ;

SELECT* from ds2;

CREATE TEMPORARY TABLE ds3 as
	SELECT DATE, MAX(High) as maxHigh from sample_dataset3 WHERE
    DATE in (SELECT DATE from ds2)
    GROUP BY DATE;
    
DROP TEMPORARY TABLE ds3 ;
    
SELECT* from ds3;

CREATE TEMPORARY TABLE ds4 as
	SELECT Date, Time from sample_dataset3 JOIN
    ds3 on DATE;