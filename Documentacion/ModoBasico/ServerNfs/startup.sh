#!/bin/bash
#Run services
#----------------------------------------------------------------------
rpcbind &>/dev/null
rpc.statd &>/dev/null
rpc.nfsd &>/dev/null
exportfs -ra &>/dev/null
/usr/sbin/rpc.mountd --foreground
