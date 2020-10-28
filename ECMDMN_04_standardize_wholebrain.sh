#!/bin/bash

VOLdir="./HCP_results/fullbrainECM"
SUBs="" #insert subject IDs here
mkdir ${VOLdir}/ECM_Z

echo concatenate 400 images #4 images for all 100 subjects

for sub in ${SUBs[@]}
do

LRimage1="REST1/ECM_REST1_LR_${sub}.nii"
RLimage1="REST1/ECM_REST1_RL_${sub}.nii"
LRimage2="REST2/ECM_REST2_LR_${sub}.nii"
RLimage2="REST2/ECM_REST2_RL_${sub}.nii"
    
images+="${VOLdir}/${LRimage1} ${VOLdir}/${RLimage1} ${VOLdir}/${LRimage2} ${VOLdir}/${RLimage2} "

done

echo compute whole brain mean and SD

fslmerge -t ${VOLdir}/400_merged.nii ${images}

MEAN=`fslstats ${VOLdir}/400_merged.nii -M`
SD=`fslstats ${VOLdir}/400_merged.nii -S`

for sub in ${SUBs[@]}
do

echo standardize images of ${sub}

LRimage1="REST1/ECM_REST1_LR_${sub}.nii"
RLimage1="REST1/ECM_REST1_RL_${sub}.nii"
LRimage2="REST2/ECM_REST2_LR_${sub}.nii"
RLimage2="REST2/ECM_REST2_RL_${sub}.nii"

fslmaths ${VOLdir}/${LRimage1} -sub ${MEAN}  ${VOLdir}/tmp_img1${sub}.nii ; fslmaths ${VOLdir}/tmp_img1${sub}.nii.gz -div ${SD}  ${VOLdir}/ECM_Z/ECM_REST1_LR_${sub}_Zwb.nii

fslmaths ${VOLdir}/${RLimage1} -sub ${MEAN}  ${VOLdir}/tmp_img2${sub}.nii ; fslmaths ${VOLdir}/tmp_img2${sub}.nii.gz -div ${SD}  ${VOLdir}/ECM_Z/ECM_REST1_RL_${sub}_Zwb.nii

fslmaths ${VOLdir}/${LRimage2} -sub ${MEAN}  ${VOLdir}/tmp_img3${sub}.nii ; fslmaths ${VOLdir}/tmp_img3${sub}.nii.gz -div ${SD}  ${VOLdir}/ECM_Z/ECM_REST2_LR_${sub}_Zwb.nii

fslmaths ${VOLdir}/${RLimage2} -sub ${MEAN}  ${VOLdir}/tmp_img4${sub}.nii ; fslmaths ${VOLdir}/tmp_img4${sub}.nii.gz -div ${SD}  ${VOLdir}/ECM_Z/ECM_REST2_RL_${sub}_Zwb.nii

rm ${VOLdir}/tmp_img1${sub}.nii.gz
rm ${VOLdir}/tmp_img2${sub}.nii.gz
rm ${VOLdir}/tmp_img3${sub}.nii.gz
rm ${VOLdir}/tmp_img4${sub}.nii.gz
done

echo average Z-images

for sub in ${SUBs[@]}
do

LRimage1Z="ECM_Z/ECM_REST1_LR_${sub}_Zwb.nii"
RLimage1Z="ECM_Z/ECM_REST1_RL_${sub}_Zwb.nii"
LRimage2Z="ECM_Z/ECM_REST2_LR_${sub}_Zwb.nii"
RLimage2Z="ECM_Z/ECM_REST2_RL_${sub}_Zwb.nii"

imagesZ+="${VOLdir}/${LRimage1Z} ${VOLdir}/${RLimage1Z} ${VOLdir}/${LRimage2Z} ${VOLdir}/${RLimage2Z} "

done

fslmerge -t ${VOLdir}/400_merged_Zwb.nii ${imagesZ} ; fslmaths ${VOLdir}/400_merged_Zwb.nii -Tmean ${VOLdir}/averageECM_400_Zwb.nii

