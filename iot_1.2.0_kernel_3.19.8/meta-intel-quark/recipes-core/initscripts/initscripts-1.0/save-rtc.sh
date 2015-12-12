#!/bin/sh
### BEGIN INIT INFO
# Provides:          save-rtc
# Required-Start:
# Required-Stop:     $local_fs hwclock
# Default-Start:     S
# Default-Stop:      0 6
# Short-Description: Store system clock into file
# Description:
### END INIT INFO

# Update the timestamp
date -u +%Y%m%d%H%M%S > /etc/timestamp
