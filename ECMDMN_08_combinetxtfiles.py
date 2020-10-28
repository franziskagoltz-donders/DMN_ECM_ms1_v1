import os

##Combines the subject-wise output textfiles of ECMDMN_07_meanECofIC.sh to one textfile per component


components=[1, 2, 3, 4, 6, 7, 8, 14, 15, 19]
subjects=[100307, 100408, 101107, 101309, 101915, 103111, 103414, 103818, 105014, 105115, 106016, 108828, 110411, 111312, 111716, 113619, 113922, 114419, 115320, 116524, 117122, 118528, 118730, 118932, 120111, 122317, 122620, 123117, 123925, 124422, 125525, 126325, 127630, 127933, 128127, 128632, 129028, 130013, 130316, 131217, 131722, 133019, 133928, 135225, 135932, 136833, 138534, 139637, 140925, 144832, 146432, 147737, 148335, 148840, 149337, 149539, 149741, 151223, 151526, 151627, 153025, 154734, 156637, 159340, 160123, 161731, 162733, 163129, 176542, 178950, 188347, 189450, 190031, 192540, 196750, 198451, 199655, 201111, 208226, 211417, 211720, 212318, 214423, 221319, 239944, 245333, 280739, 298051, 366446, 397760, 414229, 499566, 654754, 672756, 751348, 756055, 792564, 856766, 857263, 899885] #insert subject IDs here


for c in components:
    for sub in subjects:
    	newfile = open("./HCP_results/FinalResults/meanEC_of_IC_weighted_Zwb/mean_EC_of_IC{}_Z.txt".format(c),"a")
    	dir = ".HCP_results/FinalResults/meanEC_of_IC_weighted_Zwb/meanEC_of_IC{0}_{1}_Z.txt".format(c,sub)
        file = open(dir, 'r')
        line = file.readlines()
        newfile.write("{}".format(line[0]))
    newfile.close()


##I used the command below to paste above created txt files columnwise into the terminal and copied them into one textfile with one component per column (such a textfile can then be imported to e.g. SPSS
  
#paste /media/newvol/HCP_results/FinalResults/meanEC_of_IC_weighted_Zwb/mean_EC_of_IC1_Z.txt /media/newvol/HCP_results/FinalResults/meanEC_of_IC_weighted_Zwb/mean_EC_of_IC2_Z.txt /media/newvol/HCP_results/FinalResults/meanEC_of_IC_weighted_Zwb/mean_EC_of_IC3_Z.txt /media/newvol/HCP_results/FinalResults/meanEC_of_IC_weighted_Zwb/mean_EC_of_IC4_Z.txt /media/newvol/HCP_results/FinalResults/meanEC_of_IC_weighted_Zwb/mean_EC_of_IC6_Z.txt /media/newvol/HCP_results/FinalResults/meanEC_of_IC_weighted_Zwb/mean_EC_of_IC7_Z.txt /media/newvol/HCP_results/FinalResults/meanEC_of_IC_weighted_Zwb/mean_EC_of_IC8_Z.txt /media/newvol/HCP_results/FinalResults/meanEC_of_IC_weighted_Zwb/mean_EC_of_IC14_Z.txt /media/newvol/HCP_results/FinalResults/meanEC_of_IC_weighted_Zwb/mean_EC_of_IC15_Z.txt /media/newvol/HCP_results/FinalResults/meanEC_of_IC_weighted_Zwb/mean_EC_of_IC19_Z.txt | column -s $'\t' -t
