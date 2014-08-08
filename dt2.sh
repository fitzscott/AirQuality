set -x
DIR=$1

hadoop fs -rm -R -skipTrash /data/AirQuality/DataTypes/${DIR}

hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
-file /root/AirQuality/datatymap.py  -mapper /root/AirQuality/datatymap.py \
-file /root/AirQuality/datatyred.py  -reducer /root/AirQuality/datatyred.py \
-input /data/AirQuality/EPA/Fixed/${DIR}/part* \
-output /data/AirQuality/DataTypes/${DIR}

hadoop fs -cat /data/AirQuality/DataTypes/${DIR}/part* | cut -f2- -d'	' | awk -F'|' -v FL=${DIR} '{ for (i = 1; i <= NF; i++) print FL "|" i-1 "|" $i; }' > coltypes/${DIR}.txt

 
