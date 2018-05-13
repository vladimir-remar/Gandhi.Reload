# ASIX M14 2018
# CLiente Externo
# 
# ----------------------------------
FROM fedora:24

RUN dnf update vi -y
RUN dnf install -y vim procps iputils iproute openldap-clients openssh-clients nfs-utils netstat-monitor.noarch php-pear-Net-Ping.noarch tree krb5-workstation krb5-libs pam_mount pam_krb5 authconfig authconfig-gtk bind-utils pam_ldap dhcp-client
RUN mkdir /run/rpcbind
RUN touch /run/rpcbind/rpcbind.lock 
RUN mkdir /opt/docker
COPY * /opt/docker/
#RUN /opt/docker/config.sh
WORKDIR /opt/docker
CMD ["/bin/bash"]