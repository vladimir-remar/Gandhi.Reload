#!/usr/python3
# -*- coding: utf-8 -*-
# Vladimir remar
# Herramienta de gestion de usuarios
'''
Programa que nos ayudará a crear usuarios de manera remota
a los servidores de ldap, kerberos y una entrada en el volumen
de datos creando su home
'''
#-----------------------------------------------------------------------

import os,sys,json,argparse
import plantillas
import subprocess

#.......................................................................
####
#Arguments
####
parser = argparse.ArgumentParser(description='Add users')
parser.add_argument('-f','--file', dest='fit', help="fitxer json amb els usuaris a introduir", type=str,metavar="fitxer-a-llegir", required=True)
args=parser.parse_args()
#FUNCIONES--------------------------------------------------------------
def gidNumber(n_gid):
	'''
	Funcion para determinar el guid number de un grupo
	'''
	ldap_gid_base  = 'ldapsearch -x -LLL -b cn=%s,ou=grups,dc=gandhi,dc=reload'%n_gid
	ldap_gid_query = ldap_gid_base+"|grep gidNumber|cut -f2 -d' '"	
	gidNum = subprocess.check_output(ldap_gid_query, shell=True)
	return(str(gidNum)[2:-3])

#-----------------------------------------------------------------------
#Bashcommands
pass_ldap = 'slappasswd -h {sha} -s %s'
base_ldap = 'ldapsearch -x -LLL -h ldap.gandhi.reload'
 #-----------------------------------------------------------------------
#NEXT UID
ldap_query="ldapsearch -x -LLL  'uidNumber' |grep uidNumber|sed 's/uidNumber: //'|  sed '$!d'"
last_uid=subprocess.check_output(ldap_query, shell=True)
uid=int(str(last_uid)[2:-3])

#-----------------------------------------------------------------------
####
# Tractament entrada
####
with open(args.fit, encoding='utf-8') as data_file:
	data = json.loads(data_file.read())
#-----------------------------------------------------------------------
####
# Salida USERS ldif
###
salida=''
dicgrupsmember={}

for user in data:
	name=user['cn'].split( )[0]
	passwd = subprocess.check_output((pass_ldap%name).split())
	passwd = str(passwd)[2:-3]
	uid=uid+1
	gname=user['ou']
	gid=gidNumber(gname)
	useruid='uid=%s,ou=usuaris,dc=gandhi,dc=reload'%name
	cngrup ='cn=%s,ou=grups,dc=gandhi,dc=reload'%gname

	if gname not in dicgrupsmember:
		dicgrupsmember[gname]={'cn':cngrup,'listUsers':[useruid]}
	elif useruid not in dicgrupsmember[gname]['listUsers']:
		dicgrupsmember[gname]['listUsers'].append(useruid)

	salida=salida+'\n'+(plantillas.plantilla_ldap_users()%(name,user['cn'],name,user['homephone'],user['mail'],user['description'],gname,name,str(uid),gid,name,passwd))
#-----------------------------------------------------------------------
####
# Salida GRUPS and members modify
###
grups_mod=''
for grup in dicgrupsmember:
	grups_mod = grups_mod+'\n' + plantillas.plantilla_mod_grups()%grup+'\n'
	lmembers=''
	for member in dicgrupsmember[grup]['listUsers']:
		grups_mod =grups_mod +'memberUid:%s'%member+'\n'
#-----------------------------------------------------------------------

#save files
fitxer_users='./users.ldif'
fitxer_grups='./grups.ldif'
add_users=open(fitxer_users,'x')
add_grups=open(fitxer_grups,'x')

add_users.write(salida)
add_grups.write(grups_mod)
add_users.close()
add_grups.close()
