#!/bin/bash

VOLdir="./HCP_results/fullbrainECM/ECM_Z"

##Average 4 runs per subject for one standardized image per subject

SUBs="" #insert subject IDs here

for sub in ${SUBs[@]}
do

echo averaging ECMs for ${sub}

LRimage1="ECM_REST1_LR_${sub}_Zwb.nii"
RLimage1="ECM_REST1_RL_${sub}_Zwb.nii"
LRimage2="ECM_REST2_LR_${sub}_Zwb.nii"
RLimage2="ECM_REST2_RL_${sub}_Zwb.nii"

fslmerge -t ${VOLdir}/${sub}_tmp.nii ${VOLdir}/${LRimage1} ${VOLdir}/${RLimage1} ${VOLdir}/${LRimage2} ${VOLdir}/${RLimage2}
fslmaths ${VOLdir}/${sub}_tmp.nii -Tmean ${VOLdir}/ECM_${sub}_Zwb.nii

rm ${VOLdir}/${sub}_tmp.nii.gz

done

