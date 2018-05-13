# Version: 0.0.1
FROM fedora:24
RUN dnf update vi -y
RUN dnf -y install vim procps iputils iproute openldap-clients openssh-clients netstat-monitor.noarch php-pear-Net-Ping.noarch tree krb5-workstation krb5-libs openssh-server nmap net-tools passwd
RUN mkdir /opt/docker
COPY * /opt/docker/
WORKDIR /opt/docker/
RUN ./config.sh
CMD ["/usr/sbin/sshd","-D"]
