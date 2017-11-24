FROM ubuntu:16.04

RUN apt-get -qq update
RUN apt-get install -y build-essential \
            automake \
            autoconf \
            libtool \
            pkg-config \
            shtool \
            libev-dev \
            libsystemd-dev \
            erlang-dev \
            liburcu-dev \
            libconfig-dev

COPY . /build

WORKDIR /build
RUN ./autogen.sh && ./configure --sysconfdir=/etc --without-systemd-journal

RUN make && make install

#COPY docker/docker-entrypoint.sh /
RUN install -m 0644 /build/src/capwap-dp.conf /etc/

#ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["usr/bin/capwap-dp", "foreground"]

