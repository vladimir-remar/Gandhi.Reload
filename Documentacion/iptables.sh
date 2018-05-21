#!/bin/bash

iptables -A INPUT -s 10.10.0.0/24 -j ACCEPT
iptables -A OUTPUT -d 10.10.0.0/24 -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.10.0.0/24 -o enp5s0 -j MASQUERADE
iptables -A FORWARD -s 10.10.0.0/24 -d 0.0.0.0/0 -j ACCEPT
iptables -A FORWARD -d 10.10.0.0/24 -s 0.0.0.0/0 -j ACCEPT
iptables -t filter -I INPUT 7 -p udp -m conntrack --ctstate NEW -m udp --dport 53 -j ACCEPT
