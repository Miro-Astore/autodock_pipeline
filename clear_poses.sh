#!/bin/bash
#PBS -P r16
#PBS -l storage=scratch/r16
#PBS -q normal
#PBS -l ncpus=8
#PBS -m abe
#PBS -l walltime=1:00:00
#PBS -l mem=64GB
#PBS -l wd
#PBS -M yearlyboozefest@gmail.com
#!/bin/bash
module load vmd/1.9.3
source dock_run.sh
source extract_lig.sh

#cd to directory then run the docking find the writepdb file easy little function to check which typ of pdb to use

cwd=$(pwd)
for i in $(ls -d ../output/*);
 do 
	 cd $i
	 echo $i
	 rm *poses*[0-9]*.pdb
	 cd $cwd
 done 
