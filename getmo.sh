#set -x
YR=$1
MO=`echo $2 | awk '{ printf("%02d\n", $1); }'`

echo "Getting UWyo data for ${YR}-${MO} `date`"

curl \
"http://weather.uwyo.edu/cgi-bin/sounding?region=naconf&TYPE=TEXT%3ALIST&YEAR=${YR}&MONTH=${MO}&FROM=0300&TO=0300&STNM=72572" \
-o atmosWyoSLC${YR}${MO}.dat

echo "Sleeping a minute..."
sleep 60

echo "Completed getting UWyo data for ${YR}-${MO} `date`"


