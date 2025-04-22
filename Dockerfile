FROM alpine:3.21.3

RUN apk add --no-cache inotify-tools

RUN mkdir -p /.tmp && chmod 777 /.tmp

COPY watch.sh /watch.sh
RUN chmod +x /watch.sh

WORKDIR /site

CMD ["/watch.sh"]
