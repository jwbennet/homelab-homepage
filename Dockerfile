FROM nginx:1.20.1-alpine

ARG TIMESTAMP

LABEL org.opencontainers.image.authors=james@inpulsetech.io
LABEL org.opencontainers.image.created=${TIMESTAMP}
LABEL org.opencontainers.image.url=https://github.com/jwbennet/homelab-homepage
LABEL org.opencontainers.image.source=https://github.com/jwbennet/homelab-homepage
LABEL org.opencontainers.image.vendor="Inpulse Technologies, LLC"

RUN mkdir -p /var/cache/nginx/ /var/log/nginx/ /var/run/nginx/ /var/tmp/nginx/ && \
    chown -R nginx /usr/share/nginx/html/ /var/cache/nginx/ /var/log/nginx/ /var/run/nginx/ /var/tmp/nginx/
WORKDIR /usr/share/nginx/html/
USER nginx

COPY --chown=nginx:root nginx/nginx.conf /etc/nginx/
COPY --chown=nginx:root nginx/default.conf /etc/nginx/conf.d/
COPY --chown=nginx:root img /usr/share/nginx/html/img/
COPY --chown=nginx:root css /usr/share/nginx/html/css/
COPY --chown=nginx:root index.html /usr/share/nginx/html/

RUN chmod -R 755 /usr/share/nginx/html/
