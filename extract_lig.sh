#!/bin/bash
#! extracts ligand from output and makes new pdb files. Haven't fixed for flexible chains yet.
extract_ligs () {

out=$(echo $2 | sed "s/\.pdb//g")
x=$(echo $1 | sed "s/\.pdbqt//g")
echo $x
cut -c-66 $x.pdbqt > $x.pdb
cat $out.pdb |  grep -v '^END$' > $out\_poses.pdb

sed -i -e "s/^ENDBRANCH.*//g" -e "s/^ENDROOT.*//g" $x.pdb
a=$(cat $x.pdb | grep "ENDMDL"  | wc -l)
b=`expr $a - 2`

csplit -k -s -n 3 -f $x. $x.pdb '/^ENDMDL/+1' '{'$b'}'

b=`expr $a`
tempvmd=$(echo $VMDNOCUDA)
tempopt=$(echo $VMDNOOPTIX)
export VMDNOCUDA=1
export VMDNOOPTIX=1

for i in $(seq  1 $b | tac );
do
	#i need to comment this i'm not sure why it works or what it's doing
    j=$(printf '%03d' "$(( $i - 1 ))")
    k=$(printf '%03d' "$i")
    echo $j
    f1=$( echo $x.$k)
    echo $out
    f2=$(echo $x.$j)
    mv $f2 $f1.pdb
    num=$(echo $f1 | grep -o \.[0-9][0-9][0-9] | grep "s/\.//g" )

	filename=$(readlink -f $f1.pdb)

	echo "mol new $filename" > /tmp/res_rename.tcl 
	echo 'set sel [atomselect top all]' >> /tmp/res_rename.tcl 
	echo '$sel set resname LIG' >> /tmp/res_rename.tcl 
	echo "\$sel writepdb $filename" >> /tmp/res_rename.tcl 
	echo 'exit' >> /tmp/res_rename.tcl

    vmd -dispdev text -e /tmp/res_rename.tcl 
	#needs to be j or k for pose numbering
    cat $f1\.pdb | grep -v '^END$' | grep -v '^ENDMDL' >> $out\_poses_$i.pdb
	echo "END" >> $out\_poses_$i.pdb
done
export VMDNOCUDA=$tempvmd
export VMDNOOPTIX=$tempopt
}
