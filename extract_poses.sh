#!/bin/bash
source dock_run.sh
source extract_lig.sh

#cd to directory then run the docking find the writepdb file easy little function to check which typ of pdb to use

for i in $(cat ../list);
     do 
	 cd $i
	 echo $i
	 type=$(echo $i | awk -F/ '{print $NF}')
	 echo $type
	 if [ $type = VX770 ]
	 then 
	     recpdb=$(ls | grep -v -i vx770 | grep "pdb$")
	     extract_ligs vx770_out.pdbqt $recpdb
	     
	 fi 


	 if [ $type = GLPG1837 ]
	 then 
	     recpdb=$(ls | grep -v -i GLPG1837 | grep "pdb$")
	     extract_ligs glpg1837_out.pdbqt $recpdb
	 fi 

     done 
