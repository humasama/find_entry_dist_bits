#!/bin/bash

killall -9 mc-mapping

opcontrol --reset
opcontrol --separate=none --no-vmlinux
opcontrol --event=DATA_CACHE_MISSES:500:0x01 --event=L2_CACHE_MISS:500:0x17 --event=IBS_OP_BANK_CONF_LOAD:50000:0x01 --event=L2_PREFETCHER_TRIGGER:500:0x01
opcontrol --start

while read buf; do
	jbit=`echo $buf | awk '{ print $1 }'`
	kbit=`echo $buf | awk '{ print $2 }'`
	lbit=`echo $buf | awk '{ print $3 }'`
	mbit=`echo $buf | awk '{ print $4 }'`
	nbit=`echo $buf | awk '{ print $5 }'`
	echo -n "$jbit $kbit $lbit $mbit $nbit:"
	./mc-mapping -c 2 -i 10000000000 -b 0 -j $jbit -k $kbit -l $lbit -m $mbit -n $nbit >& /dev/null &
	./mc-mapping -c 0 -i 10000000 -b 0 -j $jbit -k $kbit -l $lbit -m $mbit -n $nbit || echo "N/A"
	killall -9 mc-mapping
done
killall -9 mc-mapping

opcontrol --dump                              
opcontrol --stop                              
opcontrol --shutdown
