#!/usr/bin/env python
#
#
#

import os
import time
import sqlite3 as lite

con = lite.connect('/usr/share/sqlitedb/temperature.db')
cur = con.cursor()
cur.execute('SELECT temp FROM temperature ORDER BY rec_id DESC limit 1')
temperature = cur.fetchone()[0]
con.close()

epoch_time = int(time.time())

cmd = "/usr/bin/rrdtool update /root/graphs/rrds/thermometer-sf-temperature.rrd %s:%s" % (epoch_time, temperature)

os.system(cmd)
