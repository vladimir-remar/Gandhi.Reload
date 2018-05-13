# @edt ASIX M14 2018
# gandhireload:ldapserver
# Servidor ldap creacio interactiva
# ----------------------------------
FROM fedora:24

RUN dnf -y install openldap openldap-servers openldap-clients 
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN /opt/docker/install.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
EXPOSE 389
