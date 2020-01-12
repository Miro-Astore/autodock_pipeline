dock_run () { 
	#remove on non-cluster environment otherwise i guess you have to use spack or something lol good luck. Should probably move this to MDAnalysis too 
module load vmd/1.9.3

prep_rec_vina="$HOME/mgltools_x86_64Linux2_1.5.6/bin/pythonsh  $HOME/mgltools_x86_64Linux2_1.5.6/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_receptor4.py"

prep_lig_vina="$HOME/mgltools_x86_64Linux2_1.5.6/bin/pythonsh $HOME/mgltools_x86_64Linux2_1.5.6/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_ligand4.py"

#$prep_rec_vina -r $1
$prep_lig_vina -l $3
vmd -dispdev text -startup /scratch/r16/ma2374/docking/autodock_pipeline/dummy_vmdrc.tcl $1 -e /scratch/r16/ma2374/docking/autodock_pipeline/origin2.tcl
cat /dev/shm/center_output.txt
coor=$(cat /dev/shm/center_output.txt)
coort=$(echo $coor | sed 's/[{}]//g')
echo "got here"
echo "$coort"

x=$(echo $coort | awk  '{print $1}')
y=$(echo $coort | awk  '{print $2}')
z=$(echo $coort | awk  '{print $3}')


rec=$(echo $1 | sed "s/\.pdb//g")
lig=$(echo $3 | sed "s/\.pdb//g")

if [ -z $4 ]
then
    vina --exhaustiveness 1000 --num_modes 100 --receptor $rec\.pdbqt --ligand $lig\.pdbqt --center_x $x --center_y $y --center_z $z --size_x 85 --size_y 85 --size_z 150  
else 


    echo "mol new $rec" > /dev/shm/docking_temp/flex_sc.tcl
    echo "set sel [atomselect top \'$4\']" >> /dev/shm/docking_temp/flex_sc.tcl
    echo "\$sel writepdb flex_sc.pdb" >> /dev/shm/docking_temp/flex_sc.tcl
    echo "exit" >> /dev/shm/docking_temp/flex_sc.tcl
    prep_rec_vina -r /dev/shm/docking_temp/flex_sc.pdb  
    rm /dev/shm/docking_temp/flex_sc.tcl
    rm /dev/shm/docking_temp/flex_sc.txt

	#these sizes are specific to cftr. Need to encorporate system size detection into mdanalysis or vmd (deprecate)

    vina --exhaustiveness 1000 --num_modes 100 --receptor $rec\.pdbqt --flex flex_sc.pdbqt --ligand $lig\.pdbqt --center_x $x --center_y $y --center_z $z --size_x 85 --size_y 85 --size_z 150 
    fi 
    rm -r /dev/shm/docking_temp
    }

