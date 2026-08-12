# korp-desafio

### To build the http service image:

```bash
docker build -t go-server -f docker/Dockerfile ./http-service
```

### To run:

```bash
docker compose -f docker/compose.yml up -d
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

## Provisionamento

A partir do diretório inicial:
```bash
terraform -chdir=./terraform apply
```

## Execução

A partir do diretório `ansible/`:

```bash
# 1. Setup: instala o Docker e cria a rede
ansible-playbook -i inventory.ini playbooks/setup.yml

# 2. Deploy: arquivos + build + containers + validação HTTP
ansible-playbook -i inventory.ini playbooks/deploy.yml
```

> As etapas são independentes e leem as variáveis compartilhadas de
> `group_vars/all.yml`. Você pode reexecutar apenas o deploy, por exemplo,
> após alterar o `http-service/` ou o `docker/compose.yml`.
