#!/bin/bash
cd ../results/
for i in $(ls -d */);
do 
cd $i
 vmd -e viewing_results_state.vmd $(cat ls -v *pdb)
cd ../
done
