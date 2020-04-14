#!/bin/bash
module load vmd/1.9.3
source dock_run.sh
source extract_lig.sh

#cd to directory then run the docking find the writepdb file easy little function to check which typ of pdb to use

cwd=$(pwd)
for i in $(ls -d ../output/*/);
 do 
	 cd $i
	 echo $i
	 drug_name=$(echo $i | sed "s/\/$//g"  | awk -F/ '{print $NF}' | awk -F- '{print $NF}')
	 rec_name=$(echo $i | sed "s/\/$//g"  | awk -F/ '{print $NF}' | awk -F- '{print $1}')
	 echo $drug_name
	 echo $rec_name
	 extract_ligs $drug_name\_out.pdbqt $rec_name.pdb
	 cd $cwd
 done 
