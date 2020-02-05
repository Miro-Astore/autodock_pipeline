#!/bin/bash
vmd_state=$(readlink -f temp.vmd)
export VMDNOCUDA=1
export VMDNOOPTIX=1
cd ../results/

for i in $(ls -d */ );
do
	cd $i
	#vmd -e $vmd_state  $(ls -v *pdb)
	vmd -dispdev text $(ls -v *pdb | head -n 1 ) -e ../calculate_close_residues.tcl
	cd ../
done

