
def plantilla_ldap_users():
	
	ldap_users='''dn: uid=%s,ou=usuaris,dc=gandhi,dc=reload
objectclass: posixAccount
objectclass: inetOrgPerson
cn: %s
sn: %s
homephone: %s 
mail: %s
description: %s
ou: %s
uid: %s
uidNumber: %s  
gidNumber: %s
homeDirectory: /home/users/%s 
userPassword: %s
'''

	return ldap_users

def plantilla_mod_grups():

	ldap_grups='''dn: cn=%s,ou=grups,dc=gandhi,dc=reload
changetype:modify
add:memberUid'''

	return ldap_grups
