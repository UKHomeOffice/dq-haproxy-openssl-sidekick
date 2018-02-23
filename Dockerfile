FROM haproxy:alpine
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
RUN adduser -D -u 1000 haproxy
USER haproxy
EXPOSE 5000