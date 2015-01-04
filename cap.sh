#!/bin/bash

TSHARK=`which tshark`
AIRMON_NG=`which airmon-ng`
CLIENT_STATION=$1
CAPTURE_FILE_NAME=traffic.csv

# create mon0 interface
$AIRMON_NG start wlan1

# this captures 802.11 probe requests, probe responses
tshark -i mon0 -Y "wlan.fc.type_subtype==4 || wlan.fc.type_subtype==5" \
                -T fields -e frame.time                  \
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
                           >> $CAPTURE_FILE_NAME
