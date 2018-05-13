# @edt ASIX M14 2018
# gandhireload:nfsserver
# Servidor NFS creacio interactiva
# ----------------------------------
FROM fedora:24

RUN dnf install -y nfs-utils passwd openssh nfs-utils-lib tcpdump
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN /opt/docker/install.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
EXPOSE 111 2049 20048