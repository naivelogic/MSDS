** https://2ds.datascience.smu.edu/mod/page/view.php?id=20760#/cardContent;
proc power;
onewayanova test=overall
groupmeans = 3 | 7 | 8 
alpha = 0.05
stddev = 4
power = 0.8
ntotal= .;
run;


** power analysis contrast;
proc power;
onewayanova test=contrast
contrast = (1 0 -1)
groupmeans = 3 | 7 | 8
stddev = 4
npergroup = 13
power = .;
run;

** Analysis
We have high power (0.87) to detect difference in the contrast statement above for 
the treatement groups;


**;
proc power;
onewayanova test=overall
groupmeans = 3 | 7 | 8
stddev = 4
groupweights= (1 2 2) /*groups 2 and 3 have twice a much observations as group 1;*/
ntotal = .
power = 0.9;
run;

** Analysis
Need 65 Observations for a power of 0.915
The 65 observations would have to be split up where group 2 and 3 have twice as much
observations than group 1;

**;
proc power;
      onewayanova 
	   test=constrast
	   groupmeans = 93 | 74.6 | 86.7 | 76.5
         stddev = 27
         alpha = 0.05
	   contrast = (-1 1 -1 1)
         ntotal =.
         power = 0.8;
	   plot x=power min=0.6 max=1.0;
       run;
