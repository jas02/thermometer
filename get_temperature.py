#!/usr/bin/env python
#
#  Copyright (C) 2013 AlfaWolf s.r.o.
#  Lumir Jasiok
#  lumir.jasiok@alfawolf.eu
#  http://www.alfawolf.eu
#
#

import os
import re
import sys
import serial
import datetime
import minimalmodbus
import sqlite3 as lite

from subprocess import PIPE
from subprocess import Popen

# Which USB interface is used by RS485/USB converter?
# We are reading USB interface from dmesg message (on OpenWRT)
cmd = Popen('dmesg', shell=True, stdout=PIPE)
dmesg = cmd.communicate()[0].split('\n')

usb = ''

for line in dmesg:
    # Searching for pattern, ususally in Linux it's /dev/ttyS0 or so
    match = re.match(r'.*FTDI USB Serial Device converter now attached to (.*)', line, re.M|re.I)
    if match:
        usb = match.group(1)

# In case that we dind't found any interface, we are sending notification to
# the iOS device (or OS X computer) using external script
if not usb:
    os.system("echo 'No USB interface found! Please check the Serial Device \
      converter status' | /usr/bin/send_push_notification.py get_temperature")            
    sys.exit(1)

usb = '/dev/' + usb

# Connecting to the USB port and reading data using minimalmodbus module 
instrument = minimalmodbus.Instrument(usb, 1)
#instrument.debug = True
instrument.serial.baudrate = 9600
instrument.serial.parity   = serial.PARITY_NONE
instrument.serial.bytesize = 8
instrument.serial.stopbits = 1
instrument.serial.timeout  = 0.05   # seconds
# We are reading temperature using function code 4, please see Modbus protocol
# specification
temperature = instrument.read_register(1, 1, functioncode=4)

# Temperature formatting 
temp = float("%.2f" % temperature)
# Current date and time
date = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# Location of SQLite database
con = lite.connect('/usr/share/sqlitedb/temperature.db')
cur = con.cursor()

cur.execute('INSERT INTO temperature (tm_id, temp, datetime) VALUES (?, ?, ?)', (1, temp, date))
con.commit()
con.close()

