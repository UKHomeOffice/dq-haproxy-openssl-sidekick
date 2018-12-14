FROM haproxy:alpine
ENV USERMAP_UID 1000
ENV EXPOSED_PORT=5000
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
RUN adduser -D -u 1000 haproxy
USER ${USERMAP_UID}
EXPOSE 5000
