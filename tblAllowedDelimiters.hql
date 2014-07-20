USE AirQuality ;

DROP TABLE IF EXISTS AllowedDelimiters ;

CREATE EXTERNAL TABLE AllowedDelimiters 
(
    tblnm STRING,
    delimnm STRING
)
ROW FORMAT 
    DELIMITED FIELDS TERMINATED BY '|'
    LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/data/AirQuality/Delimiters/'
;

ANALYZE TABLE AllowedDelimiters
    COMPUTE STATISTICS ;

SELECT COUNT(*) AllowedDelimiters_rowcnt
FROM AllowedDelimiters
;

SELECT DISTINCT tblnm
FROM AllowedDelimiters
;


