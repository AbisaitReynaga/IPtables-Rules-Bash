#!/bin/bash

iptables -F
iptables -t nat -F
iptables -t nat -A POSTROUTING -o enp3s0 -s 172.30.10.0/24 -j MASQUERADE

IP=$(dialog --title "ACEPTAR IP" \
                --stdout \
                --inputbox "IP QUE SERVICIOS VIRTUALES ACEPTARA: " 0 0)

iptables -t nat -A PREROUTING -p tcp -i enp3s0 -s 192.168.1.0/24 --dport 21 -j DNAT --to 172.30.10.10
iptables -t nat -A PREROUTING -p tcp -i enp3s0 -s 192.168.1.0/24 --dport 1024:65535 -j DNAT --to 172.30.10.10

iptables -t nat -A PREROUTING -p tcp -i enp3s0 -s 192.168.1.0/24 --dport 80 -j DNAT --to 172.30.10.20

iptables -t nat -A PREROUTING -p tcp -i enp3s0 -s 192.168.1.0/24 --dport 8080 -j DNAT --to 172.30.10.30

iptables -A FORWARD !-s $IP -i enp3s0 -j DROP
