#!/usr/bin/python
from fixedwidthpr import setup, formatline
import sys

lineno = 0
for line in sys.stdin:
    if lineno == 0:
        startstop = setup(line)
        lineno += 1
    else:
        fstr = formatline(startstop, line).strip()
        if (fstr != ''):
            print(fstr)


