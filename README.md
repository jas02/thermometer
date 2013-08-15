thermometer
===========

This set of scripts read temperature from temperature from RS485 thermometer ('TQS3 I' from www.papouch.com) via RS485/USB 
converter ('SB485L' from www.papouch.com) using script get_temperature.py. 

Data readed from thermometer are saved into the SQLite database every minute
using cron record:

```
*/1 * * * * /usr/bin/python /usr/bin/get_temperature.py > /dev/null 2>&1
```

Then, we have set of scripts, that creates and updates RRD graphs, creates PNG
pictures (every five minute) and copy those PNG files into web root directory.

Cron entry for RRD updates:


```
*/5 * * * * /usr/bin/python /usr/local/share/graphs/bin/update_rrds.py && /usr/local/share/graphs/bin/create_graph.sh  > /dev/null 2>&1
```

All scripts are running on OpenWRT Linux distribution on TP-LINK router.
