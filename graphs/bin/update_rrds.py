#!/usr/bin/env python
#
#  Copyright (C) 2013 AlfaWolf s.r.o.
#  Lumir Jasiok
#  lumir.jasiok@alfawolf.eu
#  http://www.alfawolf.eu
#
#
#

import os
import time
import sqlite3 as lite

con = lite.connect('/usr/share/sqlitedb/temperature.db')
cur = con.cursor()
# Select last saved temperature
cur.execute('SELECT temp FROM temperature ORDER BY rec_id DESC limit 1')
temperature = cur.fetchone()[0]
con.close()

# Copmute UNIX time (seconds from 1/1/1970)
epoch_time = int(time.time())

cmd = "/usr/bin/rrdtool update \
       /usr/local/share/graphs/rrds/thermometer-sf-temperature.rrd %s:%s" \
       % (epoch_time, temperature)

os.system(cmd)
