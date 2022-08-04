#!/usr/bin/env python3

datafile = open("../DataFiles/WindowsEventLog.csv")
q3file = open("../DataFiles/Q3Errors.txt",'w')
q3file1 = open("../DataFiles/Q3Warnings.txt",'w')

errors = ''
warnings = ''
process_count = {}
for line in datafile:
    if line.find('Error:') != -1 or line.find('reason: Error') != -1:
        errors += line
    
    if line.find('Warning:') != -1:
        warnings += line
        process = line.split(',')[2]
        if process_count.get(process):
            process_count[process] += 1
        else:
            process_count[process] = 1

q3file.write(errors)
q3file1.write(warnings)

process_count = sorted(process_count.items(), key=lambda kv: kv[1],reverse = True)

print("The top two applications needing attention are: ",process_count[0][0],',',process_count[1][0])


q3file.close()
q3file1.close()
datafile.close()