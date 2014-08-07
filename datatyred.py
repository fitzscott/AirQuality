#!/usr/bin/python

import sys

dty = []
lncnt = 0
typesetter = {("INT", "INT"): "INT", ("INT", "FLOAT"): "FLOAT",
              ("INT", "DATE"): "STRING", 
              ("FLOAT", "INT"): "FLOAT", ("FLOAT", "FLOAT"): "FLOAT",
              ("FLOAT", "DATE"): "STRING", 
              ("DATE", "INT"): "STRING", ("DATE", "FLOAT"): "STRING",
              ("DATE", "DATE"): "DATE" }

for line in sys.stdin:
    lncnt += 1
    line = line.strip()
    val, cols = line.split('\t')
    collist = cols.split('|')
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

print ("%d\t%s") % (lncnt, "|".join(dty))
