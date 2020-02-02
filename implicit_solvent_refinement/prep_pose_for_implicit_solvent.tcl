#note the convention for drug resname assignment will be caps of the first 3 characters of its chemical name.
#eg the drug vx770 becomes VX7
#we will assume that the cgenff formalisms and the match formalisms will be solved separately and solved in their individuals top files.
#assume that the top file is local but it will not be on github because it's not distributable under and mit license.
#it is up to the user to procure/create their own topology file. similar to charmm36m's files referred to in this script as well.
#we're going to need  python script that detects and fixes atom names according to the topology otherwise this particular part of the pipeline is going to be fairly useless/cumbersome.
package require tcl
file mkdir psf_buildfiles/

set sel [atomselect top "resname LIG"]
$sel set resname DRUGNAME

#we need to remove duplicated atom names or else all is lost (when we try to make the psf file) 

$sel writepdb psf_buildfiles/lig.pdb

resetpsf 

set sel [atomselect top "name Mg"]
$sel set name MG
$sel set resname MG
$sel writepdb psf_buildfiles/MG.pdb

resetpsf
topology /home/562/ma2374/c36_params/toppar/toppar_water_ions.str
segment MG {
	pdb psf_buildfiles/MG.pdb
}
coordpdb psf_buildfiles/MG.pdb MG
writepsf psf_buildfiles/MG.psf
writepdb psf_buildfiles/MG.pdb
resetpsf 

set sel [atomselect top "resname ATP"]
$sel writepdb psf_buildfiles/ATP.pdb

resetpsf
topology /home/562/ma2374/c36_params/toppar/top_all36_cgenff.rtf
segment ATP {
	pdb psf_buildfiles/ATP.pdb
}
coordpdb psf_buildfiles/ATP.pdb ATP
writepsf psf_buildfiles/ATP.psf
writepdb psf_buildfiles/ATP.pdb

resetpsf 

#when we're working without a psf file the protein macro in vmd's atomselect can behave strangely so it's safer just to enumerate all the residues. 
set sel [atomselect top "resid 1 to 700  and resname ARG SER GLU GLN TRP CYS HIS HSD LYS THR ASN GLY PRO ALA ILE LEU MET PHE TYR VAL ASP"]
$sel writepdb psf_buildfiles/AP1.pdb

resetpsf
topology /home/562/ma2374/c36_params/toppar/top_all36_prot.rtf
segment AP1 {
	pdb psf_buildfiles/protein.pdb
}
coordpdb psf_buildfiles/AP1.pdb AP1
writepsf psf_buildfiles/AP1.psf
writepdb psf_buildfiles/AP1.pdb

resetpsf 

set sel [atomselect top "resid 701 to 2000  and resname ARG SER GLU GLN TRP CYS HIS HSD LYS THR ASN GLY PRO ALA ILE LEU MET PHE TYR VAL ASP"]
$sel writepdb psf_buildfiles/BP1.pdb

resetpsf
topology /home/562/ma2374/c36_params/toppar/top_all36_prot.rtf
segment BP1 {
	pdb psf_buildfiles/BP1.pdb
}
coordpdb psf_buildfiles/BP1.pdb BP1
writepsf psf_buildfiles/BP1.psf
writepdb psf_buildfiles/BP1.pdb


resetpsf
readpsf psf_buildfiles/AP1.psf
coordpdb psf_buildfiles/AP1.pdb
readpsf psf_buildfiles/BP1.psf
coordpdb psf_buildfiles/BP1.pdb
readpsf psf_buildfiles/MG.psf
coordpdb psf_buildfiles/MG.pdb
readpsf psf_buildfiles/ATP.psf
coordpdb psf_buildfiles/ATP.pdb
writepsf psf_buildfiles/merged.psf
writepdb pdb_buildfiles/merged.pdb

resetpsf 
mol delete all 

#here what we want to do is align the template drug molecule (i guess specified externally ) to the docked pose. If an atom is within 0.3 of the atom in the template then rename the atom docked ligand to the corresponding name in the template topoology. For the hydrogens that aren't included in the polar model just leave them free and merge them into the docked model. Then build the psf file for implicit solvent refinement.
#
#
#mol new TEMPLATEPSF
#mol addfille TEMPLATEPDB
mol new 
mol addfille TEMPLATEPDB

mol new psf_buildfiles/lig.pdb
set sel [atomselect top all ] 


mol delete all 

resetpsf
#topology LIGTOP
topology /scratch/r16/ma2374/docking/drugs/match_vx770.rtf
segment LIG {
	pdb psf_buildfiles/lig.pdb
}
coordpdb psf_buildfiles/lig.pdb LIG
writepsf psf_buildfiles/lig.psf
writepdb psf_buildfiles/lig.pdb
