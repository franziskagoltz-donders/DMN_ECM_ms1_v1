###1 DOWNLOAD FROM HCP 
python ECMDMN_01_HCPdownload2.py

###2 DOWNSAMPLE AND SMOOTH DATA 3MM ISOTROPIC
./ECMDMN_02_downsample_flirt.sh

###3 DO ECM ON DOWNSAMPLED DATA
./ECMDMN_03_ECM.sh

###4 STANDARDIZE ECM MAPS
./ECMDMN_04_standardize_wholebrain.sh

###5 AVERAGE ECz MAPS ACROSS RUNS
./ECMDMN_05_meanECM_LRRL.sh

###6 MAKE DIRECTORY LIST FOR ICA
python ECMDMN_06_directorylistICA.py

###7 DO ICA ON DOWNSAMPLED, SMOOTHED DATA
./ECMDMN_07_ICA.sh

###8 COMPUTE MEAN EC OF EACH COMPONENT
./ECMDMN_08_meanECofIC.sh

###9 COMBINE MEAN EC OF COMPONENTS TO ONE TXT FILE PER COMPONENT
python ECMDMN_09_combinetxtfiles.py

###10 SPATIAL CORRELATION BETWEEN EC MAPS AND INDEPENDENT COMPONENTS
./ECMDMN_10_scDMNECM.sh

###11 SPSS syntax for statistics
###12 One sample t-test on ECz maps with FSL randomise
./ECMDMN_12_randomiseECz.sh


 




