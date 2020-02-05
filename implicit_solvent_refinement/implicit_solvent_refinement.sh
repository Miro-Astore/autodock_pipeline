for i in $(ls -d ../../output/* );
do

rec_struct_name=$(echo $i | awk -F/ '{print $NF}' | awk -F- '{print $1}')_poses_001.pdb
#script will rename ligand to drug molecule name and also create psf files for system. easier said than done but should be possible. Probably easiest to break up ligands and proteins and then rebuild.
lig_name=$(echo $i | awk -F/ '{print $NF}' | awk -F- '{print $NF}')
lig_run_name=$(echo $lig_name | head -c 3 )^^ 
echo $lig_run_name
#this assumes we have a library of parameters for the drug molecules. note that you will have to choose between cgenff and match parameters.   
cat prep_pose_for_implicit_solvent.tcl | sed "s/DRUGNAME/$lig_run_name/ | sed "s^LIGTOP^/scratch/r16/ma2374/docking/autodock_pipeline/implicit_solvent_refinement/match_drug_tops/$lig_run_name.rtf" > /tmp/prep_pose for_implicit_solvent.tcl
vmd -dispdev text $rec_struct_name -e /tmp/prep_pose_for_implicit_solivent.tcl



done
