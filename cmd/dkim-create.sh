#!/bin/bash

cp -r /dkim/*.key ./

cd /etc/exim4/dkim/
openssl genrsa -out wumvi.com.key 1024
openssl rsa -pubout -in wumvi.com.key -out wumvi.com.pub
chown -R Debian-exim:Debian-exim wumvi.com.key
chmod 640 wumvi.com.key


# exim --version | grep version
# exim -bP transports | grep dkim

KEYPUB=`pcregrep -M '.{64}\n.{64}\n.{64}\n.{24}' wumvi.com.pub | sed ':a;N;$!ba;s/\n//g'`
echo "v=DKIM1 k=rsa; p=$KEYPUB"