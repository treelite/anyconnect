FROM ubuntu:14.04
MAINTAINER treelite <c.xinle@gmail.com>

WORKDIR /root

COPY ./bin/anyconnect /bin/
COPY ./etc/ocserv.conf /etc/ocserv/

RUN apt-get update
RUN apt-get install iptables build-essential pkg-config libgnutls28-dev libreadline-dev libseccomp-dev libwrap0-dev libnl-nf-3-dev liblz4-dev wget xz-utils -y
RUN wget ftp://ftp.infradead.org/pub/ocserv/ocserv-0.10.10.tar.xz && tar xvf ocserv-0.10.10.tar.xz
RUN cd ocserv-0.10.10 && ./configure && make && make install
RUN rm -rf /root/*

VOLUME ["/certs"]

ENTRYPOINT ["/bin/anyconnect"]
