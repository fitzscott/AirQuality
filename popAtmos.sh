YRMO=$1

echo "$0: Populating AtmosObs for ${YRMO} `date`"

cat > pop${YRMO}.hql << EOF
USE AirQuality ;

INSERT INTO TABLE AtmosObs 
SELECT *
FROM 
(
SELECT *
FROM StatMeasures
WHERE MeasYrMo = '${YRMO}'
) sm
    CROSS JOIN atmosWyoSLC${YRMO}
;

ANALYZE TABLE AtmosObs
    COMPUTE STATISTICS ;

SELECT COUNT(*) StatMeasures_rowcnt
FROM AtmosObs
;
EOF

echo "$0: Script to run:"
cat pop${YRMO}.hql

hive -S -f pop${YRMO}.hql
RC=$?
if [[ ${RC} -eq 0 ]]
then
	rm pop${YRMO}.hql
fi

echo "$0: Completed AtmosObs for ${YRMO} `date`"

exit ${RC}



