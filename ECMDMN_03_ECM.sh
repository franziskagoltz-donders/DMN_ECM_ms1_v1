#!/bin/bash

ANALYSIS="pos"
MASK="./MNI152_T1_3mm_brain_mask.nii.gz"

mkdir ./HCP_results/fullbrainECM #make output folder
VOLdir="./HCP_data/smoothed_resampled" #folder with smoothed and resampled images

SUBs="100307 100408 101107 101309 101915 103111 103414 103818 105014 105115 106016 108828 110411 111312 111716 113619 113922 114419 115320 116524 117122 118528 118730 118932 120111 122317 122620 123117 123925 124422 125525 126325 127630 127933 128127 128632 129028 130013 130316 131217 131722 133019 133928 135225 135932 136833 138534 139637 140925 144832 146432 147737 148335 148840 149337 149539 149741 151223 151526 151627 153025 154734 156637 159340 160123 161731 162733 163129 176542 178950 188347 189450 190031 192540 196750 198451 199655 201111 208226 211417 211720 212318 214423 221319 239944 245333 280739 298051 366446 397760 414229 499566 654754 672756 751348 756055 792564 856766 857263 899885" #insert correct subject IDs here

for sub in ${SUBs[@]}
do

##extend loop for all files per subject
imageRL="rfMRI_REST1_RL_hp2000_clean3mm_s_${sub}.nii.gz"

echo preprocessing functional data from participant ${sub} ; nice nohup vpreprocess -in ${VOLdir}/${imageRL} -out ${VOLdir}/rfMRI_REST1_RL_hp2000_clean3mm_s_${sub}_pre.v -minval 1000

################### ECM
echo computing ECM of participant ${sub} ;  nice nohup vecm -in ${VOLdir}/rfMRI_REST1_RL_hp2000_clean3mm_s_${sub}_pre.v  -mask ${MASK}  -out ./HCP_results/fullbrainECM/ECM_REST1_RL_${sub}.v -j 4 -metric ${ANALYSIS}

################### CONVERT
vnifti -in ./HCP_results/fullbrainECM/ECM_REST1_RL_${sub}.v -out ./HCP_results/fullbrainECM/ECM_REST1_RL_${sub}.nii

#remove vista files
rm ${VOLdir}/rfMRI_REST1_RL_hp2000_clean3mm_s_${sub}_pre.v
rm ./HCP_results/fullbrainECM/ECM_REST1_RL_${sub}.v

done
