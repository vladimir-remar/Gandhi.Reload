!#/bin/bash
#-----------------------------------------------------------------------
ldapdelete -x -r -D cn=Manager,dc=gandhi,dc=reload -w secret "uid=martina,ou=usuaris,dc=gandhi,dc=reload"
ldapdelete -x -r -D cn=Manager,dc=gandhi,dc=reload -w secret "uid=renzo,ou=usuaris,dc=gandhi,dc=reload"
ldapdelete -x -r -D cn=Manager,dc=gandhi,dc=reload -w secret "uid=vladimir,ou=usuaris,dc=gandhi,dc=reload"

ldapsearch -x -h localhost -LLL -D 'cn=Sysadmin,cn=config' -w syskey -b 'olcDatabase={1}hdb,cn=config' olcAccess