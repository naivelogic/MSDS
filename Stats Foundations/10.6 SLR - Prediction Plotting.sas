/** SAS Code for Study Time Data set*/
data exam;
input time score @@;
datalines;
10 92 15 81 12 84 20 74
8 85 16 80 14 84 22 80
;
run;
symbol value = dot color = blue; ** change plotting symbol;

** Scatter plot of Score vs Time;
proc gplot data = exam;
title 'exam score vs study time (hours)';
plot score * time;
run;

proc reg data = exam;
model score = time / R CLM CLB CLI;
run;