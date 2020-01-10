#just an example this is actually a sample of what is constructed and output by extract_lig.sh
mol new PDBNAME
set sel [atomselect top all]
$sel set resname LIG
$sel writepdb PDBNAME
exit
