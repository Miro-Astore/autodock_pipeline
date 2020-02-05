#!/bin/bash
# script for loading results into vmd and getting local contacts
cd ../output/
for i in $(echo $(ls -d ../output/* | grep vx770 && ls -d ../output/* | grep glpg1837) );
#for i in $(ls -d */ | head -n 1 ); #for testing to check if it will fail in the n = 1 case
do 
cd $i
echo $i
cat docking.log | sed -ne '/results/{:a' -e 'n;p;ba' -e '}' | head -n 5 
cd ../
done | less 

