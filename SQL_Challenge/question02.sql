CREATE TEMPORARY TABLE date_formatted as
	SELECT `<date>` AS Original,
	str_to_date(`<date>`, '%Y%m%d%H%i') AS real_date,
	Date_format(str_to_date(`<date>`, '%Y%m%d%H%i'), '%d-%m-%Y') AS date_only,
    Date_format(str_to_date(`<date>`, '%Y%m%d%H%i'), '%H:%i') AS time_only,
    `<open>`, `<close>`, `<high>`,`<vol>`, `<low>`,`<ticker>`
	FROM sample_dataset2
	;
DROP TEMPORARY TABLE date_formatted;
-- dd-mm-yyy
-- hh-mm


DELIMITER //
CREATE PROCEDURE Vol_Weighted_Avg(
	IN begin_date varchar(10), IN start_time varchar(8)
 )
 BEGIN
	 set @user_date = begin_date;
     set @start_time = start_time;
     set @end_time = Date_format(str_to_date(date_add(str_to_date(@start_time, '%H:%i'), INTERVAL 5 HOUR), '%T'), '%H:%i');
	SELECT `<ticker>` as Ticker,date_only as start_date, @start_time as start_time, @end_time as end_time, 
								SUM(`<vol>` * `<close>` )  / SUM(`<vol>`) as VWAP
								from date_formatted  where date_only = @user_date  AND
								time_only BetWEEN @start_time
                                AND Date_format(str_to_date(date_add(str_to_date(@start_time, '%H:%i'), INTERVAL 5 HOUR), '%T'), '%H:%i')  
                                 group by `<ticker>`;
END //
DELIMITER ;

 drop procedure Vol_Weighted_Avg;
 
call Vol_Weighted_Avg('11-10-2010','09:00');
