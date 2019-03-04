DATA iron;
INPUT brand $ dist @@;
CARDS;
A 251.2 B 263.2 C 269.7 D 251.6
A 245.1 B 262.9 C 263.2 D 248.6
A 248.0 B 265.0 C 277.5 D 249.4
A 251.1 B 254.5 C 267.4 D 242.0
A 260.5 B 264.3 C 270.5 D 246.5
A 250.0 B 257.0 C 265.5 D 251.3
A 253.9 B 262.8 C 270.7 D 261.8
A 244.6 B 264.4 C 272.9 D 249.0
A 254.6 B 260.6 C 275.6 D 247.1
A 248.8 B 255.9 C 266.5 D 245.9

;

/* PROC ANOVA will give us the ANOVA table for these data http://people.stat.sc.edu/Hitchcock/sas_ANOVA_examp.txt */
/* CLASS brand tells SAS that brand is a qualitative factor */
/* MODEL dist=brand tells SAS that dist is the response and brand is a factor */


PROC ANOVA DATA=iron;
CLASS brand;
MODEL dist=brand;
RUN; 

/* If you enter this program into the program editor, */
/* and Submit, the output should be similar to the  */
/* output in Figure 10.12 on page 517 of the textbook. */

/* Checking model assumptions */

/* Note the Side-by-side boxplots in the PROC ANOVA output. */
/* If the spreads of the four boxplots are similar, then the equal-variances assumption may be correct.*/

/* Normal Q-Q plots for each population: */


PROC UNIVARIATE DATA=iron NORMAL PLOT;
VAR dist;
WHERE brand='A';
RUN;

PROC UNIVARIATE DATA=iron NORMAL PLOT;
VAR dist;
WHERE brand='B';
RUN;

PROC UNIVARIATE DATA=iron NORMAL PLOT;
VAR dist;
WHERE brand='C';
RUN;

PROC UNIVARIATE DATA=iron NORMAL PLOT;
VAR dist;
WHERE brand='D';
RUN;

/* Multiple Comparisons (Sec. 10.3) */

PROC ANOVA DATA=iron;
CLASS brand;
MODEL dist=brand;
MEANS brand / tukey cldiff alpha=0.05;
RUN; 

/* Result:  Every pair of brand means is significantly different, except for the means of brands A and D. */