proc import datafile="Regression/data/train.csv"
dbms=csv
out=train
replace;
getnames=yes;
guessingrows=10000;
run;
proc import datafile="Regression/data/test.csv"
dbms=csv
out=test
replace;
getnames=yes;
guessingrows=10000;
run;
proc contents data=train; run;
proc contents data=test; run;

/*reducing to just the variables and neighborhoods for analysis 1*/
data train_sub;
	set train;
	log_saleprice=log(saleprice);
	log_GrLIvArea=log(GrLIvArea);
	keep neighborhood GrLIvArea saleprice log_saleprice log_GrLIvArea;
	where neighborhood in ('NAmes','Edwards','BrkSide');
run;

/*histograms and qqplots for living area and sale price*/
ods graphics on / attrpriority=none;
proc ttest data=train_sub;
	var grlivarea ;
run;
proc ttest data=train_sub;
	var saleprice;
run;
proc ttest data=train_sub;
	var log_grlivarea ;
run;
proc ttest data=train_sub;
	var log_saleprice;
run;

/*scatter plots for living area vs sale price*/
/*linear-linear
  log-linear
  linear-log
  log-log
*/
proc sgplot data=train_sub;
	styleattrs datasymbols=(circlefilled squarefilled starfilled);
	reg x=GrLIvArea y=saleprice / group=neighborhood ;
run;
proc sgplot data=train_sub;
	styleattrs datasymbols=(circlefilled squarefilled starfilled);
	reg x=log_GrLIvArea y=saleprice / group=neighborhood ;
run;
proc sgplot data=train_sub;
	styleattrs datasymbols=(circlefilled squarefilled starfilled);
	reg x=GrLIvArea y=log_saleprice / group=neighborhood ;
run;
proc sgplot data=train_sub;
	styleattrs datasymbols=(circlefilled squarefilled starfilled);
	reg x=log_GrLIvArea y=log_saleprice / group=neighborhood ;
run;



proc glm data=train_sub plots=all;class neighborhood;model saleprice = log_GrLIvArea | neighborhood;run;
proc glm data=train_sub plots=all;class neighborhood;model log_saleprice = log_GrLIvArea | neighborhood;run;

proc reg data=train_sub;
  model saleprice = GrLivArea;
  model saleprice = log_GrLIvArea;
  model log_saleprice = GrLivArea;
  model log_saleprice = log_GrLIvArea;
run;



proc import datafile="/home/philliph0/MSDS 6371 Stats Foundation/Tutorials/Regression/data/train.csv"
dbms=csv
out=train
replace;
getnames=yes;
guessingrows=10000;
run;

** Setting Category Variables;
data train_sub; ** change the name so that we dont overrite previous data;
set train; ** name of the data set we want to add variables to;
	where neighborhood in ('NAmes','Edwards','BrkSide');
	where GrLivArea < 4000;
	
	**coding indicator (Dummy) variables for neighborhood;
	sqft = GrLivArea / 100;
	if neighborhood = 'NAmes' then x2 = 1; else x2 = 0;
	if neighborhood = 'Edwards' then x3 = 1; else x3 = 0;
	x2_sqft = x2 * sqft; x3_sqft = x3 * sqft;
	
	** log transformation;	
	sqft_log = log(sqft);
	log_saleprice=log(saleprice);
	x2_sqft_log = x2 * sqft_log; x3_sqft_log = x3 * sqft_log;
run;

** Scatterplot;
proc sgscatter data = train_sub; title "Ames Iowa Neighborhood Sales Price by SqFt";
	 plot sqft * saleprice / reg group=neighborhood; run;


** Find out if regression is even appropriate;
proc reg data=train_sub;
  model saleprice = sqft x2 x3 / VIF ;
  output out=diag r = resid p=pred; 
run;

** ASSUMPTION CHECKING
-- original variables --;
proc univariate data=train_sub noprint;
  histogram saleprice log_saleprice sqft sqft_log x2 x3 /normal kernel;
run;

** scatter plot matrix;
proc sgscatter data=train_sub;
  matrix saleprice log_saleprice sqft sqft_log x2 x3;
run; 


**multiplicolinatiry w/o interactions;

proc reg data = train_sub; model log_saleprice = sqft_log x2 x3  / VIF;
	run;


proc reg data = train_sub; model log_saleprice = sqft_log x2 x3 x2_sqft_log x3_sqft_log / VIF;
	run;


proc freq data=train;table lotFrontage;run;
data train_conv;	
set train;	Lotfrontage_impute = input(LotFrontage,10.);run;
proc univariate data=train_conv;var Lotfrontage_impute;histogram;run;












