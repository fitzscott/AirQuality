#set -x
NUM=$1

if [[ -z "${NUM}" ]]
then
	echo "Supply a number to append to the file"
	echo "Make sure it's not in this list:"
	hadoop fs -ls /data/AirQuality/Delimiters | grep -v part | grep -v drwx
	exit -1
fi

hadoop fs -ls -R /data/AirQuality/Delimiters | grep part | awk '{ print $5 " " $8 }' | sed 's/ //g' | awk -F'/' '{ if ($1 == 0) print $5 "|" $6 }' > al${NUM}.txt
hadoop fs -put al${NUM}.txt /data/AirQuality/Delimiters
hadoop fs -ls /data/AirQuality/Delimiters | grep drwx | awk '{ print "hadoop fs -rm -R -skipTrash " $8 }' | bash

