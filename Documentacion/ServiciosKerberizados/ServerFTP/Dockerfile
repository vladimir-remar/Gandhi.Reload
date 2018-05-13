# Version: 0.0.1
FROM fedora:24
RUN dnf -y install procps iputils iproute tree krb5-workstation krb5-libs  vsftpd openldap-clients pam_krb5 pam_ldap passwd pam_mount nfs-utils
RUN mkdir /opt/docker
COPY * /opt/docker/
WORKDIR /opt/docker/
RUN ./config.sh
RUN mkdir /run/rpcbind
RUN touch /run/rpcbind/rpcbind.lock 
CMD ["/opt/docker/startup.sh"]
EXPOSE 20 21