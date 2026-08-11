terraform {
  required_version = ">= 1.5.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.47"
    }
  }

  backend "local" {}
}

# The API key is read from terraform.tfvars (gitignored) or TF_VAR_hcloud_token.
provider "hcloud" {
  token = var.hcloud_token
}

module "hetzner_cx23" {
  source = "./modules/hetzner-cx23"

  server_name    = var.server_name
  location       = var.location
  image          = var.image
  ssh_public_key = var.ssh_public_key_path != null ? file(var.ssh_public_key_path) : file("${path.module}/../keys/.hetzner.key.pub")
  ssh_key_name   = var.ssh_key_name
  labels         = var.labels
}
