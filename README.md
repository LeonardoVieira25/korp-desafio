# korp-desafio

Serviço HTTP em Golang exposto via NGINX, com monitoramento Prometheus + Grafana.
A infraestrutura roda em um VPS da Hetzner Cloud criado com Terraform e é
totalmente provisionada com Ansible.

### Build do http-service

```bash
docker build -t go-server -f docker/Dockerfile ./http-service
```

### Para rodar

```bash
docker compose -f docker/compose.yml up -d
```

## Provisionamento

Cria o VPS na Hetzner Cloud com Terraform.

**1. Criação das chaves SSH**

Gera o par de chaves usado para acessar o servidor:

```bash
./scripts/create-keys.sh
```

> Cria `keys/.hetzner.key` (privada) e `keys/.hetzner.key.pub` (pública).

**2. Preencha as variáveis do Terraform**

Copie o arquivo de exemplo e edite com o token da API da Hetzner Cloud:

```bash
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
```

Edite `terraform/terraform.tfvars`:

```hcl
hcloud_token = "seu-token-da-hetzner-cloud"
```

**3. Crie o VPS**

```bash
terraform -chdir=./terraform apply
```

Ao final, o Terraform exibe o IP público do servidor (output `server_ipv4_address`).

## Execução

Antes de rodar o Ansible, **adicione o host no inventário**.

Edite `ansible/inventory.ini` com o IP do VPS criado no passo anterior:

```ini
[korp_servers]
korp-server ansible_host=SEU_IP ansible_user=root
```

> A chave privada (`keys/.hetzner.key`) é usada automaticamente na conexão
> (definida em `group_vars/all.yml`).

A partir do diretório `ansible/`:

```bash
# 0. Instala a coleção community.docker
ansible-galaxy collection install -r requirements.yml -p ./collections

# 1. Setup: instala o Docker e cria a rede
ansible-playbook -i inventory.ini playbooks/setup.yml

# 2. Deploy: arquivos + build + containers + validação HTTP
ansible-playbook -i inventory.ini playbooks/deploy.yml
```

> As etapas são independentes e leem as variáveis compartilhadas de
> `group_vars/all.yml`. Você pode reexecutar apenas o deploy, por exemplo,
> após alterar o `http-service/` ou o `docker/compose.yml`.
