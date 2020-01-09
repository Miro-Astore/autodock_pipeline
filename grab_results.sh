#!/bin/bash
source /data/phd/mutation_study_CFTR/docking/autodock_pipeline/dock_run.sh
source /data/phd/mutation_study_CFTR/docking/autodock_pipeline/extract_lig.sh

#cd to directory then run the docking find the writepdb file easy little function to check which typ of pdb to use

for i in $(cat list);
     do 
	 cd $i
	 echo $i
	 prefix=$(pwd | awk -F/ '{print  $(NF-3),"_",$(NF-2),"_",$NF }' | sed "s/\s//g" )
	 file=$(ls | grep poses)
	 echo $file
	 echo $prefix

	 cp $file /data/phd/mutation_study_CFTR/results/
	 cd /data/phd/mutation_study_CFTR/results
	 
	 mv "$file" $prefix\_$file
     done 
