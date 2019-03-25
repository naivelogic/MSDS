/* https://blogs.sas.com/content/iml/2014/11/21/resampling-in-sas.html */

proc iml;
G1 = {27, 19, 20, 20, 23, 17, 21, 24, 31, 26, 28, 20, 27, 19, 25, 31, 24, 28, 24, 29, 21, 21, 18, 27, 20};
G2 = {21, 19, 13, 22, 15, 22, 15, 22, 20, 12, 24, 24, 21, 19, 18, 16, 23, 20};
obsdiff = mean(G1) - mean(G2);
print obsdiff;

call randseed(12345);                             /* set random number seed */
alldata = G1 // G2;                        /* stack data in a single vector */
N1 = nrow(G1);  N = N1 + nrow(G2);
NRepl = 9999;                                     /* number of permutations */
nulldist = j(NRepl,1);                   /* allocate vector to hold results */
do k = 1 to NRepl;
   x = sample(alldata, N, "WOR");                       /* permute the data */
   nulldist[k] = mean(x[1:N1]) - mean(x[(N1+1):N]);  /* difference of means */
end;
 
title "Histogram of Null Distribution";
refline = "refline " + char(obsdiff) + " / axis=x lineattrs=(color=red);";
call Histogram(nulldist) other=refline;

pval = (1 + sum(abs(nulldist) >= abs(obsdiff))) / (NRepl+1);
print pval;
                                                                                                                              
                              