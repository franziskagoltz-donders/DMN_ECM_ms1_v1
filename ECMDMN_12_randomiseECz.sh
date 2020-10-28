#!/bin/bash

##input is 4D image of all images, 1000000 permutations were performed and multiple comparisons were corrected with TFCE

randomise -i ./ECM_merged100_Zwb.nii.gz -o OneSampT -1 –T -n 1000000
