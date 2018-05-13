#!/bin/bash
#Add services entries to our kerberos server
#-----------------------------------------------------------------------
kadmin -p admin/admin -w kadmin -q "addprinc -randkey ftp/ftpserver.gandhi.reload"&>/dev/null
kadmin -p admin/admin -w kadmin -q "addprinc -randkey ssh/sshserver.gandhi.reload"&>/dev/null
kadmin -p admin/admin -w kadmin -q "addprinc -randkey HTTP/httpserver.gandhi.reload"&>/dev/null

