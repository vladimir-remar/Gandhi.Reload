#! /bin/bash
#/usr/bin/echo "starting slapd..."

/usr/sbin/slapd -d0 -u ldap -h "ldap:/// ldaps:/// ldapi:///"
#/usr/sbin/slapd -u ldap -h "ldap:/// ldaps:/// ldapi:///"
