#for some reason vmd thinks the ligand is a protein
puts "what"
set sel [atomselect  top "(within 5 of resname LIG) and not (resname LIG)" ]
set res [$sel get resid]
set res [lsort -unique -integer $res]
puts $res 
exit
