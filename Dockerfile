FROM almalinux:9

LABEL maintainer='Moh Faesal Bakhri'

#set ARG ENV
ARG DB_PASSWORD=
ARG ADMIN_PASSWORD=
ENV DB_PASSWORD=$DB_PASSWORD
ENV ADMIN_PASSWORD=&ADMIN_PASSWORD

ENV container=docker

RUN INSTALL_PKGS='findutils glibc-common initscripts iproute python3 sudo' \
    && dnf makecache && dnf install -y $INSTALL_PKGS \
    && dnf clean all

RUN find /etc/systemd/system \
    /lib/systemd/system \
    -path '*.wants/*' \
    -not -name '*journald*' \
    -not -name '*systemd-tmpfiles*' \
    -not -name '*systemd-user-sessions*' \
    -print0 | xargs -0 rm -vf

RUN 

VOLUME [ "/sys/fs/cgroup" ]
VOLUME /etc
VOLUME /usr/local/lxlabs
VOLUME /home
VOLUME /var
VOLUME /opt

EXPOSE

ENTRYPOINT [ "/usr/sbin/init" ]
