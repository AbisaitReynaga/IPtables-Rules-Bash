#!/bin/bash

iptables -F
iptables -t nat -F

#iptables -t nat -A PREROUTING -p tcp --dport 22 -i enp3s0 -j DNAT --to 172.30.10.30 #srvFTP

iptables -A INPUT -p tcp --dport 22 -j DROP
iptables -t nat -A PREROUTING -p tcp --dport 5522 -i enp3s0 -j DNAT --to 172.30.10.10:22
iptables -t nat -A PREROUTING -p tcp --dport 5622 -i enp3s0 -j DNAT --to 172.30.10.20:22
iptables -t nat -A PREROUTING -p tcp --dport 5722 -i enp3s0 -j DNAT --to 172.30.10.30:22