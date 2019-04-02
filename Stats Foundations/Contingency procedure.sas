data simple;
input opinion $ gender $ count;
datalines;
yes female 55
yes male 50
no female 65
no male 80
;

proc freq data=simple;
tables opinion*gender / chisq nocol norow nopercent expected;
weight count;
run;

data simple2;
infile "H:\sas\data\opinion.csv" dlm=',' firstobs=2;
input  opinion $ gender $;
run;

proc freq data=simple2;
tables opinion*gender / chisq nocol norow nopercent expected;
run;	
