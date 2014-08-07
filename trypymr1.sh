hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
-file /root/AirQuality/datatymap.py  -mapper /root/AirQuality/datatymap.py \
-file /root/AirQuality/datatyred.py  -reducer /root/AirQuality/datatyred.py \
-input /data/AirQuality/EPA/Fixed/EPA_SO2_2013/part* -output /test/dt

 
