USE AirQuality;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='co')
SELECT * FROM epa_co_2010;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='co')
SELECT * FROM epa_co_2011;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='co')
SELECT * FROM epa_co_2012;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='co')
SELECT * FROM epa_co_2013;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='co')
SELECT * FROM epa_co_2014;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='no2')
SELECT * FROM epa_no2_2010;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='no2')
SELECT * FROM epa_no2_2011;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='no2')
SELECT * FROM epa_no2_2012;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='no2')
SELECT * FROM epa_no2_2013;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='no2')
SELECT * FROM epa_no2_2014;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='oz')
SELECT * FROM epa_oz_2010;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='oz')
SELECT * FROM epa_oz_2011;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='oz')
SELECT * FROM epa_oz_2012;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='oz')
SELECT * FROM epa_oz_2013;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='oz')
SELECT * FROM epa_oz_2014;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='pb')
SELECT * FROM epa_pb_2010;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='pb')
SELECT * FROM epa_pb_2011;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='pb')
SELECT * FROM epa_pb_2012;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='pb')
SELECT * FROM epa_pb_2013;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='pm10')
SELECT * FROM epa_pm10_2010;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='pm10')
SELECT * FROM epa_pm10_2011;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='pm10')
SELECT * FROM epa_pm10_2012;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='pm10')
SELECT * FROM epa_pm10_2013;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='pm10')
SELECT * FROM epa_pm10_2014;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='pm25')
SELECT * FROM epa_pm25_2010;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='pm25')
SELECT * FROM epa_pm25_2011;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='pm25')
SELECT * FROM epa_pm25_2012;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='pm25')
SELECT * FROM epa_pm25_2013;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='pm25')
SELECT * FROM epa_pm25_2014;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='so2')
SELECT * FROM epa_so2_2010;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='so2')
SELECT * FROM epa_so2_2011;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='so2')
SELECT * FROM epa_so2_2012;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='so2')
SELECT * FROM epa_so2_2013;

INSERT INTO TABLE EPA_all
    PARTITION(pollutant='so2')
SELECT * FROM epa_so2_2014;

