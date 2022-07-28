#!/bin/bash

sudo route add -net 212.100.54.0 netmask 255.255.255.192 gw 212.100.54.1 dev eth0
sudo route add -net 212.100.54.64 netmask 255.255.255.192 gw 212.100.54.65 dev eth1
sudo route add -net 212.100.54.128 netmask 255.255.255.192 gw 212.100.54.129 dev eth2
sudo route add -net 212.100.54.192 netmask 255.255.255.192 gw 212.100.54.193 dev eth3
