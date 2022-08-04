#Question 02

grep -B1 -A49 '[A-Za-z]*:   Type: Trade' ../Log_files/opra_example_regression.log | 
    grep -v '[-][-]' | sed 's/Regression: '//| 
    grep 'Record Publish:\|Type:\|  wTradeVolume \|  wTradePrice' > Output_files/TradePriceVolume.tab

cat Output_files/TradePriceVolume.tab

echo -e "----\n\nQUESTION 02 - 2nd PART(CSV FILE)\n\n----"
#Creation of csv file
#Transform contents to a csv file
cat Output_files/TradePriceVolume.tab > Output_files/SymPriceQuan.csv

#We need only the values so remove other attributes one by one for clarity
sed -i 's/Record Publish: //;s/  Type: Trade//' Output_files/SymPriceQuan.csv
sed -i 's/  wTradePrice | price | * //' Output_files/SymPriceQuan.csv
sed -i 's/  wTradeVolume | quantity | * //' Output_files/SymPriceQuan.csv
sed -i 's/* | //' Output_files/SymPriceQuan.csv

#remove empty lines
sed -i '/^[[:space:]]*$/d' Output_files/SymPriceQuan.csv

#Make the values comma separated and save the output in a new file
awk 'BEGIN{OFS=","} {printf "%s%s", $0, (NR%3?OFS:ORS) }' Output_files/SymPriceQuan.csv | 
sed '1i\Symbol,Price,Quantity' > Output_files/SymPriceQuantity.csv

#final result
cat Output_files/SymPriceQuantity.csv