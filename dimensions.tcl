set sel [atomselect top all]
set output [open "/tmp/minmax_output.txt" w ]
set vecs [measure minmax $sel]
set vec1  [ lindex $vecs 0 ] 
set vec2  [ lindex $vecs 1 ] 
puts $output [vecsub $vec2 $vec1]
close $output
set output [open "/tmp/center_output.txt" w ]
puts $output [measure center $sel]
close $output


exit
