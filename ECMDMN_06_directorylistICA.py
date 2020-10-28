subjectdir = "./DMN_ECM/100unrelated.txt" #textfile with subjectIDs
file = open(subjectdir, 'r')
lines = file.readlines()
newfile=open("ICAinputfile.txt","a") #name the new file you're creating, this will be your input file for the ICA


for line in lines:
   
   ##add all files to the loop that you want to include in the ICA, these are only REST1
    newfile.write("./HCP_data/smoothed_resampled/rfMRI_REST1_RL_hp2000_clean3mm_s_{}.nii.gz\n".format(line[:-1]))
    newfile.write("./HCP_data/smoothed_resampled/rfMRI_REST1_LR_hp2000_clean3mm_s_{}.nii.gz\n".format(line[:-1]))


newfile.close()

##check how the file looks like

#newfile=open("/Volumes/DMN_ECM/someunrelatedsubjects.txt","r")
#directories=newfile.read()
#print(directories)

    
