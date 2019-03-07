/* SAS example of Kruskal-Wallis test   */
/* (and multiple comparisons)           */

/* The data are the soil measurements we saw in class. */

/* Entering the data: */

DATA soil;
INPUT location claypct;
cards;
1 26.5
1 15.0
1 18.2
1 19.5
1 23.1
1 17.3
2 16.5
2 15.8
2 14.1 
2 30.2
2 25.1 
2 17.4
3 19.2
3 21.4
3 26.0
3 21.6
3 35.0
3 28.9
4 26.7
4 37.3
4 28.0
4 30.1
4 33.5
4 26.3
;
run;

/* PROC UNIVARIATE with the PLOT OPTION gives boxplots for */
/* each of the four groups.                                */

/* The NORMAL option gives the Shapiro-Wilk test result     */
/* for testing normality for each of the four groups.  Note */
/* that with such small sample sizes we have little power   */
/* to detect non-normality.                                 */

PROC UNIVARIATE PLOT NORMAL DATA=soil;
BY location;
VAR claypct;
run;

/* PROC NPAR1WAY with the WILCOXON option gives the Kruskal-Wallis */
/* test statistic with the approximate (chi-square) P-value.       */

/* The CLASS statement tells SAS that location is the factor. */
/* The VAR statement tells SAS that claypct is the response.  */

PROC NPAR1WAY DATA=soil WILCOXON;
CLASS location;
EXACT WILCOXON / MC;
VAR claypct;
run;



/* SAS also gives an exact P-value with an EXACT statement. */
/* It is actually based on a Monte Carlo estimate using     */
/* 10,000 random permutations of the data.                  */


/*******************************************************************/

/* Distribution-free Bonferroni Multiple Comparisons in SAS */

/* Getting the ranks for the data: */

PROC RANK DATA=soil OUT=soilrnks;
VAR claypct;
run;

/* Printing the ranks for the data: */

PROC PRINT DATA=soilrnks;
run;

/* Performing the Bonferroni Multiple Comparisons: */




data data1; set soilrnks; if location > 2; run;
proc print data = data1;run;

proc npar1way wilcoxon; class location; exact; var claypct;
title 'Depressant vs Stimulant'; run;

PROC GLM DATA=soilrnks;
CLASS location;
MODEL claypct = location;
LSMEANS location / CL PDIFF ADJUST=BON;
run;


/* These are NOT CIs!                                             */
/* But we can use the given point estimates for the differences   */
/* in treatment rank means to help with simultaneous tests.       */