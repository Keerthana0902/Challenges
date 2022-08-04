#Question 03

if  grep "Warning" ..//log_files/WindowsEventLog.csv > Output_files/Warnings.csv 
then
    echo "Warnings.csv has been created --> Check Output_files"
fi

if grep '[eE]rror: ' ..//log_files/WindowsEventLog.csv | 
   grep  ': [eE]rror' ..//log_files/WindowsEventLog.csv > Output_files/Errors.csv
then
    echo "Errors.csv has been created --> Check Output_files"
fi

#Max warnings
echo "Maximum warnings occured at: "
sed 's/,/ /g' Output_files/Warnings.csv | awk '{print $4}' | sort --unique | sed '1i\#Application Name'