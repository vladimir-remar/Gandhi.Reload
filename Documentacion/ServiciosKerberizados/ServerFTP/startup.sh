#!/bin/bash
#inici service ftp
#-----------------------------------------------------------------------
/usr/sbin/nslcd
rpcbind
rpc.statd
rpc.nfsd
mount -t nfs nfs.gandhi.reload:/mnt/dades /home/users/inf
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf