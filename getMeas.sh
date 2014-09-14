# get the overall data for the station measurements
#set -x

DT=$1
FLNM=atmosWyoSLC${DT}.dat 

#hadoop fs -rm -R /data/BI/UWyo/StatMeasures
#hadoop fs -mkdir /data/BI/UWyo/StatMeasures
grep ":" ${FLNM} | grep -v "<" | tr -d ' ][' | sed -f sub.sed > datesColsVals.txt

#DATA1=`cat datesColsVals.txt | cut -f2 -d':' | tr '\n' '|'`
#echo ${DT}"|"${DATA1}

cat datesColsVals.txt | cut -f2 -d':' | tr '\n' '|' | awk -v dt=${DT} '{ L = length($0) - 1; print dt "|" substr($0, 1, L); }'

#grep ":" atmosWyoSLC*.dat | grep -v "<" | tr -d ' ][' | sed -f sub.sed | cut -c12-17,22- | hadoop fs -put - /data/BI/UWyo/StatMeasures/measures.txt

