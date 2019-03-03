** exmplained: http://www.stat.purdue.edu/~ghobbs/STAT_512/Lecture_Notes/Regression/Topic_13.pdf;
*Read in the data.  First variable is just obsn #, last variable is 1 if male, 0 if female;
options nocenter ls=72; 
data cs; 
   infile '/home/philliph0/MSDS 6371 Stats Foundation/Purdue512/data/csdata.dat';
   input id gpa hsm hss hse satm satv gender_x;
   if gender_x=2 then gender='F'; else gender='M';
proc print data=cs; run;

*Examine HSM HSS and HSE using PROC FREQ;
proc freq data=cs;
  tables hsm hss hse;
run;

*Check individual scatter plots vs. GPA;
symbol1 c=blue v=dot;
proc gplot;
  plot gpa*(hsm hss hse);
run;

*Look at single variable models;
proc reg data=cs;
  model gpa = hsm;
  model gpa = hss;
  model gpa = hse;
run;

*Examine SATM and SATV using PROC MEANS and PROC UNIVARIATE.  The means procedure
   simply provides very basic statistics (also provided in univariate).;

proc means data=cs maxdec=2;
  var SATM SATV;
proc univariate data=cs noprint;
  var SATM SATV;
  histogram SATM SATV;
run;

proc gplot;
  plot gpa*(satm satv);
run;

proc reg data=cs;
  model gpa=satm;
  model gpa=satv;
run;


*Try a full model with all five predictor variables;

proc reg data=cs; 
   model gpa=hsm hss hse satm satv;
run;

*Consider correlations among the predictors;
proc corr data=cs noprob;
  var hsm hss hse satm satv;
 run;
*Consider correlations of each predictor with GPA;
proc corr data=cs noprob;
  var hsm hss hse satm satv;
  with gpa;
 run;

*Create residuals from HSM Model;
proc reg data=cs; 
   model gpa=hsm;
   output out=diag p=pred r=resid;
proc print; run;

proc corr data=diag noprob;
  var resid;
  with hss hse satm satv;
run;


*Model #1:  HSM only;

proc reg data=cs; 
   model gpa=hsm;
   output out=a1 p=pred r=resid;
run;

*Model #2:  Both HSM, HSE;

proc reg data=cs; 
   model gpa=hsm hse;
   output out=a2 p=pred r=resid;
run;


*Check the assumptions!;
proc gplot data=a2;
  plot resid*pred;
proc univariate noprint;
  qqplot resid /normal (L=1 mu=est sigma=est);
run;


proc reg data=cs; 
   model gpa=hsm hse;
run;


proc reg data=cs; 
   model gpa=hsm hse hss satm satv;
run;

proc reg data=cs;
model gpa = hsm hss hse satm satv;
 TEST1: test hss= 0, satm=0, satv=0;
 run;