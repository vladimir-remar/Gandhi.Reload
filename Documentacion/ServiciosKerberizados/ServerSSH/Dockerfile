# Version: 0.0.1
FROM fedora:24
RUN dnf -y install procps iputils iproute tree krb5-workstation krb5-libs openssh-server nmap net-tools passwd openldap-clients nfs-utils pam_ldap pam_krb5 pam_mount
RUN mkdir /opt/docker
COPY * /opt/docker/
WORKDIR /opt/docker/
RUN ./config.sh
RUN mkdir /run/rpcbind
RUN touch /run/rpcbind/rpcbind.lock 
CMD ["/opt/docker/startup.sh"]