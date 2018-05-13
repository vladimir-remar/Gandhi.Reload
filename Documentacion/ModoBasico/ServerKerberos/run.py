# /usr/bin/python
#-*- coding: utf-8-*-
#-----------------------------------------------------------------------

import os,sys,signal
pid = os.fork()
if pid !=0:
  os.execv('/usr/sbin/krb5kdc',['/usr/sbin/krb5kdc','-n'])
  sys.exit(0)
os.execv('/usr/sbin/kadmind',['/usr/sbin/kadmind','-nofork'])
