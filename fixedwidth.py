#!/usr/bin/python

class StartStopList(list):
#    def __init__(self, ex_el, init_list=[]):
#        self.type = type(ex_el)
#        for element in init_list:
#            self.check(element)
        
    def __init__(self, popstr='', delim='|'):
        self.type = type(1)
        self.delim = delim
        insidestring = False
        for cidx in range(len(popstr)):
            if popstr[cidx] == ' ':
                if insidestring:
                    self.append(cidx - 1)
                    insidestring = False
                continue
            # we have a non-space character => column title string
            if not insidestring:
                insidestring = True
                self.append(cidx)
        if len(self) % 2 == 1:   # we have to have an even number of elements
            self.append(len(popstr)-1)
                
        
    def check(self, el, idx = -1):
        if type(el) != self.type:
            raise TypeError("Attempted to add element of incorrect type")
        if len(self) > 1 and self[idx] > el:
            raise ValueError("Added value must be greater than or equal to last value")
        
    #def __add__(self, el):
        #self.check(el)
        #self.append(el)
        
    #def __setitem__(self, idx, el):
        #self.check(el, idx - 1)
        #super[idx] = el
        
    def append(self, el):
        self.check(el)
        super().append(el)
        
    def __str__(self):
        i = 1
        retstr = ""
        for el in self:
            retstr += str(el)
            if i % 2:
                retstr += ":"
            else:
                retstr += " "
            i += 1
        return(retstr)
    
    def getbox(self, idx):
        retval = -1
        for i in range(int(len(self) / 2)):
            if (idx >= self[2 * i]) and (idx <= self[2 * i + 1]):
                retval = i
        return retval

    def len(self):
        return len(self)
    
    def getstart(self, idx):
        return self[2 * idx]
    
    def getstop(self, idx):
        return self[2 * idx + 1]

    def formatline(self, line):
        vallist = []
        currval = ''
        currpos = -1
        
        for ipop in range(int(len(self) / 2)):
            vallist.append('')
        for cidx in range(len(line)):
            maybebox = self.getbox(cidx)
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
        print(self.delim.join(vallist)[0:-1])
    
    @staticmethod        
    def testRun():
        ssl = StartStopList()
        ssl.append(0)
        ssl.append(1)
        ssl.append(5)
        ssl.append(20)
        ssl.append(40)
        ssl.append(60)

        print(ssl)

    @staticmethod        
    def testFail():
        ssl = StartStopList()
        ssl.append(0)
        ssl.append(1)
        ssl.append(5)
        ssl.append(20)
        ssl.append(15)  # will cause an error - must be monotonically increasing :)

        print(ssl)

    @staticmethod        
    def testbox():
        ssl = StartStopList()
        ssl.append(0)
        ssl.append(1)
        ssl.append(5)
        ssl.append(20)
        ssl.append(40)
        ssl.append(60)

        assert(ssl.getbox(1) == 0)
        assert(ssl.getbox(4) == -1)
        assert(ssl.getbox(15) == 1) 
        assert(ssl.getbox(55) == 2)
        assert(ssl.getbox(65) == -1)

    @staticmethod
    def teststrings():
        ssl1 = StartStopList('1 2 3 4 5')
        print(ssl1)
        ssl2 = StartStopList(' 1 2 3 4 5')
        print(ssl2)
        ssl3 = StartStopList('1 2 3 4 5 ')
        print(ssl3)
        ssl4 = StartStopList(' 1 2 3 4 5 ')
        print(ssl4)

    @staticmethod
    def testmorestrings():
        ssl1 = StartStopList('01234 6789 12345678 012 45678901 ')
        print(ssl1)
        ssl2 = StartStopList('                     123456 89012')
        print(ssl2)
        ssl3 = StartStopList('  FLD1    FLD2         FLD3  FLD4          FLD5')
        print(ssl3)
        ssl4 = StartStopList('  FLD1    FLD2         FLD3  FLD4          FLD5   ')
        print(ssl4)

def testfmtlines():
    ssl = StartStopList('  FLD1    FLD2         FLD3  FLD4          FLD5')
    line1 =             '   1        2           3      4            5'
    ssl.formatline(line1)
    line2 =             '   1234     2           3      4            5'
    ssl.formatline(line2)
    line3 =             '   1        2           3456   4            5'
    ssl.formatline(line3)
    line4 =             '   1        2           3          4        5'
    ssl.formatline(line4)
    line5 =             '   1        2           3                   5'
    ssl.formatline(line5)
    line6 =             '            2           3                   5'
    ssl.formatline(line6)

StartStopList.testRun()
#StartStopList.testFail()
StartStopList.testbox()
StartStopList.teststrings()
StartStopList.testmorestrings()

testfmtlines()
    
