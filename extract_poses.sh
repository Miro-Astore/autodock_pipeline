#!/bin/bash
module load vmd/1.9.3
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
	 #find the pdbqt that is not the drug molecule this will be the protein/receptor structure
	     recpdb=$(ls | grep -v -i vx770 | grep "pdbqt$" | sed "s/\.pdbqt/.pdb/g")
	     extract_ligs vx770_out.pdbqt $recpdb
	     
	 fi 


	 if [ $type = GLPG1837 ]
	 then 
	 #find the pdbqt that is not the drug molecule this will be the protein/receptor structure
	     recpdb=$(ls | grep -v -i vx770 | grep "pdbqt$" | sed "s/\.pdbqt/.pdb/g")
	     recpdb=$(ls | grep -v -i glpg1837 | grep "pdbqt$" | sed "s/\.pdbqt/.pdb/g")
	     extract_ligs glpg1837_out.pdbqt $recpdb
	 fi 

     done 
