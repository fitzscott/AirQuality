#!/usr/bin/python

import sys
import os

dty = []
lncnt = 0
typesetter = {("INT", "INT"): "INT", ("INT", "DOUBLE"): "DOUBLE",
              ("INT", "DATE"): "STRING", 
              ("DOUBLE", "INT"): "DOUBLE", ("DOUBLE", "DOUBLE"): "DOUBLE",
              ("DOUBLE", "DATE"): "STRING", 
              ("DATE", "INT"): "STRING", ("DATE", "DOUBLE"): "STRING",
              ("DATE", "DATE"): "DATE" }

# Find delimiter from environment, if available
delim = os.getenv('DELIM', '|')

for line in sys.stdin:
    lncnt += 1
    line = line.strip()
    val, cols = line.split('\t')
    collist = cols.split(delim)
    if len(dty) == 0:
        for i in range(len(collist)):
            dty.append(collist[i])
    for j in range(len(collist)):
        if (dty[j] == "STRING"):    # string trumps all
            continue
        elif (collist[j] == "STRING"):
            dty[j] = "STRING"
            continue
        # really just want to try out the dictionary
        if (dty[j], collist[j]) in typesetter:
            dty[j] = typesetter[(dty[j], collist[j])]

print ("%d\t%s") % (0, delim.join(dty))
