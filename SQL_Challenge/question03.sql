DELIMITER //
CREATE PROCEDURE Trading_range ()
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS Date_Range as
		SELECT DISTINCT DATE as Date, 
		ROUND(ABS(Close - Open), 2) as Diff_Range from sample_dataset3
		ORDER BY Diff_Range DESC limit 3;
	 
    CREATE TEMPORARY TABLE IF NOT EXISTS MaxHigh as
		SELECT DATE, MAX(High) as maxHigh from sample_dataset3 WHERE
		DATE in (SELECT DATE from Date_Range)
		GROUP BY DATE;
		
	CREATE TEMPORARY TABLE IF NOT EXISTS DateTimeMax as
		SELECT sample_dataset3.Date, 
        Date_format(str_to_date(sample_dataset3.Time, '%H%i'), '%H:%i') as Max_Time from sample_dataset3 
		JOIN MaxHigh on sample_dataset3.High = MaxHigh.maxHigh AND 
        sample_dataset3.Date = MaxHigh.Date
		GROUP BY MaxHigh.Date;
		
	CREATE TEMPORARY TABLE IF NOT EXISTS Result as
		SELECT Date_Range.Date, Diff_Range, Max_Time 
		from Date_Range 
		JOIN DateTimeMax on DateTimeMax.Date = Date_Range.Date;
	  
	SELECT* FROM Result;
    
	DROP TEMPORARY TABLE MaxHigh ;
	DROP TEMPORARY TABLE DateTimeMax ;
	DROP TEMPORARY TABLE Date_Range ;
    DROP TEMPORARY TABLE Result;
    
END //