#!/bin/bash


extract_ligs () {
x=$(echo $1 | sed "s/\.pdbqt//g")
echo $x
cut -c-66 $x.pdbqt > $x.pdb

sed -i -e "s/^ENDBRANCH.*//g" -e "s/^ENDROOT.*//g" $x.pdb
a=$(cat $x.pdb | grep "ENDMDL"  | wc -l)
b=`expr $a - 2`

csplit -k -s -n 3 -f $x. $x.pdb '/^ENDMDL/+1' '{'$b'}'
#for i in $(seq 1 $b | tac );
#do 
#mv $x.pdb $((

b=`expr $a`
for i in $(seq  1 $b | tac );
do
    j=$(printf '%03d' "$(( $i - 1 ))")
    k=$(printf '%03d' "$i")
    echo $j
    f1=$( echo $x.$k)
    f2=$(echo $x.$j)
    mv $f2 $f1.pdb
    num=$(echo $f1 | grep -o \.[0-9][0-9][0-9] | grep "s/\.//g" )
    cat open.pdb $f1.pdb | grep -v '^END$' > open_out_$k.pdb
done
}
