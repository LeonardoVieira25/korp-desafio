terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.47"
    }
  }
}

# Upload the SSH key so it can be injected into the server on creation.
resource "hcloud_ssh_key" "deploy" {
  name       = var.ssh_key_name
  public_key = var.ssh_public_key
}

# Firewall: only inbound HTTP (80) and SSH (22) are allowed; everything else is dropped.
resource "hcloud_firewall" "allow_http_ssh" {
  name = "${var.server_name}-allow-http-ssh"

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "80"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "3000"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
}

# CX23: 2 shared vCPU, 4 GB RAM, 40 GB disk.
resource "hcloud_server" "cx23" {
  name         = var.server_name
  server_type  = "cx23"
  image        = var.image
  location     = var.location
  ssh_keys     = [hcloud_ssh_key.deploy.id]
  firewall_ids = [hcloud_firewall.allow_http_ssh.id]
  labels       = var.labels
}
