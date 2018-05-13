# ASIX M14 2018
# Servidor Kerberos
# 
# ----------------------------------
FROM fedora:24

RUN dnf install -y krb5-server krb5-workstation krb5-libs
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN /opt/docker/config.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
EXPOSE 88 464 749

