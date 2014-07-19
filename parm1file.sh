#set -x
FLNM=$1

# assumes we have parameter files for each of the potential delimiters
ls parm_* | awk -v flnm=${FLNM} '{ print "time pig -m " $1 " -param flnm=" flnm " -f validateDelimiter.pig " }' | bash

