FROM ubuntu:21.10

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install -y autoconf build-essential pkg-config wget \
                       libssl-dev zlib1g-dev tzdata lm-sensors \
                       procps imagemagick libmagick++-dev

RUN wget http://ftp.ruby-lang.org/pub/ruby/2.7/ruby-2.7.3.tar.gz && \
    tar xf ruby-2.7.3.tar.gz && \
    cd ruby-2.7.3 && \
    ./configure && \
    make -j $(nproc) && \
    make install && \
    cd .. && \
    rm ruby-2.7.3.tar.gz && \
    rm -rf ruby-2.7.3

RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" > /etc/timezone

ARG PUID=1000
ARG PGID=1000
ARG HOME="/home/cajueiro"

RUN addgroup --gid ${PGID} cajueiro && \
    adduser --system --home ${HOME} --ingroup cajueiro --uid ${PUID} cajueiro

COPY --chown=cajueiro:cajueiro ./cajueiro_weather_station /home/cajueiro/cajueiro_weather_station

RUN mv /home/cajueiro/cajueiro_weather_station/entrypoint.sh /home/cajueiro/entrypoint.sh

RUN cd /home/cajueiro/cajueiro_weather_station && \
    gem build cajueiro_weather_station.gemspec && \
    gem install cajueiro_weather_station-0.1.0.gem && \
    cd /

CMD ["/home/reader/entrypoint.sh --start"]
