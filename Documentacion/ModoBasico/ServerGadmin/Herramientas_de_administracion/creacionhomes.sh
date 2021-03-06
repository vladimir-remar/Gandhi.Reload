#!/bin/bash
# Creacion dels "homes" dels usuaris
#Vladimir remar
#-----------------------------------------------------------------------
# Base search
#             ldapsearch -x -LLL -h serverldap -b 'ou=grups,dc=edt,dc=org' 'dn' 'memberUid'
# Base search filtered
#ldapsearch -x -LLL -h serverldap -b 'ou=grups,dc=edt,dc=org' 'dn' 'memberUid' | cut -f2 -d' '| cut -f1 -d ','|sed 's/ou=grups//'|tr -s '\n' ' '
le=$(ldapsearch -x -LLL -h ldap.gandhi.reload -b 'ou=grups,dc=gandhi,dc=reload' 'dn' 'memberUid' | cut -f2 -d' '| cut -f1 -d ','|sed 's/ou=grups//'|tr -s '\n' ' ')
nameGroup=''
nameUser=''
for e in $le
do
  if [[ ${e:0:2} = 'cn' ]]
  then
    nameGroup=${e:3}
    mkdir -p /mnt/dades/$nameGroup
    chmod 775 /mnt/dades/$nameGroup
    #chown -R .$nameGroup /mnt/dades/$nameGroup
  else
    nameUser=${e:4}
    mkdir -p /mnt/dades/$nameGroup/$nameUser
    #cp  -u /etc/skel/.* /mnt/dades/$nameGroup/$nameUser 
    chown  $nameUser.$nameGroup /mnt/dades/$nameGroup/$nameUser
    chmod 755 /mnt/dades/$nameGroup/$nameUser
  fi
done;
#Cambiar los permisos
#chmod  777 /mnt/dades