#!/bin/bash
source ~/.bashrc 
#read in the list of directories for us and in each one 
#directories are kept in list 
for i in $(cat ../list);
do 
cd $i

#cp /scratch/r16/ma2374/docking/autodock_pipeline/docking.pbs . 
#ls | grep pdbqt
nsub docking.pbs
done
