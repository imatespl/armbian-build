#!/bin/bash

driver_raw_gadget()
{
        # Updated USB  raw_gadget
        if linux-version compare "${version}" ge 5.7; then

                # attach to specifics tag or branch
                local raw_gadgetver="branch:master"

                display_alert "Updating" "Drivers for raw_gadget ${raw_gadgetver}" "info"
                fetch_from_repo "$GITHUB_SOURCE/xairy/raw-gadget" "raw-gadget" "${raw_gadgetver}" "yes"
                cd "$kerneldir" || exit
                rm -rf $kerneldir/drivers/usb/gadget/legacy/raw_gadget.c
                rm -rf $kerneldir/include/uapi/linux/usb/raw_gadget.h
                sed -i 's/"raw_gadget.h"/<uapi\/linux\/usb\/raw_gadget.h>/' ${SRC}/cache/sources/raw-gadget/master/raw_gadget/raw_gadget.c
                cp  "${SRC}/cache/sources/raw-gadget/master/raw_gadget/raw_gadget.c" \
                        "$kerneldir/drivers/usb/gadget/legacy/"
                cp  "${SRC}/cache/sources/raw-gadget/master/raw_gadget/raw_gadget.h" \
                        "$kerneldir/include/uapi/linux/usb"

        fi
}


patch_drivers_raw_gadget()
{
        display_alert "Patching raw_gadget drivers"

        driver_raw_gadget

        display_alert "Network raw_gadget drivers  patched" "" "info"
}
