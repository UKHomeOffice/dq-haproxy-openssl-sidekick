# dq-haproxy-openssl-sidekick.

Simple wrap around haproxy to act as a sidekick for openssl TCP services

```bash
docker run -d -p 5000:5000 -e HOST=google.com -e PORT=443 quay.io/ukhomeofficedigital/dq-haproxy-openssl-sidekick
curl localhost:5000
```

- Always listens on port `5000`
- Adds and runs as `haproxy` user
