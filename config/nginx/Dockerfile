#FROM alpine:edge
FROM nginx:latest

LABEL org.opencontainers.image.authors="Dmitry Verkhoturov <paskal.07@gmail.com>" \
      org.opencontainers.image.description="nginx with brotli installed and running as non-root user, with reload for cert renewal once in six hours" \
      org.opencontainers.image.documentation="https://github.com/paskal/bitrix.infra" \
      org.opencontainers.image.source="https://github.com/paskal/bitrix.infra.git" \
      org.opencontainers.image.title="nginx"

# for shadow package
#RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories

# shadow for usermod
#RUN apt-get -y update
#RUN curl -L https://nginx.org/keys/nginx_signing.key | apt-key add -
# RUN apt update
# RUN apt upgrade
# RUN apt-get install nginx-module-brotli

RUN usermod -u 1001 nginx
RUN groupmod -g 1001 nginx

# run nginx with configuration reload once in every 6 hours
CMD /bin/sh -c 'while :; do /bin/sleep 6h & wait ${!}; /usr/sbin/nginx -s reload; done & /usr/sbin/nginx -g "daemon off;"'
#CMD ["nginx"]
