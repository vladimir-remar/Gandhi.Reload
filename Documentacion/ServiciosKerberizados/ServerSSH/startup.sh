#!/bin/bash
# run services
#---------------------------------------------------------------------
/usr/sbin/nslcd
rpcbind
rpc.statd
rpc.nfsd
/usr/sbin/sshd -D