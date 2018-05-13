# Version: 0.0.1
FROM fedora:24

RUN dnf -y install bind bind-utils
RUN mkdir /opt/docker
COPY * /opt/docker/
WORKDIR /opt/docker/
RUN /opt/docker/config.sh
CMD ["/opt/docker/startup.sh"]
EXPOSE 53