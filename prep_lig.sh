#!/bin/bash
#you need to show the script the location of the vina and mgl tools install 
prep_lig ()  {
prep_lig_vina="/home/562/ma2374/mgltools_x86_64Linux2_1.5.6/bin/pythonsh  /home/562/ma2374/mgltools_x86_64Linux2_1.5.6/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_ligand4.py"

$prep_lig_vina -l $1 -U nphs_lps_waters 

}
