#!/bin/bash

######### Pearson's R correlation between two image volumes
## --- Compute the correlation from 1st principles
## --- i.e., account for the mask when determining which voxels toinclude
## --- in the computation
# Note that within the mask, we will treat 0's as valid data


## --- Compute the correlation from 1st principles
## --- i.e., account for the mask when determining which voxels to include
## --- in the computation
# Note that within the mask, we will treat 0's as valid data

VOLdir="" 
ECMdir="./fullbrainECM/ECM_Z"

components="01 02 03 04 06 07 08 14 19"

SUBs="100307 100408 101107 101309 101915 103111 103414 103818 105014 105115 106016 108828 110411 111312 111716 113619 113922 114419 115320 116524 117122 118528 118730 118932 120111 122317 122620 123117 123925 124422 125525 126325 127630 127933 128127 128632 129028 130013 130316 131217 131722 133019 133928 135225 135932 136833 138534 139637 140925 144832 146432 147737 148335 148840 149337 149539 149741 151223 151526 151627 153025 154734 156637 159340 160123 161731 162733 163129 176542 178950 188347 189450 190031 192540 196750 198451 199655 201111 208226 211417 211720 212318 214423 221319 239944 245333 280739 298051 366446 397760 414229 499566 654754 672756 751348 756055 792564 856766 857263 899885"

for c in ${components}
do
    echo this is component ${c}
    DMNdir="groupICA20_100s_REST12/melodic_IC_c00${c}.nii.gz"
    
    for sub in ${SUBs[@]}
    do
    img1="${VOLdir}/${ECMdir}/ECM_${sub}_Zwb.nii.gz"
    img2="$VOLdir/$DMNdir"
    mask="" #enter directory to whole brain mask

    M1=`fslstats $img1 -k $mask -m`
    M2=`fslstats $img2 -k $mask -m`

    fslmaths $img1 -sub $M1 -mas $mask demeaned1 -odt float
    fslmaths $img2 -sub $M2 -mas $mask demeaned2 -odt float
    fslmaths demeaned1 -mul demeaned2 demeaned_prod
    num=`fslstats demeaned_prod -k $mask -m`

    fslmaths demeaned1 -sqr demeaned1sqr
    fslmaths demeaned2 -sqr demeaned2sqr
    den1=`fslstats demeaned1sqr -k $mask -m`
    den2=`fslstats demeaned2sqr -k $mask -m`
    denprod=`echo "scale=4; sqrt($den1*$den2)" | bc -l`

    # The mean can be used instead of the sum because the
    # factor N/sqrt(N*N) will cancel
    true_r=$(echo "scale=4; $num/$denprod" | bc -l)
    echo "$true_r"
    done
done

