REGISTER 'replaceCommas.jar' ;

DEFINE replCommas airQuality.ReplaceCommas ;

%DEFAULT flnm /data/AirQuality/BPS/BPS.dat
%DEFAULT tgt /data/AirQuality/Fire/Fixed/BPS
 
ldBPS = LOAD '$flnm' AS (wholedeal: chararray) ;

fixed = FOREACH ldBPS GENERATE replCommas(wholedeal) ;

rmf $tgt
STORE fixed INTO '$tgt' ;

