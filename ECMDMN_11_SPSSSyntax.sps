* Encoding: UTF-8.
##MANOVA mean ECz
  
  GLM ic2 ic3 ic4 ic5 ic7 ic8 ic9 ic15 ic20 
  /WSFACTOR=IC 9 Simple(1) 
  /METHOD=SSTYPE(3) 
  /PLOT=PROFILE(IC) TYPE=LINE ERRORBAR=SE(2) MEANREFERENCE=NO YAXIS=AUTO 
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(IC) COMPARE ADJ(BONFERRONI) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05) 
  /WSDESIGN=IC.

##Pairwise comparisons mean ECz

GET 
  FILE='/Volumes/DMN_ECM/HCP_results/Final_results_6FWHM/meanEC_of_IC_weighted_Zwb/meanEC_Zwb.sav'. 
DATASET NAME DataSet1 WINDOW=FRONT. 
T-TEST PAIRS=ic3 ic3 ic3 ic3 ic3 ic3 ic3 ic4 ic4 ic4 ic4 ic4 ic4 ic5 ic5 ic5 ic5 ic5 ic7 ic7 ic7 
    ic7 ic8 ic8 ic8 ic9 ic9 ic15 WITH ic4 ic5 ic7 ic8 ic9 ic15 ic20 ic5 ic7 ic8 ic9 ic15 ic20 ic7 ic8 
    ic9 ic15 ic20 ic8 ic9 ic15 ic20 ic9 ic15 ic20 ic15 ic20 ic20 (PAIRED) 
  /CRITERIA=CI(.9500) 
  /MISSING=ANALYSIS.

##Correlations mean ECz

CORRELATIONS 
  /VARIABLES=ic2 ic3 ic4 ic5 ic7 ic8 ic9 ic15 ic20 
  /PRINT=TWOTAIL NOSIG 
  /MISSING=PAIRWISE.

##MANOVA spatial correlations

GLM mvis lvis aud sensmot fpright fpleft occp dmn exc 
  /WSFACTOR=rsn 9 Difference 
  /METHOD=SSTYPE(3) 
  /PLOT=PROFILE(rsn) TYPE=BAR ERRORBAR=CI MEANREFERENCE=NO 
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(rsn) COMPARE ADJ(BONFERRONI) 
  /PRINT=ETASQ 
  /CRITERIA=ALPHA(.05) 
  /WSDESIGN=rsn.

##Pairwise comparisons spatial correlations

T-TEST PAIRS=dmn dmn dmn dmn dmn dmn dmn dmn mvis mvis mvis mvis mvis mvis mvis lvis lvis lvis lvis 
    lvis lvis aud aud aud aud aud sensmot sensmot sensmot sensmot fpright fpright fpright fpleft fpleft 
    occp WITH mvis lvis aud sensmot fpright fpleft occp exc lvis aud sensmot fpright fpleft occp exc 
    aud sensmot fpright fpleft occp exc sensmot fpright fpleft occp exc fpright fpleft occp exc fpleft 
    occp exc occp exc exc (PAIRED) 
  /CRITERIA=CI(.9500) 
  /MISSING=ANALYSIS.
