#!/bin/bash
cd ../results/
for i in $(ls -d */);
#for i in $(ls -d */ | head -n 1 );
do 
cd $i
vmd -e ../../autodock_pipeline/viewing_results_state.vmd $( ls -v *pdb)
temp_vmdcuda=$VMDNOCUDA
temp_vmdoptix=$VMDNOOPTIX

export VMDNOCUDA=1
export VMDNOOPTIX=1
vmd -dispdev text  $(ls -v *pdb | head -n 1 ) -e ../../autodock_pipeline/calculate_close_residues.tcl  &> /dev/null
cat /tmp/contact_results.txt | sed "s/ALA/A/g" | sed "s/ARG/R/g" | sed "s/SER/S/g"  | sed "s/GLU/E/g"  | sed "s/ASP/D/g"  | sed "s/LYS/K/g"  | sed "s/HIS/H/g"  | sed "s/THR/T/g"  | sed "s/ASN/N/g"  | sed "s/GLN/N/g"  | sed "s/CYS/C/g"  | sed "s/GLY/G/g"  | sed "s/PRO/P/g"  | sed "s/VAL/V/g"  | sed "s/ILE/I/g"  | sed "s/LEU/L/g"  | sed "s/MET/M/g"  | sed "s/PHE/F/g"  | sed "s/TYR/Y/g"  | sed "s/TRP/W/g" 
export VMDNOCUDA=$temp_vmdcuda
export VMDNOOPTIX=$temp_vmdoptix
cd ../
done
