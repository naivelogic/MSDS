fLarge 12-5
Example
/* Consider Exercise 10-1 */
data problem81;
infile 'i:\.www\datasets502\EX0502.DAT' firstobs=2 dlm='09'x;
input person sbp quet age smk;
/* These commands generate output in text */
proc reg corr;
model sbp = age smk / pcorr1 pcorr2;
model sbp = age quet/ pcorr1 pcorr2;
model sbp = age smk quet / pcorr1 pcorr2;
/* Example that links first order regr coefficient
with a regression of residuals */
proc reg noprint;
model sbp = age;
output out=resyz r=resyz;
proc reg noprint;
model smk = age;
output out=resxz r=resxz;
proc reg;
model resyz
