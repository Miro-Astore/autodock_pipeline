creating a semi automated pipeline for docking drugs to the CFTR protein \\

usage  dock_run rec.pdb "cent text" lig.pdb "flex_text"

by default this will only give you the best 5 poses in the directory above this one 'results' you need to edit grab_results.sh to 
get all of them. 

TODO. More flexibility in what autodock is told to do. Also add detection of protein size using vmd scripts. Also rewrite extract_lig.sh it is very slow because it makes a call to vmd for every pose. Program in a simple environmental variable for the root of the autodock_pipeline directory. Add cluster detection to spawn docking runs on cluster.

TODO. Switch from vmd based pdb manipulation and building to MDAnalysis.
TODO. Write proper documentation for workflow
TODO. Write functionality to go back to closed results vmd tab somehow. tricky.


testing
