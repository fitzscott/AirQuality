#!/usr/bin/python

def setup(popstr=''):
    rangelist = []
    insidestring = False
    for cidx in range(len(popstr)):
        if popstr[cidx] == ' ':
            if insidestring:
                rangelist.append(cidx - 1)
                insidestring = False
            continue
        # we have a non-space character => column title string
        if not insidestring:
            insidestring = True
            rangelist.append(cidx)
    if len(rangelist) % 2 == 1:   # we have to have an even number of elements
        rangelist.append(len(popstr)-1)
    return rangelist
    
def getbox(rlist, idx):
    retval = -1
    for i in range(int(len(rlist) / 2)):
        if (idx >= rlist[2 * i]) and (idx <= rlist[2 * i + 1]):
            retval = i
    return retval

def getstart(rlist, idx):
    return rlist[2 * idx]

def getstop(rlist, idx):
    return rlist[2 * idx + 1]

def formatline(rlist, line, delim='|'):
    vallist = []
    currval = ''
    currpos = -1
    
    for ipop in range(int(len(rlist) / 2)):
        vallist.append('')
    for cidx in range(len(line)):
        maybebox = getbox(rlist, cidx)
        if maybebox != -1:
            currpos = maybebox
        if line[cidx] == ' ':
            if currpos != -1 and currval != '':
                #vallist.insert(currpos, currval)
                vallist[currpos] = currval
            currval = ''
            currpos = -1
            continue
        # we have a non-space character - add it
        currval += line[cidx]

    # catch the last value if the line did not end with a space
    if currval != '' and currpos != -1:
        vallist.insert(currpos, currval)
    return delim.join(vallist)[0:-1]

def testmorestrings():
    rl = setup('01234 6789 12345678 012 45678901 ')
    print(formatline(rl, '                     123456 89012'))
    print(formatline(rl, '  FLD1    FLD2         FLD3  FLD4          FLD5'))
    print(formatline(rl, '  FLD1    FLD2         FLD3  FLD4          FLD5   '))

def testfmtlines():
    rl = setup('  FLD1    FLD2         FLD3  FLD4          FLD5')
    line1 =             '   1        2           3      4            5'
    print(formatline(rl, line1))
    line2 =             '   1234     2           3      4            5'
    print(formatline(rl, line2))
    line3 =             '   1        2           3456   4            5'
    print(formatline(rl, line3))
    line4 =             '   1        2           3          4        5'
    print(formatline(rl, line4))
    line5 =             '   1        2           3                   5'
    print(formatline(rl, line5))
    line6 =             '            2           3                   5'
    print(formatline(rl, line6))

#testmorestrings()
#testfmtlines()
    
