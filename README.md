creating a semi automated pipeline for docking drugs a library of protein structures \\

usage  dock_run rec.pdb "cent text" lig.pdb "flex_text"

by default this will only give you the best 5 poses in the directory above this one 'results' you need to edit grab_results.sh to 
get all of them. 


IMPORTANT: Do not use a drug name that contains a - character. This will confuse the view results function because of the file structure of the output direectory.

TODO. More flexibility in what autodock is told to do. Also add detection of protein size using vmd scripts. Also rewrite extract_lig.sh it is very slow because it makes a call to vmd for every pose. Program in a simple environmental variable for the root of the autodock_pipeline directory. Add cluster detection to spawn docking runs on cluster.

TODO. Switch from vmd based pdb manipulation and building to MDAnalysis.
TODO. Write proper documentation for workflow
TODO. Write functionality to go back to closed results vmd tab somehow. tricky.
TODO. rework submission workflow. Make a file for a list of receptor structures and a list of drugs and construct the directories for each of them. if you don't want any make a file called exceptions.txt for pairs that we don't want. 
TODO. Add functionality for detection of existing pdbqt file. If it exists don't make a new one with the prep scripts. However, make an option to overide this. 

TODO. More sensible/extensible results exploration. We are more likely to want hit to lead detection rather than simple docking poses. 
- drug centered searches not receptor centered searches. 
