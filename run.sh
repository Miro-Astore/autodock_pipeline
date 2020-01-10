#!/bin/bash
source /data/phd/mutation_study_CFTR/docking/autodock_pipeline/dock_run.sh
source /home/562/ma2374/.bashrc

#cd to directory then run the docking find the writepdb file easy little function to check which typ of pdb to use

for i in $(cat list);
    do 
	cd $i
	echo $i
	type=$(echo $i | awk -F/ '{print $NF}')
	echo $type
    if [ $type = VX770 ]
	then 
	recpdb=$(ls | grep -v -i vx770 | grep "pdb$")
	echo $recpdb
	cp /scratch/r16/ma2374/docking/docking.pbs . 
	echo "dock_run $recpdb 'all' vx770.pdb" >> docking.pbs
	nsub docking.pbs
    fi 


    if [ $type = GLPG1837 ]
    then 
	recpdb=$(ls | grep -v -i GLPG1837 | grep "pdb$")
	echo $recpdb

	cp /scratch/r16/ma2374/docking/docking.pbs .
	echo "dock_run $recpdb 'all' glpg1837.pdb | tee docking.log" >> docking.pbs
nsub docking.pbs

    fi 

done 
#cd /data/phd/mutation_study_CFTR/
#zip -r docking.zip docking
