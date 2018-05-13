#!/bin/bash
# Creacion dels usuaris amb no login
#Vladimir remar
#-----------------------------------------------------------------------

lu=$(ldapsearch -x -LLL -h ldap.gandhi.reload -b 'ou=grups,dc=gandhi,dc=reload' 'dn' 'memberUid' | cut -f2 -d' '| cut -f1 -d ','|sed -e 's/ou=grups//; s/cn=.*//'|cut -f2 -d'='|tr -s '\n' ' '|sed 's/admin//')
for e in $lu; do useradd $e &>/dev/null; done;