# Version: 0.0.1
FROM fedora:24

RUN dnf -y install dhcp iputils iproute net-tools
RUN mkdir /opt/docker
COPY * /opt/docker/
WORKDIR /opt/docker/
RUN ./config.sh
CMD ["/bin/bash"]
