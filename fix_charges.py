#script to readjust charges on the atp molecules in the system and add to magnesium. Short term fix. Should really readjust gasteiger charges algorithm ourselves. 
import sys

f=open(sys.argv[1],'r')
o=open('tempout.pdbqt','w')
lines=f.readlines()
for line in lines:
    res=line[17:20].strip()
    begin=line[0:5].strip()
    name=line[13:16]
    if (res=='ATP' and begin != 'TER') and (name=='O2B' or name =='O3G') :
        charge=line[69:75]
        charge=float(charge)
        charge=charge-0.249
        charge=(" %05.2f"%charge)
        charge=list(charge)
        line=list(line)
        line[69:75]=charge
        line=(''.join(line))
        o.write(line)


    elif (res.upper()=='MG' and begin != 'TER'):
        charge=line[69:76]
        charge="  2.00"
        charge=list(charge)
        line=list(line)
        line[69:75]=charge
        line=(''.join(line))
        o.write(line)

    else:
        o.write(line)


