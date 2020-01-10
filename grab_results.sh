#!/bin/bash
#source /data/phd/mutation_study_CFTR/docking/autodock_pipeline/dock_run.sh
#source /data/phd/mutation_study_CFTR/docking/autodock_pipeline/extract_lig.sh
source dock_run.sh
source extract_lig.sh
#tell script how many of the top results you want
num=5

#cd to directory then run the docking find the right pdb file easy little function to check which typ of pdb to use
cwd=$(pwd)
mkdir ../results

for i in $(cat ../list);
     do 
	 cd $i
	 echo $i
	 type=$(echo $i | awk -F/ '{print $NF}')
	 if [ $type = VX770 ]
	 then 
	     file=$(ls | grep -v -i vx770 | grep "pdbqt$" | sed "s/\.pdbqt//g")
	 fi
	 if [ $type = GLPG1837 ]
	 then 
	     file=$(ls | grep -v -i glpg1837 | grep "pdbqt$" | sed "s/\.pdbqt//g")
	 fi
	 prefix=$(pwd | awk -F/ '{print  $(NF-3),"_",$(NF-2),"_",$NF }' | sed "s/\s//g" )
	 #prefix=$(pwd | awk -F/ '{print  $(NF-2),"_",$NF }' | sed "s/\s//g" )
	 list=$(ls -v *pdb | grep $file\_poses_  | head -n $num)
	 echo $lise
	 echo $file
	 echo $prefix
	 mkdir $cwd/../results/$prefix
	 cp $list $cwd/../results/$prefix

	# cp $file $cwd/../results/
	# cd $cwd/../results
	# 
	# mv "$file" $prefix\_$file.pdb
     done 
