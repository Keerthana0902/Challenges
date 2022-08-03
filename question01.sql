
SELECT `<ticker>` as Tickers, ROUND( ( (`<close>` - `<open>`) / `<open>`)*100,2) as Top_5_Gain_percent
from sample_dataset1
order by Top_5_Gain_percent desc limit 5 ;
