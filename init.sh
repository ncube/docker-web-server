#!/bin/bash
/usr/sbin/apache2ctl stop
rm -f /var/run/apache2/apache2.pid
/usr/sbin/apache2ctl -D FOREGROUND