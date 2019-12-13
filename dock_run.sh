dock_run () { 
source $HOME/.bashrc
prep_rec_vina="/home/miro/md/mgltools_1.5.6/bin/pythonsh  /home/miro/md/mgltools_1.5.6/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_receptor4.py"
prep_lig_vina="/home/miro/md/mgltools_1.5.6/bin/pythonsh /home/miro/md/mgltools_1.5.6/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_ligand4.py"

mkdir /dev/shm/docking_temp/

$prep_rec_vina -r $1
$prep_lig_vina -l $3

coor=$(vmd -dispdev text -startup /home/miro/python_scripts/dummy_vmdrc.tcl $1 -e /home/miro/python_scripts/origin.tcl 2> /dev/null | grep -E  ^-\|^[0-9]\|^{    )  
coor=$(echo $coor | sed 's/[{}]//g')


x=$(echo $coor | awk  '{print $1}')
y=$(echo $coor | awk  '{print $2}')
z=$(echo $coor | awk  '{print $3}')


rec=$(echo $1 | sed "s/\.pdb//g")
lig=$(echo $3 | sed "s/\.pdb//g")

if [ -z $4 ]
then
    vina --exhaustiveness 1000 --num_modes 100 --receptor $rec\.pdbqt --ligand $lig\.pdbqt --center_x $x --center_y $y --center_z $z --size_x 70 --size_y 70 --size_z 200 
else 


    echo "mol new $rec" > /dev/shm/docking_temp/flex_sc.tcl
    echo "set sel [atomselect top \'$4\']" >> /dev/shm/docking_temp/flex_sc.tcl
    echo "\$sel writepdb flex_sc.pdb" >> /dev/shm/docking_temp/flex_sc.tcl
    echo "exit" >> /dev/shm/docking_temp/flex_sc.tcl
    prep_rec_vina -r /dev/shm/docking_temp/flex_sc.pdb  
    rm /dev/shm/docking_temp/flex_sc.tcl
    rm /dev/shm/docking_temp/flex_sc.txt

    vina --exhaustiveness 1000 --num_modes 100 --receptor $rec\.pdbqt --flex flex_sc.pdbqt --ligand $lig\.pdbqt --center_x $x --center_y $y --center_z $z --size_x 70 --size_y 70 --size_z 200 
    fi 
    rm -r /dev/shm/docking_temp
    }

