# take the column names from cols and the column types from
# coltypes, paste them together and generate a table def.

# input name will be the uppercase (or mixed case, maybe) data file
# name.  The column files have lowercase names, so tweak a bit.
#set -x

SUBJ=$1
DATAFILE=$2
#PDELIM=`getDelim.sh ${DATAFILE}`
PDELIM='|'

COLFILE=${DATAFILE}

echo "Redefining ${DATAFILE} table to AirQuality `date`"

#. aq.env
FIXDIR=/data/AirQuality/${SUBJ}/Fixed

# now make a Hive table with the calculated data types for columns.

cat > mkTbl${DATAFILE}.hql << EOF
USE AirQuality ;

DROP TABLE IF EXISTS ${DATAFILE} ;

CREATE EXTERNAL TABLE ${DATAFILE} 
(
`paste coltypes/${DATAFILE}.txt cols/${COLFILE}.txt | sed "s/${PDELIM}/ /g" | gawk -f mkdtcols2.awk`
)
ROW FORMAT 
    DELIMITED FIELDS TERMINATED BY '${PDELIM}'
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
cat mkTbl${DATAFILE}.hql

if [[ ${RC} -ne 0 ]]
then 
	echo "Error ${RC} - problem in $0 `date`"
	tail -10 mkTbl${DATAFILE}.log
fi

mv mkTbl${DATAFILE}.hql TblDefs
mv mkTbl${DATAFILE}.log logs

echo "Completed redef ${DATAFILE} table to AirQuality `date`"



