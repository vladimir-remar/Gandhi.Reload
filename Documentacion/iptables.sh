#!/bin/bash
iptables -A INPUT -s 10.10.0.0/24 -j ACCEPT
iptables -A OUTPUT -d 10.10.0.0/24 -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.10.0.0/24 -o enp5s0 -j MASQUERADE

iptables -A INPUT -p udp --dport 69 -j ACCEPT
iptables -A OUTPUT -p udp --dport 69 -j ACCEPT