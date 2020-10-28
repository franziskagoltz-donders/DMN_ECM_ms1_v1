#!/bin/bash

VOLdir="./HCP_data"
DATAdir="MNINonLinear/Results"

SUBs="100307 100408 101107 101309 101915 103111 103414 103818 105014 105115 106016 108828 110411 111312 111716 113619 113922 114419 115320 116524 117122 118528 118730 118932 120111 122317 122620 123117 123925 124422 125525 126325 127630 127933 128127 128632 129028 130013 130316 131217 131722 133019 133928 135225 135932 136833 138534 139637 140925 144832 146432 147737 148335 148840 149337 149539 149741 151223 151526 151627 153025 154734 156637 159340 160123 161731 162733 163129 176542 178950 188347 189450 190031 192540 196750 198451 199655 201111 208226 211417 211720 212318 214423 221319 239944 245333 280739 298051 366446 397760 414229 499566 654754 672756 751348 756055 792564 856766 857263 899885" #insert correct subject IDs here, these are 100 unrelated

for sub in ${SUBs[@]}
do

##RESAMPLING to 3mm, input and reference image are the same (the original) image
##these are only for REST1, add same command for REST2

echo resample ${sub}
flirt -in ${VOLdir}/${sub}/${DATAdir}/rfMRI_REST1_RL/rfMRI_REST1_RL_hp2000_clean.nii.gz -ref ${VOLdir}/${sub}/${DATAdir}/rfMRI_REST1_RL/rfMRI_REST1_RL_hp2000_clean.nii.gz -out /media/newvol/HCP_data/smoothed_resampled/rfMRI_REST1_RL_hp2000_clean3mm_${sub}.nii.gz -applyisoxfm 3

flirt -in ${VOLdir}/${sub}/${DATAdir}/rfMRI_REST1_LR/rfMRI_REST1_LR_hp2000_clean.nii.gz -ref ${VOLdir}/${sub}/${DATAdir}/rfMRI_REST1_LR/rfMRI_REST1_LR_hp2000_clean.nii.gz -out /media/newvol/HCP_data/smoothed_resampled/rfMRI_REST1_LR_hp2000_clean3mm_${sub}.nii.gz -applyisoxfm 3

##SMOOTHING with 6mm FWHM, in FSL, you have to give gaussian kernel in SD
##add same command for REST2

echo smooth ${sub}
fslmaths /media/newvol/HCP_data/smoothed_resampled/rfMRI_REST1_RL_hp2000_clean3mm_${sub}.nii.gz  -kernel gauss 2.5480 /media/newvol/HCP_data/smoothed_resampled/rfMRI_REST1_RL_hp2000_clean3mm_s_${sub}.nii.gz

fslmaths /media/newvol/HCP_data/smoothed_resampled/rfMRI_REST1_LR_hp2000_clean3mm_${sub}.nii.gz  -kernel gauss 2.5480 /media/newvol/HCP_data/smoothed_resampled/rfMRI_REST1_LR_hp2000_clean3mm_s_${sub}.nii.gz


#remove resampled, unsmoothed images
rm /media/newvol/HCP_data/smoothed_resampled/rfMRI_REST1_RL_hp2000_clean3mm_${sub}.nii.gz
rm /media/newvol/HCP_data/smoothed_resampled/rfMRI_REST1_LR_hp2000_clean3mm_${sub}.nii.gz

done
