#!/bin/bash

# Start OpenOCD in the background and keep it running until the script is terminated.
echo "Starting OpenOCD..."
# ls /usr/local/share/openocd/scripts/target/
/usr/local/bin/openocd -f interface/$OPENOCD_INTERFACE.cfg -f target/$OPENOCD_TARGET.cfg  -c "bindto $HOST_IP" -c "init"
