#!/bin/bash
#echo 'receptor_name drug_name score' > /tmp/results.txt
echo '' > /tmp/results.txt

cwd=$(pwd)

for i in $(ls -d ../output/*/);
do
cd $i
#grab score from dock file 
score=$(cat docking.log | grep -A1 '\-\-\-\-\-\-+'  | tail -n 1  | awk '{print $2}' )
sys_name=$(pwd | awk -F/ '{print $NF}' | sed 's/\-/ /g' )
echo "$sys_name $score" >> /tmp/results.txt 
cd $cwd

#cat /tmp/results.txt | sort -k3 -n | tac > ../output/ranked.txt

done

cat /tmp/results.txt | sort -k3 -n | tee ../output/ranked.txt 
