#for some reason vmd thinks the ligand is a protein
#todo: move this to md analysis python is better for this kind of thing
set sel [atomselect top "(within 4 of resname LIG) and not (resname LIG)" ]
set res [$sel get resid]
set res [lsort -unique -integer $res]
set name_sel [atomselect top "name CA and resid $res"]
set names [$name_sel get resname]
set outfile [open "/tmp/contact_results.txt" w+]
for {set i 0} {$i < [llength $res]} {incr i } {
set temp_res [lindex $res $i]
set temp_name [lindex $names $i]
puts -nonewline $outfile "$temp_name"
puts -nonewline $outfile "$temp_res "
}
puts $outfile ""
close $outfile
exit
