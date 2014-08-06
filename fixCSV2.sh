FL=$1
SRCDIR=/data/AirQuality/Originals/EPA
SRC=${SRCDIR}/${FL}/${FL}.dat
#TGTDIR=${SRCDIR}/EPA/Fixed
TGTDIR=/data/AirQuality/EPA/Fixed
TGT=${TGTDIR}/${FL}

time pig -param flnm=${SRC} -param tgt=${TGT} -f fixCSV.pig > fixCSV${FL}.log 2>&1 


