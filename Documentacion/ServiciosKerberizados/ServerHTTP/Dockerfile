# Version: 0.0.1
FROM fedora:24
RUN dnf -y install procps iputils iproute tree httpd mod_auth_kerb krb5-workstation
RUN mkdir /opt/docker
COPY * /opt/docker/
WORKDIR /opt/docker/
RUN ./config.sh
CMD ["/opt/docker/startup.sh"]
EXPOSE 80