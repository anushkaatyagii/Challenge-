#!/usr/bin/env python3

datafile = open("../DataFiles/opra_example_regression.log")
outputfile = open("../DataFiles/question2.csv",'w')


flag1, flag2, flag3 = 0,0,0

lines = 'Symbol,TradePrice,TradeVolume\n'

for line in datafile:
    if line.find('Type: Trade') != -1:
        flag1 = 1
        flag2 = 1
        flag3 = 1
    elif flag1 + flag2 + flag3 != 0:
        if line.find('wTradePrice') != -1 and flag1 == 1:
            flag1 = 0
            lines += line.split('|')[-1].strip() + ','
        elif line.find('wTradeVolume') != -1 and flag2 == 1:
            flag2 = 0
            lines += line.split('|')[-1].strip() + '\n'
        elif line.find('wIssueSymbol') != -1 and flag3 == 1:
            flag3 = 0
            lines += line.split('|')[-1].strip() + ','

outputfile.write(lines)

datafile.close()
outputfile.close()