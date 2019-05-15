*Power and Design Size
Great paper on GLMPOWER procedure in SAS that covers:
- Sample size Determinatino
- Power for F-tests in ANOVA models (as well as contrasts of interest + replicates)
http://www.math.montana.edu/jobo/st541/sec2g.pdf
;

ODS LISTING;
DM ’LOG;CLEAR;OUT;CLEAR;’;
OPTIONS LS=72 PS=54 NONUMBER NODATE;

**************;
*** Case 1 ***;
**************;

DATA oneway;
DO level = 1 to 5; INPUT delta @@; OUTPUT; END;
LINES;
2 0 0 0 0
;

PROC GLMPOWER DATA=oneway;
CLASS level;
MODEL delta = level;
CONTRAST ’Trt1 - Trt2’ level 1 -1 0 0 0;
POWER
STDDEV = 1.25 <-- sigma estimate
ALPHA = 0.05 <-- alpha level
NTOTAL = . <-- determine N
POWER = .50 .80 .85 .90 .95 .99; <-- choices for power
TITLE ’Case 1: Determining sample size for detecting a 2-unit difference’;
TITLE2 ’for 4 equal means and 1 unequal mean and for a contrast comparing’;
TITLE3 ’two means (with power=.50 .80 .85 .90 .95 .99)’;
RUN;



**************;
*** Case 2 ***;
**************;
DATA oneway2;
DO level = 1 to 5; INPUT delta @@; OUTPUT; END;
LINES;
2 0 0 0 0
;
PROC GLMPOWER DATA=oneway2;
CLASS level;
MODEL delta = level;
CONTRAST ’Trt1 - Trt2’ level 1 -1 0 0 0;
POWER
STDDEV = 1.25
ALPHA = 0.05
NTOTAL = 10 15 20 25 30 35 40 45 50 55 60 <-- choices for N
POWER = .; <-- determine power
TITLE ’Case 2: Determining power for detecting a 2-unit difference’;
TITLE2 ’for 4 equal means and 1 unequal mean and for a contrast ’;
TITLE3 ’comparing two means (for total sample size N=10 15 ... 55 60)’;
RUN;
