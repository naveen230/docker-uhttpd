#!/bin/bash

#This script changes MAC address of all interfaces randomly
#Adapted from https://gist.github.com/ckoepp/9237469

INTERFACES="$(ip link | awk -F: '$0 !~ "lo|vir|wl"{print $2a;getline}')" # finds all interfaces
MAC_ADDRESS="$(ifconfig -a | awk '/^[a-z]/ { iface=$1; mac=$NF; next  } /inet addr:/ { print mac }')" #finds current MAC Address
DEBUG=false
for INTERFACE in ${INTERFACES[*]}; do
  $DEBUG && echo "Deactivating $INTERFACE"
  ifconfig $INTERFACE down
  while : ; do
NEW_MAC="$(awk 'NR == 1' /root/output.txt)"
$DEBUG && echo "Trying to set $NEW_MAC to $INTERFACE"
    ifconfig $INTERFACE hw ether $NEW_MAC > /dev/null 2>&1
    [[ $? -ne 0 ]] || break
    $DEBUG && echo "$INTERFACE rejected address $NEW_MAC"
  done
   $DEBUG && echo "Reactivating $INTERFACE"
   ifconfig $INTERFACE up
done


