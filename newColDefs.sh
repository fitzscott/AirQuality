# take the column names from cols and the column types from
# coltypes, paste them together and generate a table def.

# input name will be the uppercase (or mixed case, maybe) data file
# name.  The column files have lowercase names, so tweak a bit.

DATAFILE=$1
# original run (Fire) had different case for column files.
# second set (EPA) has same (upper) case
#COLFILE=`echo ${DATAFILE} | awk '{ print tolower($1); }'`
COLFILE=${DATAFILE}

echo "Redefining ${DATAFILE} table to AirQuality `date`"

. aq.env
#FIXDIR=${HDFSDIR}/Fire/Fixed
FIXDIR=/data/AirQuality/EPA/Fixed

# now make a Hive table with the calculated data types for columns.

cat > mkTbl${DATAFILE}.hql << EOF
USE AirQuality ;

DROP TABLE IF EXISTS ${DATAFILE} ;

CREATE EXTERNAL TABLE ${DATAFILE} 
(
`paste coltypes/${DATAFILE}.txt cols/${COLFILE}.txt | sed 's/|/ /g' | gawk -f mkdtcols.awk`
)
ROW FORMAT 
    DELIMITED FIELDS TERMINATED BY '|'
    LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '${FIXDIR}/${DATAFILE}'
;

ANALYZE TABLE ${DATAFILE}
    COMPUTE STATISTICS ;

SELECT COUNT(*) ${DATAFILE}_rowcnt
FROM ${DATAFILE}
;


EOF

hive -f mkTbl${DATAFILE}.hql > mkTbl${DATAFILE}.log 2>&1 
RC=$?
#cat mkTbl${DATAFILE}.hql

if [[ ${RC} -ne 0 ]]
then 
	echo "Error ${RC} - problem in $0 `date`"
	tail -10 mkTbl${DATAFILE}.log
fi

mv mkTbl${DATAFILE}.hql TblDefs
mv mkTbl${DATAFILE}.log logs

echo "Completed redef ${DATAFILE} table to AirQuality `date`"



