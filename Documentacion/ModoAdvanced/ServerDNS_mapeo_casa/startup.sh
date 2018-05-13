#!/bin/bash
/usr/sbin/named-checkconf -z /etc/named.conf &>/dev/null
/usr/sbin/named -g -u named $OPTIONS
