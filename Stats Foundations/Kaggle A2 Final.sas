
data train;  
infile "/home/philliph0/MSDS 6371 Stats Foundation/Tutorials/Regression/data/train.csv" firstobs=2 dsd;  
input Id MSSubClass MSZoning $ LotFrontage LotArea Street $ Alley $ LotShape $ LandContour $ Utilities $ 
LotConfig $ LandSlope $ Neighborhood $ Condition1 $ Condition2 $ BldgType $ HouseStyle $ OverallQual
OverallCond YearBuilt YearRemodAdd RoofStyle $ RoofMatl $ Exterior1st $ Exterior2nd $ MasVnrType $ 
MasVnrArea ExterQual $ ExterCond $ Foundation $ BsmtQual $ BsmtCond $ BsmtExposure $ BsmtFinType1 $ 
BsmtFinSF1 BsmtFinType2 $ BsmtFinSF2 BsmtUnfSF TotalBsmtSF Heating $ HeatingQC $ CentralAir $ 
Electrical $ OneFlrSF TwoFlrSF LowQualFinSF GrLivArea BsmtFullBath BsmtHalfBath FullBath HalfBath BedroomAbvGr
KitchenAbvGr KitchenQual $ TotRmsAbvGrd Functional $ Fireplaces FireplaceQu $ GarageType $ GarageYrBlt
GarageFinish $ GarageCars GarageArea GarageQual $ GarageCond $ PavedDrive $ WoodDeckSF OpenPorchSF EnclosedPorch 
_3SsnPorch ScreenPorch PoolArea PoolQC $	Fence $	MiscFeature $ MiscVal $ MoSold YrSold SaleType $ SaleCondition $ SalePrice
;
run;

data test;  
infile "/home/philliph0/MSDS 6371 Stats Foundation/Tutorials/Regression/data/test.csv" firstobs=2 dsd;  
input Id MSSubClass MSZoning $ LotFrontage LotArea Street $ Alley $ LotShape $ LandContour $ Utilities $ 
LotConfig $ LandSlope $ Neighborhood $ Condition1 $ Condition2 $ BldgType $ HouseStyle $ OverallQual
OverallCond YearBuilt YearRemodAdd RoofStyle $ RoofMatl $ Exterior1st $ Exterior2nd $ MasVnrType $ 
MasVnrArea ExterQual $ ExterCond $ Foundation $ BsmtQual $ BsmtCond $ BsmtExposure $ BsmtFinType1 $ 
BsmtFinSF1 BsmtFinType2 $ BsmtFinSF2 BsmtUnfSF TotalBsmtSF Heating $ HeatingQC $ CentralAir $ 
Electrical $ OneFlrSF TwoFlrSF LowQualFinSF GrLivArea BsmtFullBath BsmtHalfBath FullBath HalfBath BedroomAbvGr
KitchenAbvGr KitchenQual $ TotRmsAbvGrd Functional $ Fireplaces FireplaceQu $ GarageType $ GarageYrBlt
GarageFinish $ GarageCars GarageArea GarageQual $ GarageCond $ PavedDrive $ WoodDeckSF OpenPorchSF EnclosedPorch 
_3SsnPorch ScreenPorch PoolArea PoolQC $	Fence $	MiscFeature $ MiscVal $ MoSold YrSold SaleType $ SaleCondition $
;

** add sales price to test data set for future placement for submission predictions to kaggle;
SalePrice = .;
run;

/* Frequency Plot 
proc freq data=test order=freq;
   tables Neighborhood OverallQual OverallCond GarageCars Fireplaces 
   YearBuilt YearRemodAdd BsmtFullBath BsmtQual
   MSZoning CentralAir KitchenQual BsmtQual Neighborhood
   /plots=freqplot;
run;
*/



* Create new data set for all ames data that includes both train and test data for EDA and pre-processing;
data ames;
	set train test;
	
	** 2 outliers removed with ID 524 and 1299 indicating from reviewing Cooks D showing high leverage.;
	if id = 524 then delete;  
	if id = 1299 then delete; 
	
	
	** pre-preocessing per clients request to describe square footage by 100;
	OneFlrSF = OneFlrSF / 100;
	TwoFlrSF = TwoFlrSF / 100;
	GrLivArea = GrLivArea/100;
	LotArea = LotArea / 100;
	MasVnrArea = MasVnrArea / 100;
	GarageArea = GarageArea/100;
	
	** from Joe;
	WoodDeckSF = WoodDeckSF/100;
	OpenPorchSF = OpenPorchSF/100;
	EnclosedPorch = EnclosedPorch/100;
	_3SsnPorch = _3SsnPorch/100;
	ScreenPorch = ScreenPorch/100;
	PoolArea = PoolArea/100;
	
	
	** cleaning up NA from analysis;
	if Exterior1st = "NA" 	then 	Exterior1st="Wd Sdng";
	if BsmtCond = "NA" 		then 	BsmtCond="None";
	if MasVnrType="NA" 		then 	MasVnrType="None";
	if KitchenQual="NA" 	then 	KitchenQual="TA";
	if Functional="NA" 		then 	Functional="None";
	if FireplaceQu="NA" 	then 	FireplaceQu="None";
	if BsmtFinSF1="NA" 		then 	BsmtFinSF1=0;
	if BsmtFinType2="NA" then BsmtFinType2="None";
	if GarageType="NA" then GarageType="None";
	if BsmtQual="NA" then BsmtQual="None";
	if BsmtCond="NA" then BsmtCond="None";
	if SaleType ='NA' then SaleType = 'None';
	if GarageArea="NA" then GarageArea=0;
	
	** NA clean up from Joe;
	if YrSold >2007 then YrSold = 2008;
	if OverallQual <3 then OverallQual =2;
 	if OverallCond <4 then OverallCond =3;
 	if Fireplaces >2 then Fireplaces =2;
 	if TotRmsAbvGrd <4 then TotRmsAbvGrd =3;
 	if TotRmsAbvGrd>10 then TotRmsAbvGrd =10;
 	if WoodDeckSF >0 then WoodDeckSF =1;
 	if OpenPorchSF >0 then OpenPorchSF =1;
 	if EnclosedPorch > 0 then EnclosedPorch =1;
 	if _3SsnPorch > 0 then _3SsnPorch =1;
 	if ScreenPorch > 0 then ScreenPorch =1;
 	if PoolArea > 0 then PoolArea =1;	
 	if Electrical ne 'SBrkr' then Electrical = 'Fuse';
	
	** pre-processing from Joe;
	if MSSubClass = 150 then MSSubClass = 120;
	if MSSubClass = 150 then MSSubClass = 120;
	if MSZoning = 'NA' then MSZoning = 'RL';
	if LotArea >200 then lotArea = 1; else LotArea = 0;
	if YearBuilt <1950  then YearBuilt =1949;
	YearBuilt = floor((2010 -YearBuilt)/10);
	YearRemodAdd =floor((2010 -YearRemodAdd)/10);
	if BsmtFinSF1 =. then  BsmtFinSF1 =0;
	if BsmtFinSF2 = . then BsmtFinSF2= 0;
	if BsmtUnfSF = . then BsmtUnfSF = 0; 
	if TotalBsmtSF =. then TotalBsmtSF =0;
	if FullBath >3 then FullBath =3;
	if FullBath = 0 then FullBath =1;
	if GarageYrBlt =. then GarageYrBlt = 1950;
	if GarageYrBlt =2207 then GarageYrBlt =2007;
	if GarageYrBlt <1950 then GarageYrBlt =1949; 
	GarageYrBlt = floor((2010 -GarageYrBlt)/10);
	if GarageCars =. then GarageCars =0;
	if GarageCars >3 then GarageCars =3;
	if MasVnrArea = . then MasVnrArea = 0;
	if MasVnrType = "NA" then MasVnrType = "None";
	if GarageArea =. then GarageArea =0;
	
	
	** drop colmns that have too many NA or categories with the majority of one factor that the variable is just not useful;
	Drop PoolQC;
	Drop Alley; 
	Drop MiscFeature;
	Drop Utilities;
	
	** log transformation;	
	logSalePrice =log(SalePrice);
	MasVnrArea_log = log(MasVnrArea);
	LotArea_log = log(LotArea + 1);
	sqft_log = log(GrLivArea);
	BsmtFinSF1_log = log(BsmtFinSF1);
	GarageArea_log = log(GarageArea);
	poolarea_log = log(PoolArea + 1);
	TotalBsmtSF_log = log(TotalBsmtSF + 1);
	LotArea_log = log(LotArea +1);
	OneFlrSF_log = log(OneFlrSF + 1);
	TwoFlrSF_log = log(TwoFlrSF);
	BsmtFinSF2_log = log(BsmtFinSF2);
	BsmtUnfSF_log = log(BsmtUnfSF +1);
	sqft_full = GrLivArea + GarageArea + TotalBsmtSF;
	sqft_full_log = log(sqft_full);
run;


/***************filling missing LotFrontage (NA) with mean***********************/

data ames;
	set ames;
	if LotFrontage = 'NA' then LotFrontage1 = .; else LotFrontage1 = LotFrontage+0;
run;

proc stdize data=ames reponly method=mean out=ames;
var LotFrontage1;
run;

data ames (rename= (LotFrontage1 = LotFrontage));
	set ames (drop=LotFrontage);
	LotFrontage_log = log(LotFrontage + 1);
	
run;


*************************************************************************************************
      ------------------------ M O D E L    S E L E C T I O N ------------------------ 
*************************************************************************************************
;

**
      ------------------------ F O R W A R D     S E L E C T I O N ------------------------ 
**
*forward - start with no predictor variables and add the best variable at each step and intereate
Friday Update

 BsmtFinType2 BsmtFinType2 GarageCond GarageCond GarageType GarageType

bad - LotFrontage_log 

removed - BsmtFinSF1 MasVnrArea
;

	    
ods graphics on;
proc glmselect data = ames plots(stepAxis=number)=(criterionPanel ASEPlot ASE); partition fraction(validate = 0.2 test = 0.2);
	class Neighborhood MSSubClass MSZoning ExterQual Condition1 Condition2 BldgType Street LotShape LandContour LotConfig LandSlope
		ExterCond BsmtQual MasVnrType BsmtCond BsmtExposure Heating HeatingQC CentralAir Electrical KitchenQual Functional RoofStyle RoofMatl 
		Exterior1st Exterior2nd Foundation BsmtFinType1	PoolArea FireplaceQu  GarageFinish GarageQual  PavedDrive HouseStyle
		SaleCondition YrSold _3SsnPorch; 

	model logSalePrice =  LotArea Neighborhood OverallQual YearBuilt  Foundation OverallCond  sqft_log BsmtFinSF1_log   GarageArea_log 
	MasVnrArea_log LotArea_log YearRemodAdd GarageCars
	     
	    MSSubClass MSZoning Street LotShape Condition1 Condition2 BldgType RoofStyle RoofMatl Exterior1st Exterior2nd MasVnrType ExterQual ExterCond BsmtQual
	    BsmtCond BsmtExposure BsmtFinType1  Heating HeatingQC CentralAir Electrical KitchenQual Functional FireplaceQu 
		 GarageFinish GarageQual  PavedDrive SaleCondition _3SsnPorch PoolArea YrSold HouseStyle
	    
	    / selection=forward (select=AIC stop=AIC) CVdetails showpvalues hierarchy=single stat=all;	
	
	output out = forward_results_output p = Predict;
	run; quit;
	ods graphics off;

**--- BEST MODEL --- Friday Night PM
- FoundationPConc  BsmtQualGd GarageTypeAttchd;
ODS GRAPHICS ON / ATTRPRIORITY=NONE; 
proc glm data = ames plots=all;
	class OverallQual SaleCondition Foundation Condition1 FireplaceQu CentralAir Neighborhood;
	model logSalePrice = sqft_log LotArea_log BsmtFinSF1_log GarageArea_log OverallCond OverallQual TwoFlrSF_log Neighborhood CentralAir Fireplaces  
	YearBuilt YearRemodAdd sqft_log*Neighborhood OverallCond*SaleCondition/ tolerance solution  ;
	output out = kaggle_results p=predict PRESS=CSVPress;
	
run;quit;ODS GRAPHICS OFF;

**** Results and ANOVA for VIF;
proc reg data=ames;
  model logSalePrice = sqft_log LotArea_log BsmtFinSF1_log GarageArea_log OverallCond OverallQual TwoFlrSF_log Fireplaces  
	YearBuilt YearRemodAdd  /partial vif;
run;


** Prediction on Test;
data forward_results;
	set kaggle_results;
		if Predict > 0 then logSalePrice = Predict;
		if Predict < 0 or Predict = '.' then logSalePrice = log(180921.1959); ** if empty or 0 set sales price to avg;
		SalePrice = exp(logSalePrice);
	keep Id SalePrice;
	where Id > 1460;
	run;
 proc export data=forward_results dbms=csv 
 	OUTFILE= "/home/philliph0/MSDS 6371 Stats Foundation/Tutorials/Regression/Kaggle Project/forward_results.csv" replace; 
 run;




**
      ------------------------ B A C K W A R D     S E L E C T I O N ------------------------ 
**
;

ods graphics on;
proc glmselect data = ames plots=all; partition fraction(test = 0.2);
	class Neighborhood MSSubClass MSZoning ExterQual Condition1 Condition2 BldgType Street LotShape LandContour LotConfig LandSlope
		ExterCond BsmtQual MasVnrType BsmtCond BsmtExposure Heating HeatingQC CentralAir Electrical KitchenQual Functional RoofStyle RoofMatl 
		Exterior1st Exterior2nd Foundation BsmtFinType1	PoolArea FireplaceQu  GarageFinish GarageQual  PavedDrive HouseStyle
		SaleCondition YrSold _3SsnPorch GarageType GarageCond BsmtFinType2 SaleType; 

	model logSalePrice =  LotArea Neighborhood OverallQual YearBuilt  Foundation OverallCond  sqft_log BsmtFinSF1_log   GarageArea_log 
	MasVnrArea_log LotArea_log YearRemodAdd GarageCars MSSubClass MSZoning Street LotShape Condition1 Condition2 BldgType RoofStyle KitchenAbvGr
	RoofMatl Exterior1st Exterior2nd MasVnrType ExterQual ExterCond BsmtQual BsmtCond BsmtExposure BsmtFinType1  Heating HeatingQC CentralAir 
	Electrical KitchenQual Functional FireplaceQu GarageFinish GarageQual  PavedDrive SaleCondition _3SsnPorch PoolArea YrSold HouseStyle 
	GarageType GarageCond LotArea_log LandContour LotConfig LandSlope  BsmtFinType2 BedroomAbvGr  TotRmsAbvGrd Fireplaces GarageYrBlt SaleType
	    
	/ selection=backward (select=AIC stop=AIC) CVdetails showpvalues hierarchy=single stat=all;	
	
	output out = backward_results_output p = Predict;
	run; quit;
ods graphics off;

**
sqft_log  LotArea  OverallQual BsmtFinSF1_log MSZoning FV Condition1 PosN SaleCondition Family
;

ODS GRAPHICS ON / ATTRPRIORITY=NONE; 
proc glmselect data = ames plots=all;partition fraction(test = 0.2);
	class OverallQual SaleCondition Foundation Condition1 FireplaceQu CentralAir Neighborhood;
	model logSalePrice = sqft_log LotArea_log BsmtFinSF1_log GarageArea_log OverallCond OverallQual TwoFlrSF_log Neighborhood CentralAir Fireplaces  
	YearBuilt YearRemodAdd
	/ selection=backward (select=AIC stop=AIC) CVdetails showpvalues hierarchy=single stat=all;	
	
	output out = backward_results_output p = Predict;
	run; quit;
	
run;quit;ODS GRAPHICS OFF;

ODS GRAPHICS ON / ATTRPRIORITY=NONE; 
proc glm data = ames plots=all;
	class OverallQual SaleCondition Foundation Condition1 FireplaceQu CentralAir Neighborhood;
	model logSalePrice = sqft_log LotArea_log BsmtFinSF1_log GarageArea_log OverallCond OverallQual TwoFlrSF_log Neighborhood CentralAir Fireplaces  
	YearBuilt YearRemodAdd sqft_log*Neighborhood OverallCond*SaleCondition/ tolerance solution  ;
	output out = backward_results_output p=predict PRESS=CSVPress;
	
run;quit;ODS GRAPHICS OFF;


** Prediction on Test;
data backward_results;
	set backward_results_output;
		if Predict > 0 then logSalePrice = Predict;
		if Predict < 0 or Predict = '.' then logSalePrice = log(180921.1959); ** if empty or 0 set sales price to avg;
		SalePrice = exp(logSalePrice);
	keep Id SalePrice;
	where Id > 1460;
	run;
 proc export data=backward_results dbms=csv 
 	OUTFILE= "/home/philliph0/MSDS 6371 Stats Foundation/Tutorials/Regression/Kaggle Project/backward_results.csv" replace; 
 run;



**** Results and ANOVA for VIF;
proc reg data=ames;
  model logSalePrice = sqft_log LotArea_log BsmtFinSF1_log GarageArea_log OverallCond OverallQual TwoFlrSF_log Fireplaces  
	YearBuilt YearRemodAdd  /partial vif;
run;
**** Confusion MNatrix for inquestion factor variables;
proc freq data=ames; table Condition1*Condition2; run;


**
      ------------------------ S T E P - W I S E    S E L E C T I O N ------------------------ 
**

ods graphics on;
proc glmselect data = ames plots(stepAxis=number)=(criterionPanel ASEPlot ASE); partition fraction(validate = 0.2 test = 0.2);
	class Neighborhood MSSubClass MSZoning ExterQual Condition1 Condition2 BldgType Street LotShape LandContour LotConfig LandSlope
		ExterCond BsmtQual MasVnrType BsmtCond BsmtExposure Heating HeatingQC CentralAir Electrical KitchenQual Functional RoofStyle RoofMatl 
		Exterior1st Exterior2nd Foundation BsmtFinType1	PoolArea FireplaceQu  GarageFinish GarageQual  PavedDrive HouseStyle
		SaleCondition YrSold _3SsnPorch; 

	model logSalePrice =  LotArea Neighborhood OverallQual YearBuilt  Foundation OverallCond  sqft_log BsmtFinSF1_log   GarageArea_log 
	MasVnrArea_log LotArea_log YearRemodAdd GarageCars MSSubClass MSZoning Street LotShape Condition1 Condition2 BldgType RoofStyle 
	RoofMatl Exterior1st Exterior2nd MasVnrType ExterQual ExterCond BsmtQual BsmtCond BsmtExposure BsmtFinType1  Heating HeatingQC CentralAir 
	Electrical KitchenQual Functional FireplaceQu GarageFinish GarageQual  PavedDrive SaleCondition _3SsnPorch PoolArea YrSold HouseStyle
	    
	/ selection=stepwise (select=AIC stop=AIC) CVdetails showpvalues hierarchy=single stat=all;	
	
	output out = stepwise_results_output p = Predict;
	run; quit;
ods graphics off;



**
      ------------------------ C U S T O M - WIP :   L A S S O   S E L E C T I O N ------------------------ 
Friday Night
**
;

ods graphics on;
proc glmselect data = ames plots(stepAxis=number)=(criterionPanel ASEPlot ASE); partition fraction(validate = 0.2 test = 0.2);
	class Neighborhood MSSubClass MSZoning ExterQual Condition1 Condition2 BldgType Street LotShape LandContour LotConfig LandSlope
		ExterCond BsmtQual MasVnrType BsmtCond BsmtExposure Heating HeatingQC CentralAir Electrical KitchenQual Functional RoofStyle RoofMatl 
		Exterior1st Exterior2nd Foundation BsmtFinType1	PoolArea FireplaceQu  GarageFinish GarageQual  PavedDrive HouseStyle
		SaleCondition YrSold _3SsnPorch; 

	model logSalePrice =  LotArea Neighborhood OverallQual YearBuilt  Foundation OverallCond  sqft_log BsmtFinSF1_log   GarageArea_log 
	MasVnrArea_log LotArea_log YearRemodAdd GarageCars MSSubClass MSZoning Street LotShape Condition1 Condition2 BldgType RoofStyle 
	RoofMatl Exterior1st Exterior2nd MasVnrType ExterQual ExterCond BsmtQual BsmtCond BsmtExposure BsmtFinType1  Heating HeatingQC CentralAir 
	Electrical KitchenQual Functional FireplaceQu GarageFinish GarageQual  PavedDrive SaleCondition _3SsnPorch PoolArea YrSold HouseStyle
	    
	/ selection=lasso (select=AIC stop=AIC) CVdetails showpvalues hierarchy=single stat=all;	
	
	output out = LASSO_results_output p = Predict;
	run; quit;
ods graphics off;

