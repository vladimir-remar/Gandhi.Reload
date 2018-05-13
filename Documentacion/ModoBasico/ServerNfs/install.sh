#!/bin/bash
red=172.31.0.0/16
echo "rpcbind mountd nfsd statd lockd rquotad : $red 172.17.0.0/16 192.168.1.0/24 10.10.0.0/24">>/etc/hosts.allow
mkdir /run/rpcbind
touch /run/rpcbind/rpcbind.lock 

cat << EOF > /etc/exports
/mnt/dades 172.31.0.0/16(rw,sync,no_subtree_check,no_root_squash,fsid=0)
/mnt/dades 192.168.1.0/24(rw,sync,no_subtree_check,no_root_squash,fsid=0)
/mnt/dades 172.17.0.0/16(rw,sync,no_subtree_check,no_root_squash,fsid=0)
/mnt/dades 10.10.0.0/24(rw,sync,no_subtree_check,no_root_squash,fsid=0)
EOF
