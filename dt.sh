# take an input directory, find how many columns that table has,
# and determine their data types.

#set -x

DIR=$1

echo "Running $0 for ${DIR} `date`"

FLNM=`ls cols | grep -iw ${DIR}`
COLCNT=`wc -l cols/${FLNM} | awk '{ print $1 }'`

yes | head -${COLCNT} | awk -v TBL=${DIR} 'BEGIN { x=0; } { print "pig -param srctbl=" TBL " -param fldnum=" x " -f findDataType.pig > findDataType" TBL x ".log 2>&1 "; x++; }' | bash 

hadoop fs -cat /data/AirQuality/DataTypes/${DIR}/data*/p* | sort -k2 -t'|' -n > coltypes/${DIR}.txt

echo "Completed $0 for ${DIR} `date`"

