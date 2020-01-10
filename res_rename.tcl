mol new PDBNAME
set sel [atomselect top all]
$sel set resname LIG
$sel writepdb PDBNAME
exit
