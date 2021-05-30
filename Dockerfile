FROM nginx:1.17.1-alpine
RUN rm -rf /var/cache/yum && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
    echo 'Asia/Taipei' > /etc/timezone

WORKDIR /build/dist

COPY ./entrypoint.sh entrypoint.sh
COPY ./nginx.template.conf /etc/nginx/nginx.template.conf
COPY ./index.html /usr/share/nginx/html
RUN apk update && apk add bash && apk add curl
RUN apk add certbot
RUN apk add certbot-nginx
# RUN apk add policycoreutils
# RUN restorecon -v -R /etc/nginx

HEALTHCHECK CMD curl -f http://localhost/ || exit 1
ENTRYPOINT ["sh", "./entrypoint.sh"]
