USE AirQuality ;

DROP TABLE IF EXISTS EPA_PM10_2014 ;

CREATE EXTERNAL TABLE EPA_PM10_2014 
(
    date STRING,
    aqs_site_id STRING,
    poc INT,
    daily_mean_pm10_concentration INT,
    units STRING,
    daily_aqi_value DOUBLE,
    daily_obs_count INT,
    percent_complete DOUBLE,
    aqs_parameter_code INT,
    aqs_parameter_desc STRING,
    csa_code STRING,
    csa_name STRING,
    cbsa_code INT,
    cbsa_name STRING,
    state_code INT,
    state STRING,
    county_code INT,
    county STRING,
    site_latitude DOUBLE,
    site_longitude DOUBLE
)
ROW FORMAT 
    DELIMITED FIELDS TERMINATED BY '|'
    LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION '/data/AirQuality/EPA/Fixed/EPA_PM10_2014'
;

ANALYZE TABLE EPA_PM10_2014
    COMPUTE STATISTICS ;

SELECT COUNT(*) EPA_PM10_2014_rowcnt
FROM EPA_PM10_2014
;


