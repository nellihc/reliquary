#!/bin/bash

# kill bad processes
killall dhclient
killall wpa_supplicant
killall wpa_cli
killall ifplugd

# start airmon-ng
airmon-ng start wlan0

# collect beacons that support open wifi
tshark -i mon0 -R "(wlan.fc.type_subtype == 0x0008) && (wlan_mgt.fixed.capabilities.privacy == 0)" >> /tmp/open-wifi.txt

