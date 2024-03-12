FROM alpine:latest

RUN apk update \
    && apk add openjdk21-jre \
    && apk add bash \
    && apk add wget \
    && apk add jq

RUN mkdir /app

COPY papermc.sh /app/papermc.sh

RUN adduser -D -h /home/papermc papermc

RUN chown -R papermc:papermc /app
RUN chmod +x /app/papermc.sh

USER papermc

CMD ["bash", "./app/papermc.sh"]