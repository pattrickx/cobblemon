FROM debian:latest


RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl


RUN adduser --uid <UID> terraria

RUN usermod -aG terraria terraria

WORKDIR /home/terraria


COPY config config

COPY terraria.sh terraria.sh

RUN mkdir Worlds

RUN chmod +x terraria.sh

RUN chown -R terraria:terraria /home/terraria


USER terraria


ENTRYPOINT ["/home/terraria/terraria.sh"]