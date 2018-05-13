#!/bin/bash
#run 2 daemons
#-----------------------------------------------------------------------
#/usr/bin/python3.5 /opt/docker/run.py
/usr/sbin/krb5kdc
/usr/sbin/kadmind -nofork

