#Question 01

awk 'BEGIN{OFS = ",\t"} NR > 1 { if(NR==3 || NR==4) 
                printf("%s - %s,\t %s\n", $2,$3,$1);
                 else 
                 print($2,$1)}' ../Log_Files/hosts.real | sed '1i\#Host Name              IP Address'