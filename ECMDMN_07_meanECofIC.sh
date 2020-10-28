#!/bin/bash
components="1 2 3 4 6 7 8 14 15 19" #insert component number of ICA
VOLdir="./HCP_results/fullbrainECM"

mkdir ./HCP_results/FinalResults/meanEC_of_IC_weighted_Zwb

##Calculate weighted average ECz of every component for every subject
##use thresholded ICA spatial map as mask in fslmeants

SUBs="" #insert subject IDs

for sub in ${SUBs[@]}
do
    
image="${VOLdir}/ECM_Z/ECM_${sub}_Zwb.nii.gz"

for c in ${components}
do
    fslmeants -w -i ${image} -o ./HCP_results/FinalResults/meanEC_of_IC_weighted_Zwb/meanEC_of_IC${c}_${sub}_Z.txt -m ./HCP_results/FinalResults/groupICA20_100s_REST12/stats/thresh_zstat${c}.nii

done

done


