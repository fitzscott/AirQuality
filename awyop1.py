#!/usr/bin/python

import sys
import re

# set up some regular expressions for mapping
re_pre = re.compile(r"<[/]*PRE>")
re_dashes = re.compile(r"-----")

inpre = False
seendashes = False
printcnt = 0
done = False
doprint = False

for line in sys.stdin:
    if seendashes and inpre:
        if printcnt == 0:
            doprint = True
            printcnt += 1
            seendashes = False
        elif not done:
            doprint = True
        
    if re.match(re_pre, line):
        if inpre:
            inpre = False
            done = True
            doprint = False
        else:
            inpre = True
    elif doprint:
        print(line[0:-1])
        doprint = False

    if re.match(re_dashes, line):
        seendashes = True
        
