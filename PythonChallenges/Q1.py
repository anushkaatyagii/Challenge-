#!/usr/bin/env python3
import re

datafile = open("../DataFiles/hosts.real")
outputfile = open("../DataFiles/outputhosts.real",'w')
count = 1
lines = []
ips = []
hostnames = []
for line in datafile:
    line = re.sub('([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})','',line)
    line = re.sub('#.*','',line)
    line = line.rstrip()
    if count != 1 and len(line)>0:
        line = line.split()
        line = ', '.join(line[1:]) + ' -> ' +line[0]
    else:
        line = "HostNames -> IP"
    count += 1
    lines.append(line)

outputfile.write('\n'.join(lines))
datafile.close()
outputfile.close()