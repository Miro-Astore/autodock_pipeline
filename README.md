creating a semi automated pipeline for docking drugs to the CFTR protein \\

usage  dock_run rec.pdb "cent text" lig.pdb "flex_text"

by default this will only give you the best 5 poses in the directory above this one 'results' you need to edit grab_results.sh to 
get all of them. 

TODO. More flexibility in what autodock is told to do. Also add detection of protein size using vmd scripts. Also rewrite extract_lig.sh it is very slow because it makes a call to vmd for every pose.

