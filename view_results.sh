#!/bin/bash
# script for loading results into vmd and getting local contacts
cd ../results/
for i in $(ls -d ../output/*);
#for i in $(ls -d */ | head -n 1 ); #for testing to check if it will fail in the n = 1 case
do 
cd $i
vmd -e ../../autodock_pipeline/viewing_results_state.vmd $( ls -v *pdb)
temp_vmdcuda=$VMDNOCUDA
temp_vmdoptix=$VMDNOOPTIX

rec_name=$(echo $i | awk -F/ '{print $NF}' | awk -F- '{print $1}')
lig_name=$(echo $i | awk -F/ '{print $NF}' | awk -F- '{print $NF}')

export VMDNOCUDA=1
export VMDNOOPTIX=1
vmd -dispdev text  $(ls -v *pdb | head -n 1 ) -e ../../autodock_pipeline/calculate_close_residues.tcl  &> /dev/null
cat /tmp/contact_results.txt | sed "s/ALA/A/g" | sed "s/ARG/R/g" | sed "s/SER/S/g"  | sed "s/GLU/E/g"  | sed "s/ASP/D/g"  | sed "s/LYS/K/g"  | sed "s/HIS/H/g"  | sed "s/THR/T/g"  | sed "s/ASN/N/g"  | sed "s/GLN/N/g"  | sed "s/CYS/C/g"  | sed "s/GLY/G/g"  | sed "s/PRO/P/g"  | sed "s/VAL/V/g"  | sed "s/ILE/I/g"  | sed "s/LEU/L/g"  | sed "s/MET/M/g"  | sed "s/PHE/F/g"  | sed "s/TYR/Y/g"  | sed "s/TRP/W/g" > /tmp/cat_results2.txt
readlink -f $(ls -v $recname\_poses_[0-9][0-9][0-9]* | head -n 1 ) >> /tmp/cat_results2.txt
#gedit /tmp/cat_results2.txt & 

export VMDNOCUDA=$temp_vmdcuda
export VMDNOOPTIX=$temp_vmdoptix
echo " $rec_name-$lig_name $(cat /tmp/cat_results2.txt) " 
vmd -e ../../autodock_pipeline/viewing_results_state.vmd $( ls -v $recname\_poses_[0-9][0-9][0-9]*)

cd ../
done
