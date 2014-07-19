FL=$1
SRCDIR=/data/AirQuality/
SRC=${SRCDIR}/${FL}/${FL}.dat
TGTDIR=${SRCDIR}/Fire/Fixed
TGT=${TGTDIR}/${FL}

time pig -param flnm=${SRC} -param tgt=${TGT} -f fixCSV.pig > fixCSV${FL}.log 2>&1 


