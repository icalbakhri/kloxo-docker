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

RUN curl -sL https://kloxo.org/kloxo8/kloxo.sh | bash 

VOLUME [ "/sys/fs/cgroup" ]
VOLUME /etc
VOLUME /usr/local/lxlabs
VOLUME /home
VOLUME /var
VOLUME /opt

EXPOSE 7777
EXPOSE 7778
EXPOSE 80
EXPOSE 443
EXPOSE 443/udp
EXPOSE 22
EXPOSE 21
EXPOSE 53
EXPOSE 53/udp
EXPOSE 25
EXPOSE 110
EXPOSE 143
EXPOSE 587
EXPOSE 465
EXPOSE 993
EXPOSE 995

ENTRYPOINT [ "/usr/sbin/init" ]
