#!/bin/bash

TSHARK=`which tshark`
AIRMON_NG=`which airmon-ng`
CAPTURE_FILE_DIRECTORY=output
CAPTURE_FILE_NAME=traffic.csv

# create our file if it does not exist
if [ ! -e "./$CAPTURE_FILE_DIRECTORY/$CAPTURE_FILE_NAME" ] ; then
    touch "./$CAPTURE_FILE_DIRECTORY/$CAPTURE_FILE_NAME"
fi

# modify permissions
chmod 777 ./$CAPTURE_FILE_DIRECTORY/$CAPTURE_FILE_NAME

# create mon0 interface to capture on
# make sure to verify if we should start wlan1 (internal) or maybe wlan2 (alfa)
$AIRMON_NG start wlan1

# this script captures 802.11 probe requests(4), probe responses(5)
# authentication requests/responses(11),
# association requests(0), assocation responses(1), 
# disassociation updates (10)
tshark -i mon0 -Y "wlan.fc.type_subtype==4 || wlan.fc.type_subtype==5 || wlan.fc.type_subtype==11 || wlan.fc.type_subtype==0 || wlan.fc.type_subtype==1 || wlan.fc.type_subtype==10" \
                          -T fields -e frame.time        \
                          -e wlan.fc.type_subtype        \
                          -e wlan.sa                     \
                          -e wlan.da                     \
                          -e wlan_mgt.ssid               \
                          -e radiotap.channel.freq       \
                          -e radiotap.dbm_antsignal      \
                          -E separator=","               \
                          -E header=y                    \
                          -E quote=d                     \
                          -E occurrence=f                \
                          >> ./$CAPTURE_FILE_DIRECTORY/$CAPTURE_FILE_NAME
