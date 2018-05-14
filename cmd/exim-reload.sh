#!/bin/bash

echo $HOSTNAME > /etc/mailname
echo $HOSTNAME > /etc/hostname

/usr/sbin/update-exim4.conf

pkill -x exim4

/usr/sbin/exim4 -bd -q5m &