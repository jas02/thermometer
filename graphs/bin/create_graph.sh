#!/bin/ash
#
#  Copyright (C) 2013 AlfaWolf s.r.o.
#  Lumir Jasiok
#  lumir.jasiok@alfawolf.eu
#  http://www.alfawolf.eu
#
#

EPOCH=`date +%s`
DAY='86400'
WEEK='604800'
MONTH='2678400'
YEAR='33053184'
START_DAILY=`expr $EPOCH - $DAY`
START_WEEKLY=`expr $EPOCH - $WEEK`
START_MONTHLY=`expr $EPOCH - $MONTH`
START_YEARLY=`expr $EPOCH - $YEAR`
LOAD_DAILY=`expr $EPOCH + 298`
HOME='/usr/local/share/graphs'
 
INTEMP_COLOR="#CC0000"
 

# Daily graph
/usr/bin/rrdtool graph $HOME/graphs/thermometer-sf-temperature-daily.png \
  --imgformat=PNG \
  --start=${START_DAILY} \
  --end=${EPOCH} \
  --title='Thermometer - Second Floor - Daily' \
  --base=1024 \
  --height=120 \
  --width=500 \
  --alt-autoscale-max \
  --lower-limit=0 \
  --vertical-label='degree  Celsius' \
  --slope-mode \
  --font TITLE:10: \
  --font AXIS:7: \
  --font LEGEND:8: \
  --font UNIT:7: \
  DEF:temp="$HOME/rrds/thermometer-sf-temperature.rrd":temperature:AVERAGE \
  AREA:temp$INTEMP_COLOR:"Temperature" \
  GPRINT:temp:LAST:"   Current\: %.1lf %s"  \
  GPRINT:temp:AVERAGE:"Average\: %.1lf %s"  \
  GPRINT:temp:MIN:"Min\: %.1lf %s"  \
  GPRINT:temp:MAX:"Max\: %.1lf %s\n"  
  
# Weekly graph
/usr/bin/rrdtool graph $HOME/graphs/thermometer-sf-temperature-weekly.png \
  --imgformat=PNG \
  --start=${START_WEEKLY} \
  --end=${EPOCH} \
  --title='Thermometer - Second Floor - Weekly' \
  --base=1024 \
  --height=120 \
  --width=500 \
  --alt-autoscale-max \
  --lower-limit=0 \
  --vertical-label='degree  Celsius' \
  --slope-mode \
  --font TITLE:10: \
  --font AXIS:7: \
  --font LEGEND:8: \
  --font UNIT:7: \
  DEF:temp="$HOME/rrds/thermometer-sf-temperature.rrd":temperature:AVERAGE \
  AREA:temp$INTEMP_COLOR:"Temperature" \
  GPRINT:temp:LAST:"   Current\: %.1lf %s"  \
  GPRINT:temp:AVERAGE:"Average\: %.1lf %s"  \
  GPRINT:temp:MIN:"Min\: %.1lf %s"  \
  GPRINT:temp:MAX:"Max\: %.1lf %s\n"

# Monthly graph
/usr/bin/rrdtool graph $HOME/graphs/thermometer-sf-temperature-monthly.png \
  --imgformat=PNG \
  --start=${START_MONTHLY} \
  --end=${EPOCH} \
  --title='Thermometer - Second Floor - Monthly' \
  --base=1024 \
  --height=120 \
  --width=500 \
  --alt-autoscale-max \
  --lower-limit=0 \
  --vertical-label='degree  Celsius' \
  --slope-mode \
  --font TITLE:10: \
  --font AXIS:7: \
  --font LEGEND:8: \
  --font UNIT:7: \
  DEF:temp="$HOME/rrds/thermometer-sf-temperature.rrd":temperature:AVERAGE \
  AREA:temp$INTEMP_COLOR:"Temperature" \
  GPRINT:temp:LAST:"   Current\: %.1lf %s"  \
  GPRINT:temp:AVERAGE:"Average\: %.1lf %s"  \
  GPRINT:temp:MIN:"Min\: %.1lf %s"  \
  GPRINT:temp:MAX:"Max\: %.1lf %s\n"
  
# Yearly graph
/usr/bin/rrdtool graph $HOME/graphs/thermometer-sf-temperature-yearly.png \
  --imgformat=PNG \
  --start=${START_YEARLY} \
  --end=${EPOCH} \
  --title='Thermometer - Second Floor - Yearly' \
  --base=1024 \
  --height=120 \
  --width=500 \
  --alt-autoscale-max \
  --lower-limit=0 \
  --vertical-label='degree  Celsius' \
  --slope-mode \
  --font TITLE:10: \
  --font AXIS:7: \
  --font LEGEND:8: \
  --font UNIT:7: \
  DEF:temp="$HOME/rrds/thermometer-sf-temperature.rrd":temperature:AVERAGE \
  AREA:temp$INTEMP_COLOR:"Temperature" \
  GPRINT:temp:LAST:"   Current\: %.1lf %s"  \
  GPRINT:temp:AVERAGE:"Average\: %.1lf %s"  \
  GPRINT:temp:MIN:"Min\: %.1lf %s"  \
  GPRINT:temp:MAX:"Max\: %.1lf %s\n"

# Copy newly updated graphs (PNG) to the webserver root
cp $HOME/graphs/thermometer-sf-temperature-daily.png /www/
cp $HOME/graphs/thermometer-sf-temperature-weekly.png /www/
cp $HOME/graphs/thermometer-sf-temperature-monthly.png /www/
cp $HOME/graphs/thermometer-sf-temperature-yearly.png /www/
