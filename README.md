creating a semi automated pipeline for docking drugs to the CFTR protein \\

usage  dock_run rec.pdb "cent text" lig.pdb "flex_text"

by default this will only give you the best 5 poses you need to edit extract_ligs.sh to make it print all of them just delete the line that says a=5

