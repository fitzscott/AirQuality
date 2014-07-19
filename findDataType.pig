-- findDataType.pig - take a file name and a column number, and
-- determine what the likely data type of that column in that file is.
-- Save results into an HDFS file for later consolidation & Hive table definition.

REGISTER 'hiveDTGuesser.jar'

DEFINE guessType airQuality.HiveDataTypeGuesser ;

%DEFAULT srcdir /data/AirQuality/Fire/Fixed
%DEFAULT srctbl BPS
%DEFAULT delim |
%DEFAULT fldnum 1

wholeSrc = LOAD '$srcdir/$srctbl' USING PigStorage('$delim');

-- take field # fldnum & run through the data type guesser
selCol = FOREACH wholeSrc GENERATE (chararray) '$srctbl' AS tblnm,
	(int) $fldnum AS fldnum,
	(int) guessType((chararray) $$fldnum) AS gTy ;
DESCRIBE selCol ;
 
-- get the max value for the data type - most general wins
grpTy = GROUP selCol BY (tblnm, fldnum) ;
DESCRIBE grpTy;
 
maxTy = FOREACH grpTy GENERATE 
		group.tblnm AS tblnm, 
		group.fldnum AS flnum, 
		MAX(selCol.gTy) AS colty;
DESCRIBE maxTy;
 
rmf /data/AirQuality/DataTypes/$srctbl/data$fldnum
STORE maxTy INTO '/data/AirQuality/DataTypes/$srctbl/data$fldnum' 
	USING PigStorage('$delim');
 
 
