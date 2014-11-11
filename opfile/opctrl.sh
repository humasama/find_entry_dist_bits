
#!/bin/bash
#opcontrol --separate=thread --no-vmlinux
opcontrol --reset
opcontrol --separate=none --no-vmlinux
opcontrol --event=DATA_CACHE_MISSES:5000:0x01 --event=L2_CACHE_MISS:5000:0x17 --event=IBS_OP_BANK_CONF_LOAD:500000:0x01 --event=L2_PREFETCHER_TRIGGER:500:0x01
opcontrol --start
./find_xor_bit.sh
opcontrol --dump
opcontrol --stop
opcontrol --shutdown
