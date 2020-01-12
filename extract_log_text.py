import re
import os 
import numpy as np 

#search through document then when you find the start partern ^## start wrtiing the line then when you find ^Writing output stop writing and go to next directory 

dir_list = np.loadtxt('list',dtype=str)
writing_or_reading=False
dir_pos=0
f=open("../log.log",'r' )
line=f.readline()
#for loop through log.log and when you get to a new ^Writing output go to next file in the list 
os.chdir(dir_list[dir_pos])
while line:
    line=f.readline()
    first_line=re.compile('^###')
    if first_line.search(line) and writing_or_reading == False:
        print ('yes')
        writing_or_reading=True
        w=open('docking.log','w+')
    last_line=re.compile('^Writing output')
    if last_line.search(line):
        print ('no')
        writing_or_reading=False
        w.close()
        dir_pos=dir_pos+1
        os.chdir(dir_list[dir_pos])
    if writing_or_reading:
        w.write(line)


