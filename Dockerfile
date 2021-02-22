FROM haproxy:alpine
ENV USERMAP_UID 1000
ENV EXPOSED_PORT 5000
ENV EXPOSED_UDP_PORT 2000/udp

RUN set -euxo pipefail \
    && apk add --no-cache \
        rsyslog curl \
    && mkdir -p /etc/rsyslog.d \
    && touch /var/log/haproxy.log \
    && ln -sf /dev/stdout /var/log/haproxy.log

COPY docker-entrypoint.sh /
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY rsyslog.conf /etc/rsyslog.conf

RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories && \
    apk --no-cache add shadow

RUN adduser -D -u 1000 dq-haproxy -G haproxy && \
    #usermod -a -G haproxy dq-haproxy && \
    chown 1000 docker-entrypoint.sh && \
    chmod 700 docker-entrypoint.sh && \
    chown -R 1000 /var/run/ && \
    chown 1000 /usr/local/etc/haproxy/haproxy.cfg && \
    chown 1000 /etc/rsyslog.conf


USER ${USERMAP_UID}
EXPOSE ${EXPOSED_PORT}
EXPOSE ${EXPOSED_UDP_PORT}

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["-f", "/usr/local/etc/haproxy/haproxy.cfg"]
