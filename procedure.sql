-- CREATE DATABASE challenges;
-- use Challenges;

DELIMITER //
CREATE PROCEDURE show_symbols(
	IN symboltext varchar(5)
)
BEGIN
	declare counter integer;
    set @counter = 0;
    
	SELECT (@counter := @counter + 1) AS Count, `<ticker>` AS Ticker FROM  Sample_dataset1
    WHERE `<ticker>` LIKE symboltext;
END //
DELIMITER ;

 -- drop procedure show_symbols;


