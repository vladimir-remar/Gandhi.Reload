#!/bin/bash
#gandhi reload
#vladimir remar
# Ad users to ldap and update the groups
#-----------------------------------------------------------------------

ldapmodify -x -c -D cn=Manager,dc=gandhi,dc=reload -w secret -f users.ldif 2>logusers.txt
ldapmodify -x -c -D cn=Manager,dc=gandhi,dc=reload -w secret -f grups.ldif 2>loggrups.txt
./creacionhomes.sh
./creacionprincipals