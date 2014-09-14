FLNM=$1
BSFL=`basename ${FLNM} .dat`

TGTDIR=/data/AirQuality/UWyo/Fixed

echo "Loading ${BSFL} table to AirQuality `date`"

cat ${FLNM} | awyop1.py > fx${FLNM}

LNCNT=`wc -l fx${FLNM} | awk '{ print $1 }'`
DATALINES=`echo ${LNCNT} - 1 | bc`

head -1 fx${FLNM} | awk -f mkcols.awk > cols/${BSFL}.txt
hadoop fs -rm -skipTrash -R ${TGTDIR}/${BSFL}
hadoop fs -mkdir ${TGTDIR}/${BSFL}
cat fx${FLNM} | rdfixwrtdelim.py | hadoop fs -put - ${TGTDIR}/${BSFL}/${BSFL}.dat
hadoop fs -chmod -R ugo+rwx ${TGTDIR}/${BSFL}
rm fx${FLNM}

# now make a Hive table with the headings.

cat > mkTbl${BSFL}.hql << EOF
USE AirQuality ;

DROP TABLE IF EXISTS ${BSFL} ;

CREATE EXTERNAL TABLE ${BSFL} 
(
`cat cols/${BSFL}.txt`
)
ROW FORMAT 
    DELIMITED FIELDS TERMINATED BY '|'
    LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '${TGTDIR}/${BSFL}'
;

ANALYZE TABLE ${BSFL}
    COMPUTE STATISTICS ;

SELECT COUNT(*) ${BSFL}_rowcnt
FROM ${BSFL}
;

EOF

hive -f mkTbl${BSFL}.hql > mkTbl${BSFL}.log 2>&1 
RC=$?

echo "Done loading ${BSFL} table to AirQuality `date`"
exit ${RC}

