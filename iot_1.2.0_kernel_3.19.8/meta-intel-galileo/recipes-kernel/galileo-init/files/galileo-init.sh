#!/bin/sh

load_drivers()
{
    while IFS= read -r line; do
      modprobe $line
    done < "/etc/modules-load.galileo/$1.conf"
}

do_board()
{
    board=$(cat /sys/devices/virtual/dmi/id/board_name)
    case "$board" in
        *"GalileoGen2" )
            load_drivers "galileo_gen2" ;;
        *"Galileo" )
            load_drivers "galileo" ;;
    esac
}

die()
{
    exit 1
}

do_board
exit 0

