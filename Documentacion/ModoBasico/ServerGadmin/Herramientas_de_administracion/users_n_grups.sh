#!/bin/bash
#gandhi reload
#vladimir remar
# Ad users to ldap and update the groups
#-----------------------------------------------------------------------

ldapadd -x -c -D cn=Manager,dc=gandhi,dc=reload -w secret -f users.ldif 2>/opt/log_users/users_bad/bad.txt 1>/opt/log_users/users_ok/ok.txt
ldapmodify -x -c -D cn=Manager,dc=gandhi,dc=reload -w secret -f grups.ldif  2>/opt/log_groups/grups_bad/bad.txt 1>/opt/log_groups/grups_ok/ok.txt
/bin/bash creacionhomes.sh
/bin/bash creacioprincipalskrb.sh
mv users.ldif /opt/log_users/users_$(date +%d-%m-%y_%H:%M:%S)
mv grups.ldif /opt/log_groups/grups_$(date +%d-%m-%y_%H:%M:%S)
