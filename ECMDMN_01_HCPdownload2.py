##script for our download

import os

#1. get subjectlist with subjects you want to download

subjectdir = "/Volumes/DMN_ECM/100unrelated.txt"  #directory to subject ID file
file = open(subjectdir, 'r')
lines = file.readlines()
subjectlist=[]


for line in lines:
    subjectlist.append(int(line[:-1])) 

#2. execute HCP download script for those subjects or for part of subjects with e.g. "for s in subjectlist[:100]"

for s in subjectlist: 
    os.system("python ECMDMN_01_HCPdownload1.py --subject={} --out_dir=/Volumes/DMN_ECM/100independent".format(s))



