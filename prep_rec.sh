#!/bin/bash

prep_rec_vina="/home/miro/md/mgltools_1.5.6/bin/pythonsh  /home/miro/md/mgltools_1.5.6/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_receptor4.py"
for i in $(cat list | grep -v phospho);
do 
	 type=$(echo $i | awk -F/ '{print $NF}')
	 cd $i
	 echo $i
	 if [ $type = VX770 ]
	 then 
	     recpdb=$(ls | grep -v -i vx770 | grep "pdb$")
	     $prep_rec_vina -r $recpdb
	 fi 


	 if [ $type = GLPG1837 ]
	 then 
	     recpdb=$(ls | grep -v -i GLPG1837 | grep "pdb$")
	     $prep_rec_vina -r $recpdb

	 fi 
 done 
