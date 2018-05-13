# ASIX M14 2018
# CLiente Interno (pertenece a la red gandhi.reload)
# 
# ----------------------------------
FROM fedora:24

RUN dnf update vi -y
RUN dnf install -y vim procps iputils iproute openldap-clients openssh-clients nfs-utils netstat-monitor.noarch php-pear-Net-Ping.noarch tree pam_ldap krb5-workstation krb5-libs pam_mount vim  pam_mount authconfig authconfig-gtk pam_krb5
RUN mkdir /run/rpcbind
RUN touch /run/rpcbind/rpcbind.lock 
RUN mkdir /opt/docker
COPY * /opt/docker/
WORKDIR /opt/docker
RUN ./config.sh
CMD ["/bin/bash"]
