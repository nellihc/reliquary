#!/bin/bash

TSHARK=`which tshark`
CLIENT_STATION=$1


# below captures association requests sent by $CLIENT_STATION
$TSHARK -i mon0 -Y "wlan.sa == $CLIENT_STATION && wlan.fc.type_subtype == 0"
