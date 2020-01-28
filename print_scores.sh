#!/bin/bash
for i in $(cat ../list);
do
file=""
cd $i 
type=$(echo $i | awk -F/ '{print $NF}')
if [ $type = VX770 ]
	then 
	file=$( ls  | grep  vx770\_out\.pdbqt )
	cat $file | grep "VINA RESULT" | grep "^REMARK" | head -n 3  | awk '{print $4}' | tr '\n' ', ' | sed "s/\s//g"
	file2=$( ls | grep  -i -v vx770 )
	echo '' 
	readlink -f $( ls | grep  -i -v VX770 | grep pdbqt)
	fi
	if [ $type = GLPG1837 ]
	then 
	file=$( ls | grep  glpg1837\_out\.pdbqt )
	cat $file | grep "VINA RESULT" | grep "^REMARK" | head -n 3  | awk '{print $4}' | tr '\n' ', ' | sed "s/\s//g" 
	echo '' 
	readlink -f $( ls | grep  -i -v glpg1837 | grep pdbqt)
	fi
#echo $file
#echo $i
	read -n1 -r -p "Press space to continue...
	" key
	done
