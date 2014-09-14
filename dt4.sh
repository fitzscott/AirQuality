#set -x
SUBJ=$1
DIR=$2

#PDELIM=`getDelim.sh ${DIR}`
PDELIM='|'

hadoop fs -rm -R -skipTrash /data/AirQuality/DataTypes/${DIR}

hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
-file /root/AirQuality/UWyo/datatymap.py \
-mapper /root/AirQuality/UWyo/datatymap.py \
-file /root/AirQuality/UWyo/datatyred.py  \
-reducer /root/AirQuality/UWyo/datatyred.py \
-input /data/AirQuality/${SUBJ}/Fixed/${DIR}/a*.dat \
-cmdenv DELIM=${PDELIM} \
-output /data/AirQuality/DataTypes/${DIR}

if [[ ! -e coltypes ]]
then
	mkdir coltypes
fi

hadoop fs -cat /data/AirQuality/DataTypes/${DIR}/part* | cut -f2- -d'	' | awk -F"${PDELIM}" -v FL=${DIR} '{ for (i = 1; i <= NF; i++) print FL FS i-1 FS $i; }' > coltypes/${DIR}.txt

 
