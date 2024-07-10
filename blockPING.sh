#!/bin/bash

iptables -F
iptables -t nat -F

iptables -A INPUT -p icmp --icmp-type echo-request -i enp3s0 -j DROP
