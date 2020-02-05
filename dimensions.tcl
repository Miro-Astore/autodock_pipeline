set sel [atomselect top "resid 309 308 233 236 305 312 931 932 933 929 930 304 928 and protein"]
#set sel [atomselect top "all"]
set output [open "/tmp/minmax_output.txt" w ]
set vecs [measure minmax $sel]
set vec1  [ lindex $vecs 0 ] 
set vec2  [ lindex $vecs 1 ] 
set vec1  [vecscale 1.2 $vec1]
set vec2  [vecscale 1.2 $vec2]
puts $output [vecsub $vec2 $vec1]
close $output
set output [open "/tmp/center_output.txt" w ]
puts $output [measure center $sel]
close $output


exit
