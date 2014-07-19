REGISTER 'replaceCommas.jar' ;

%DEFAULT flnm /data/AirQuality/Originals/Fire/BPS/BPS.dat
%DEFAULT tgt /data/AirQuality/Fire/Fixed/BPS
%DEFAULT delim |

DEFINE replCommas airQuality.ReplaceCommas('$delim') ;

ldBPS = LOAD '$flnm' AS (wholedeal: chararray) ;

fixed = FOREACH ldBPS GENERATE replCommas(wholedeal) ;

rmf $tgt
STORE fixed INTO '$tgt' ;

