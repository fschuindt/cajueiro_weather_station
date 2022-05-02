FROM ubuntu:21.10

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install -y ffmpeg tzdata

RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" > /etc/timezone

ARG PUID=1000
ARG PGID=1000
ARG HOME="/home/streamer"

RUN addgroup --gid ${PGID} streamer && \
    adduser --system --home ${HOME} --ingroup streamer --uid ${PUID} streamer

COPY --chown=streamer:streamer streamer/entrypoint.sh /home/streamer/.
COPY --chown=streamer:streamer streamer/DejaVuSans-Bold.ttf /home/streamer/.

CMD ["/home/streamer/entrypoint.sh --start"]
