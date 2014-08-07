#!/usr/bin/python

import sys
import re

i = 0
# set up some regular expressions for mapping
re_int = re.compile(r"[-+]*\d+$")
re_float = re.compile(r"[-+]*\d*\.\d*$")
re_date = re.compile(r"[1-2]\d{3}-[01][0-9]-[0-3][0-9]$")

for line in sys.stdin:
    i += 1
    line = line.strip()
    cols = line.split('|')
    retval = ""
    for col in cols:
        if re.match(re_int, col):
            dty = "INT"
        elif re.match(re_float, col):
            dty = "FLOAT"
        elif re.match(re_date, col):
            dty = "DATE"
        else:
            dty = "STRING"
        if (retval != ""):
            retval += "|"
        retval += dty
    print ('%d\t%s') % (i, retval)

