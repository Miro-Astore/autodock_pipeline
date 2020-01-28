#!/bin/bash
#you need to show the script the location of the vina and mgl tools install 
prep_rec () {
prep_rec_vina="/home/562/ma2374/mgltools_x86_64Linux2_1.5.6/bin/pythonsh  /home/562/ma2374/mgltools_x86_64Linux2_1.5.6/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_receptor4.py"


$prep_rec_vina -r $1 -U nphs_lps_waters 
name=$(echo $1 | sed 's/\.pdb//g')
python ../../autodock_pipeline/fix_charges.py $name.pdbqt
pwd
mv tempout.pdbqt $name.pdbqt

}
