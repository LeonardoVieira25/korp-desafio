# korp-desafio

### To build the http service image:

```bash
docker build -t go-server -f docker/Dockerfile ./http-service
```

### To run (using the pre-built image):

```bash
docker compose -f docker/compose.yml up -d
```

### To run (development, builds the image from source):

```bash
docker compose -f docker/compose.dev.yml up --build -d
```

### Useful PromQL queries

```promql
# Request volume per second (last 5m window)
rate(nginx_http_requests_total[5m])

# Active connections
nginx_connections_active

# Availability (1 = up, 0 = down) per probed target
probe_success{job="blackbox_http"}

# Overall uptime % per target
avg_over_time(probe_success{job="blackbox_http"}[24h]) * 100

# HTTP status code seen by the probes
probe_http_status_code{job="blackbox_http"}
```
