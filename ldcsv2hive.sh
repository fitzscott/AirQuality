set -x

. aq.env

FLNM=$1
BSFL=`basename ${FLNM} .csv`
LNCNT=`wc -l ${FLNM} | awk '{ print $1 }'`
DATALINES=`echo ${LNCNT} - 1 | bc`

echo "Loading ${BSFL} table to AirQuality `date`"

hadoop fs -rm -R -skipTrash ${HDFSDIR}/${BSFL}
hadoop fs -mkdir ${HDFSDIR}/${BSFL}

# just store off the data, not the column headings
tail -${DATALINES} ${FLNM} | hadoop fs -put - ${HDFSDIR}/${BSFL}/${BSFL}.dat
hadoop fs -chmod -R ugo+rwx ${HDFSDIR}/${BSFL}

# now make a Hive table with the headings.
# should be a smart way to determine the column data types, but
# being lazy here - all strings.
# catch stray ctrl-M (line feed? carriage return?) and double-quotes
head -1 ${FLNM} | sed 's///g' | sed 's/"//g' | awk -F',' -f mkcols.awk > cols${BSFL}.txt

cat > mkTbl${BSFL}.hql << EOF
USE AirQuality ;

DROP TABLE IF EXISTS ${BSFL} ;

CREATE EXTERNAL TABLE ${BSFL} 
(
`cat cols${BSFL}.txt`
)
ROW FORMAT 
    DELIMITED FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '${HDFSDIR}/${BSFL}'
;

ANALYZE TABLE ${BSFL}
    COMPUTE STATISTICS ;

SELECT COUNT(*) ${BSFL}_rowcnt
FROM ${BSFL}
;


EOF

hive -f mkTbl${BSFL}.hql > mkTbl${BSFL}.log 2>&1 

rm cols${BSFL}.txt # mkTbl${BSFL}.hql

echo "Done loading ${BSFL} table to AirQuality `date`"

