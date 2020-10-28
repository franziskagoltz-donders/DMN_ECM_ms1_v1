#!/bin/bash

##you first have to make a txt file with directories of all input files, see ECMDMN_06_directorylistICA.py for that

melodic -i ICAinputfile.txt -o ./HCP_results/groupICA20_100s_REST12 \
  --tr=0.72 --nobet -a concat \
  -m ./MNI152_T1_3mm_brain_mask.nii.gz \
  --report --Oall -d 20
