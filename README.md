# DMN_ECM_ms1_v1

#####THIS REPOSITORY IS UNDER CONSTRUCTION AND WILL SOON FEATURE THE SUPPORTING MATERIAL FOR A SCIENTIFIC ARTICLE#### 

This project is based on data of the 1200 subject release of the Human Connectome Project (HCP; http://www.humanconnectomeproject.org). Specifically, resting state fMRI data of 100 unrelated subjects were used (4 x 1200 timepoints per subject), which were scanned with a customized Siemens 3T Connectome Skyra scanner. Initial steps to access the data are described below.

I. Accessing the HCP data repository
To access the data base, it is necessary to create an account on the db.humanconnectome.org website. This is entirely free and possible for every student or researcher. Once registered, it is possible to log in to the data base and access the datasets needed, after accepting the open access terms. To be able to directly download data from the website, “Aspera connect” must be installed to your browser and it must be made sure that the selected disk provides enough storage. The amount of storage needed for every data set is indicated on the website. If a scripted download is considered or an exploration of the exact files is desired, the Amazon S3 access should be enabled by creating AWS credentials. This is possible by clicking the “Data Available on Amazon S3” icon under the desired dataset, which guides the user through the setup of creating the credentials. The AWS credentials consist of three parts: a login, a public access key, as well as a secret access key. With those credentials and for example “CyberDuck”, a free software client available for both Mac and Windows, the HCP data container on AWS can be accessed (see https://wiki.humanconnectome.org/display/PublicData/How+To+Connect+to+Connectome+Data+via+AWS for more instructions).

II. Choosing the data set
In our project, resting state FIX-denoised fMRI data in volumetric (rather than grayordinate) space were used for spatial group ICA and ECM. These datasets are preprocessed with the HCP minimal preprocessing pipelines as described in Glasser et al. 2013. Further, they are denoised by the ICA-FIX approach, following the ICA-FIX pipeline, which covers temporal preprocessing as well (Smith et al. 2013). All in all, the preprocessed volumetric data is gradient distortion corrected, motion corrected to a single-band reference image, registered to a T1w structural, EPI image distortion corrected, registered to MNI-152 standard space, global mean intensity normalized, brain masked, and minimally temporally high pass filtered (>2000s FWHM). In the present project, datasets were downloaded in volumetric MNI152 space rather than grayordinate CIFTI space, as LIPSIA is not compatible with the NIfTI-2 format. (Therefore, no volume-to-surface mapping had been applied to the data.) However, data in grayordinate space are spatially more precise and should be used if possible. Group ICA results in grayordinate space of 1200 subjects are also available on the repository.

III. Downloading the data
For the present project, we decided to use a UH-IaaS virtual Ubuntu Linux machine with 1TR volume storage and 16GB RAM. To download the files needed, a python script was used and supplemented by another script, which enabled us to download the files in batches as well as download the specific subjects we needed. The main script is created by Joke Durnez and was accessed via GitHub (https://github.com/jokedurnez/HCP_download). For the download script to work properly, the following steps are required:
1) Necessary modules need to be in place and otherwise downloaded. Modules needed for the script are os, tarfile, shutil, pandas, boto3, and botocore. Installation can for example be done with the pip install command.
2) The AWS command line interface must be downloaded (for more information, see https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html). For this, use e.g. pip install awscli --upgrade --user. 
3) Add the AWS CLI executable to your command line path, i.e. check the AWS CLI installation location and add it to your PATH variable (example: let “/Users/Franziska/.local/bin” be your install location, use export PATH=~/.local/bin:$PATH and source ~/.bash_profile to add it to your PATH variable). Afterwards, the version can be checked with aws --version.
4) Configure AWS with aws configure. You will need your AWS access key and secret access key for configuration. After this step, the credentials file will consist of the default user, called default. You can find the credentials file in ~/.aws
5) Add another user, called hcp, with aws configure --profile hcp and make sure your credentials file looks like this:

[hcp]    
aws_access_key_id = XXXXXX (insert your credentials here)

aws_secret_access_key = XXXXXX

[default]

aws_access_key_id = XXXXXX 

aws_secret_access_key = XXXXXX


IV. Identifying the files 
ICA FIX-denoised rsfMRI data can be found per subject and per run in the /MNINonLinear/Results directory of the HCP repository. Every subject has data from two sessions with two 15 minute runs each, which results in 1 hour of resting state data in total. Per session, one run was done in left-right (LR) phase encoding direction, one with right-left (RL) phase encoding. For this project, rsfMRI data in NIfTI-1 was used (“rfMRI_REST1_LR_hp2000_clean.nii.gz”; respectively for REST2 and RL phase encoding), due to incompatibility of NIfTI-2 with LIPSIA, the software used for ECM. These files are available in the “FIX extended” package on the HCP repository.

VI. Downloading the software, acquiring necessary files
To be able to execute all necessary analyses, the following software was used: FSL 6.0, MATLAB, and LIPSIA v3.1.0. As student or employee of the University of Bergen, information to obtain a license for MATLAB can be found on https://it.uib.no/en/Matlab. Information about the installation of FSL and SPM can be found on https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation (alternatively http://neuro.debian.net/pkgs/fsl-complete.html ) and https://en.wikibooks.org/wiki/SPM/Installation_on_64bit_Linux#SPM12, respectively. LIPSIA 3 can be downloaded from https://github.com/lipsia-fmri/lipsia. If a cloud machine is used, e.g. a MATE desktop for Ubuntu should be installed on the server machine (see e.g. https://linuxconfig.org/how-to-install-mate-desktop-on-ubuntu-18-04-bionic-beaver-linux). To connect to the desktop, x2go client must be installed on the (physical) client machine, x2go server must be installed on the server (the virtual machine). 

VII. Scripts
All scripts used for this project will be added to this repository. 

