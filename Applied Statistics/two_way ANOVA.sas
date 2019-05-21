** Two way ANOVA;

data a1; infile 'U:\.www\datasets512\CH19TA07.txt';
   input sales height width;
proc print data=a1; run;

proc glm data=a1;
   class height width;
   model sales=height width height*width;
   means height width height*width;
run;

data a1; set a1; 
   if height eq 1 and width eq 1 then hw='1_BR';
   if height eq 1 and width eq 2 then hw='2_BW';
   if height eq 2 and width eq 1 then hw='3_MR';
   if height eq 2 and width eq 2 then hw='4_MW';
   if height eq 3 and width eq 1 then hw='5_TR';
   if height eq 3 and width eq 2 then hw='6_TW';

symbol1 v=circle i=none;
proc gplot data=a1;
   plot sales*hw/frame;
run;

proc means data=a1; 
   var sales;
   by height width;
   output out=a2 mean=avsales;
proc print data=a2; 
run;

*Generate an interaction plot;

symbol1 v=square i=join c=black;
symbol2 v=diamond i=join c=black;
proc gplot data=a2;
   plot avsales*height=width/frame;
run;

proc glm data=a1;
   class height width;
   model sales=height width height*width;
   means height / tukey lines;
   lsmeans height / adjust=tukey;
run;
ods rtf close;

* source: http://www.stat.purdue.edu/~bacraig/sasfiles512/topic24.sas;
