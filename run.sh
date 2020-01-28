#!/bin/bash
#source /data/phd/mutation_study_CFTR/docking/autodock_pipeline/dock_run.sh
source /home/562/ma2374/.bashrc

#do nested forloop over drugs and receptor directories and create pdbqt files for them. 
#then copy in new pdbs and pdbqts and the run configuration for that particular system and submit it 
#to the pbs queue

mkdir -p ../output

source prep_rec.sh
source prep_lig.sh

cwd=$(pwd)
for rec in $(ls ../receptors/*pdb);
do 
for lig in $(ls ../ligands/*pdb);
do 
#remember good sed delimeter when using directory paths in sed. conflicts with / delimeter
rec_name=$(echo $rec | sed "s^\.pdb^^g" | awk -F/ '{print $NF}') 
lig_name=$(echo $lig | sed "s^\.pdb^^g" | awk -F/ '{print $NF}') 

mkdir -p ../output/$rec_name-$lig_name
cp ../receptors/$rec_name.pdb  ../output/$rec_name-$lig_name/ 
cp ../ligands/$lig_name.pdb  ../output/$rec_name-$lig_name/ 
cp docking.pbs ../output/$rec_name-$lig_name

cd ../output/$rec_name-$lig_name/
echo $rec_name
echo $lig_name
prep_rec $rec_name.pdb
prep_lig $lig_name.pdb
sed -i "s/LIG/$lig_name/g" docking.pbs
sed -i "s/REC/$rec_name/g" docking.pbs

nsub docking.pbs

cd $cwd
done 
done 

