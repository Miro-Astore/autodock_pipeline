#note the convention for drug resname assignment will be caps of the first 3 characters of its chemical name.
#eg the drug vx770 becomes VX7
#we will assume that the cgenff formalisms and the match formalisms will be solved separately and solved in their individuals top files.
#assume that the top file is local but it will not be on github because it's not distributable under and mit license.
#it is up to the user to procure/create their own topology file. similar to charmm36m's files referred to in this script as well.
#we're going to need  python script that detects and fixes atom names according to the topology otherwise this particular part of the pipeline is going to be fairly useless/cumbersome.
#ok screw the above. we are going to need systematic  way of dealing with atom typing so since we are dealing with small molecules that do not have *that many*  of the same element in them  we are just going to make an incrementing number after the element root name
mol new drug.pdb
package require autopsf
file mkdir psf_buildfiles/

set sel [atomselect top "resname LIG"]
$sel set resname VX7
set inds [$sel get index]
set names [$sel get name ]
set names [lsort -uniq $names]
echo $names
set num_names [llength $names]
set num_inds [llength $inds]
while {$num_names != $num_inds} {
	foreach name $names { 
		set t_sel [atomselect top "name $name"]
		set t_name [$t_sel get name]
		set num [llength $t_name]
		if { $num > 1 } {
			set t_name [lindex $t_name 0 ]
			#grab element/name
			regexp {[A-Z][0-9]*} $t_name name_root
			set  name_index [string range $name_root 1 end] 
			set  name_element [string index $name_root 0 ] 
			set name_index [expr  $name_index + 1 ]
			puts $name_element$name_index
			set t_index [$t_sel get index]
			set t_index [lindex $t_index end]
			set t_sel [atomselect top "index $t_index"]
			$t_sel set name $name_element$name_index
			$t_sel get name
		}

	}
	set inds [$sel get index]
	set names [$sel get name ]
	set names [lsort -uniq $names]
	set num_names [llength $names]
	set num_inds [llength $inds]
}

$sel writepdb ligand.pdb
$sel writepdb psf_buildfiles/lig.pdb

resetpsf
#topology top_all36_cgenff.rtf
#topology cgenff_vx770.str
topology ./match_vx770_backup.rtf

segment LIG {
	pdb psf_buildfiles/lig.pdb
}
coordpdb psf_buildfiles/lig.pdb LIG
writepsf psf_buildfiles/lig.psf
writepdb psf_buildfiles/lig.pdb
exit
