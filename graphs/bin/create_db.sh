#!/bin/bash
#
#  Copyright (C) 2013 AlfaWolf s.r.o.
#  Lumir Jasiok
#  lumir.jasiok@alfawolf.eu
#  http://www.alfawolf.eu
#
#

# Where are located our scripts?
HOME='/usr/local/share/graphs'

# This command will create RRD database
/usr/bin/rrdtool create $HOME/rrds/thermometer-sf-temperature.rrd --start N --step 300 \
DS:temperature:GAUGE:600:U:U \
RRA:AVERAGE:0.5:1:12 \
RRA:AVERAGE:0.5:1:288 \
RRA:AVERAGE:0.5:12:168 \
RRA:AVERAGE:0.5:12:720 \
RRA:AVERAGE:0.5:288:365

