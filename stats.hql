USE AirQuality ;

ANALYZE TABLE AtmosObsrv
    COMPUTE STATISTICS ;

SELECT
    substring(MeasYrMo, 1, 4) yr,
    COUNT(DISTINCT MeasYrMo) month_cnt,
    COUNT(*) row_cnt
FROM AtmosObsrv
GROUP BY substring(MeasYrMo, 1, 4) 
ORDER BY yr
;


