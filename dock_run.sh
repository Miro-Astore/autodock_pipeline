dock_run () { 
	#remove on non-cluster environment otherwise i guess you have to use spack or something lol good luck. Should probably move this to MDAnalysis too 
	#TODO make this more mobile and modular. make the dummy_vmdrc.tcl option something sensible rather than an absolute path
module load vmd/1.9.3

###preperation funcatinality now taken care of by separate script

#prep_rec_vina="$HOME/mgltools_x86_64Linux2_1.5.6/bin/pythonsh  $HOME/mgltools_x86_64Linux2_1.5.6/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_receptor4.py"
#prep_lig_vina="$HOME/mgltools_x86_64Linux2_1.5.6/bin/pythonsh $HOME/mgltools_x86_64Linux2_1.5.6/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_ligand4.py"
#$prep_rec_vina -r $1
#$prep_lig_vina -l $3

#make the center and length detections of the box dynamic in the same script. just write to separate files.
vmd -dispdev text -startup /scratch/r16/ma2374/docking/autodock_pipeline/dummy_vmdrc.tcl $1 -e /scratch/r16/ma2374/docking/autodock_pipeline/dimensions.tcl
cat /tmp/center_output.txt
cat /tmp/minmax_output.txt
coor=$(cat /dev/shm/center_output.txt)
#coort=$(echo $coor | sed 's/[{}]//g')
#echo "got here"
#echo "$coort"

#getting system origins
x=$(cat /tmp/center_output.txt | awk  '{print $1}')
y=$(cat /tmp/center_output.txt | awk  '{print $2}')
z=$(cat /tmp/center_output.txt | awk  '{print $3}')

#getting system dimensions 
lx=$(cat /tmp/minmax_output.txt | awk  '{print $1}')
ly=$(cat /tmp/minmax_output.txt | awk  '{print $2}')
lz=$(cat /tmp/minmax_output.txt | awk  '{print $3}')

rec=$(echo $1 | sed "s/\.pdbqt//g")
rec=$(echo $rec | sed "s/\.pdb//g")
lig=$(echo $3 | sed "s/\.pdbqt//g")
lig=$(echo $lig | sed "s/\.pdb//g")

if [ -z $4 ]
then
    vina --exhaustiveness 1000 --num_modes 100 --receptor $rec\.pdbqt --ligand $lig\.pdbqt --center_x $x --center_y $y --center_z $z --size_x $lx --size_y $ly --size_z $lz  
else 


    echo "mol new $rec" > /dev/shm/docking_temp/flex_sc.tcl
    echo "set sel [atomselect top \'$4\']" >> /dev/shm/docking_temp/flex_sc.tcl
    echo "\$sel writepdb flex_sc.pdb" >> /dev/shm/docking_temp/flex_sc.tcl
    echo "exit" >> /dev/shm/docking_temp/flex_sc.tcl
    prep_rec_vina -r /dev/shm/docking_temp/flex_sc.pdb  
    rm /dev/shm/docking_temp/flex_sc.tcl
    rm /dev/shm/docking_temp/flex_sc.txt

    vina --exhaustiveness 1000 --num_modes 100 --receptor $rec\.pdbqt --flex flex_sc.pdbqt --ligand $lig\.pdbqt --center_x $x --center_y $y --center_z $z --size_x $lx --size_y $ly --size_z $lz 
    fi 
    rm -r /dev/shm/docking_temp
    }

