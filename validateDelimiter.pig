-- validateDelimiter.pig - check a file's contents for a potential delimiter

%DEFAULT delim |
%DEFAULT delimname Pipe
%DEFAULT flnm BPS
%DEFAULT srcdir /data/AirQuality
%DEFAULT tgtdir /data/AirQuality/Delimiters/

file2chk = LOAD '$srcdir/$flnm/${flnm}.dat' AS (wholeLine: chararray) ;

delimFoundInLine = FOREACH file2chk GENERATE 
	INDEXOF(wholeLine, '$delim') AS dIdx;

delimFound = FILTER delimFoundInLine BY dIdx > -1 ;

delimGrp = GROUP delimFound ALL ; 

delimCount = FOREACH delimGrp GENERATE COUNT(delimFound) ;

rmf $tgtdir/$flnm/$delimname
STORE delimCount INTO '$tgtdir/$flnm/$delimname' ;


 
