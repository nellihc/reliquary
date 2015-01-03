#!/bin/bash

# find the full path of tshark
TSHARK=`which tshark`
CLIENT_STATION=$1

# below captures probe requests sent by $CLIENT_STATION
tshark -i mon0 -Y "wlan.sa == $CLIENT_STATION && wlan.fc.subtype == 0x04"
