#!/bin/bash
# Creacion dels "homes" dels usuaris
#Vladimir remar
#-----------------------------------------------------------------------
# Base search
#             ldapsearch -x -LLL -h serverldap -b 'ou=grups,dc=edt,dc=org' 'dn' 'memberUid'
# Base search filtered
#ldapsearch -x -LLL -h serverldap -b 'ou=grups,dc=edt,dc=org' 'dn' 'memberUid' | cut -f2 -d' '| cut -f1 -d ','|sed -e 's/ou=grups//; s/cn=.*//'|cut -f2 -d'='|tr -s '\n' ' '

lp=$(ldapsearch -x -LLL -h ldap.gandhi.reload -b 'ou=grups,dc=gandhi,dc=reload' 'dn' 'memberUid' | cut -f2 -d' '| cut -f1 -d ','|sed -e 's/ou=grups//; s/cn=.*//'|cut -f2 -d'='|tr -s '\n' ' ')
for e in $lp
do
  kadmin -p admin/admin -w kadmin -q "addprinc -pw $e $e"&>/dev/null
done;
